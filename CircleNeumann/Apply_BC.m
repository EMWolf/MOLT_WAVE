function J = Apply_BC(I,nu,nuL,nuR,BCL,BCR,IL,IR)
% 
% ______________________________Description______________________________ %
% Add the boundary integral correction to the integral
% 
%           I[u](x) = \alpha \int_a^b  u(y) e^{-\alpha|x-y|}dy,
% 
% constructed from the program GF_Quad.m. This program returns
% 
%           J[u](x) = I[u](x) + A e^{-\alpha(x-a)} + B e^{-\alpha(b-x)}.
% 
% The coefficients are determined by the boundary conditions at x=a and
% x=b. Currently, this program supports Dirichlet Neumann, and periodic
% BCs, and can also implement hard source outflow BC's, in which case A and
% B are given explicitly.
% 
% ________________________________Inputs_________________________________ %
% I   a vector of length M,
% nu  = alpha*dx, the value of nu at the interior points
% nuL = alpha*(x_1-x_0), the value of nu at the left endpoint
% nuR = alpha*(x_{N+2}-x_{N+1}), the value of nu at the right endpoint
% 
% ________________________________Outputs________________________________ %
% J   a vector of length M, evaluated at N+1 evenly spaced x points
% BCL = determines left  BC
% BCR = determines right BC
% IL  = specify value of I or dx*I' at x=a. Set to 0 for homogeneous BCs.
% IR  = specify value of I or dx*I' at x=b. Set to 0 for homogeneous BCs.
%  1 = Dirichlet, 2 = Neumann, 3 Hard 4 = periodic
% 
% _________________________Algorithm Description_________________________ %
% Consider the time-centered second order MOL^T solution, using the
% trapezoidal rule (i.e., GF_Quad) to perform quadrature. Then, a Lax
% correction is needed, and so the scheme is of the form
% 
%  (1-a2)(u^{n+1}+u^{n-1})+2 a2u^n = I +Ae^{-alpha(x-a)}+Be^{-alpha(b-x)}
%      
% Evaluating the left hand side at x = a, and b determines IL, and IR.
% _______________________________________________________________________ %



if nargin<3, nuL = nu; nuR = nu; end  %equispaced points only

% _____________Compute coefficients and initialize variables_____________ %
M	= length(I);
N	= M-3;
d	= exp(-nu);
dL	= exp(-nuL);
dR	= exp(-nuR);
c	= d^N*dL*dR;
zL	= [1 dL*d.^(0:N   ) c];
zR	= [c dR*d.^(N:-1:0) 1];
%zL = zL*dL;
%zR = zR*dR;
%temp = zL;
%zL = zR;
%zR = temp;
% _____________________________Implement BCs_____________________________ %
if or(BCL ==4,BCR ==4)					%periodic BC's
	K = GF_Quad(u,-nu);
	J = (I-c*K)/(1-c);
else

if BCL ==3								%hard source on left
	A = IL;
	if BCR == 3
		B = IR;							%hard source-hard source
	elseif BCR == 2
		B = IR/nu + I(M) + A*c;			%hard source-Neumann
	else
		B = IR    - I(M) - A*c;			%hard source-Dirichlet
	end

elseif BCL ==2							%Neumann on left
	if BCR == 3							%Neumann-hard source
		B	= IR;
		A	= -IL/nu + I(1) + B*c;
	elseif BCR == 2						%Neumann-Neumann
		IL	= I(1)-IL/nu;				%here, IL = dx*I'(a).
		IR	= I(M)+IR/nu;				%here, IR = dx*I'(b).
		A	= (IL+c*IR)/(1-c^2);
		B	= (IR+c*IL)/(1-c^2);
	else								%Neumann-Dirichlet
		IL	= -1/nu*IL - I(1);			%here, IL = dx*I'(a).
		IR	= IR - I(M);
		A	= (IL-c*IR)/(1-c^2);
		B	= (IR-c*IL)/(1-c^2);
	end

else									%Dirichlet on left
	if BCR == 3							%Dirichlet-hard source
		B	= IR;
		A	= -1/nu*IL - I(1) - B*c;
	elseif BCR == 2						%Dirichlet-Neumann
		IL = IL - I(1);
		IR =  1/nu*IR - I(M);			%here, IR = dx*I'(b).
		A = (IL-c*IR)/(1-c^2);
		B = (IR-c*IL)/(1-c^2);
	else								%Dirichlet-Dirichlet
		IL = IL - I(1);
		IR = IR - I(M);
		A = (IL-c*IR)/(1-c^2);
		B = (IR-c*IL)/(1-c^2);
	end

end

	J = I+A*zL+B*zR;

end