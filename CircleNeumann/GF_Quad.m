function I = GF_Quad(u,nu)
% 
% ______________________________Description______________________________ %
% Performs parabolic (compact Simpson's rule) quadrature on the expression
% 
%           I[u](x) = \alpha \int_a^b  u(y) e^{-\alpha|x-y|}dy,
% 
% using N+1 arbitrarily spaced points.
% 
% ________________________________Inputs_________________________________ %
% u   a vector of length N+1, evaluated at N+1 arbitrarily spaced x points
% nu  a vector of length N, where nu_j = alpha*(x_{j} - x_{j-1})
% 
% ________________________________Outputs________________________________ %
% I   a vector of length N+1, evaluated at N+1 arbitrarily spaced x points
% 
% __________________________Problem Description__________________________ %
% Let the collocation points be labelled as {a=x_0,x_1,...,x_N,x_N=b},
% where h_j =x_j-x_{j-1} may vary depending on j. Now, we decompose the
% integral into I = IL + IR, each satisfying an initial value problem.
% However, it is easier to start with the exponential recurrence relations
% 
%  IL_j     = d_j IL_{j-1} + nu_j int_0^1 u(x_{j  }-z h_j)e^{-nu_j z}dz,
%  IR_{j-1} = d_j IR_{j  } + nu_j int_0^1 u(x_{j-1}+z h_j)e^{-nu_j z}dz,
% 
% where IL_0 = IR_N = 0, and
% 
% d_j = e^{-nu_j}.
% 
% These expressions are still exact.
% 
% _________________________Algorithm Description_________________________ %
% Now, upon replacing u with a quadratic interpolant,
% 
% p(z) = (1-z)u_{j-1} + z u_j + z(z-1)/2 * h_j^2u"( xi_j )
% 
% where
% 
% h_j^2u"(xi_j) = A_j u_{j-1} + B_j u_j + C_j u_{j+1}.
% 
% At x = a and b, h_j^2 u" is taken from a single-sided stencil. Now, we
% integrate the expression analytically, and get
% 
% IL_j = d_j IL_{j-1} +a_j u_ j    +b_j u_{j-1} +c_j h_j^2u"( xi_j ),
% IR_j = d_j IR_{j+1} +b_j u_{j+1} +a_j u_j     +c_j h_j^2u"( xi_j ),
% 
% where
% 
% a = nu int_0^1      (1-z)e^{-nu z} dz  =  1-(1-d)/nu
% b = nu int_0^1         z e^{-nu z} dz  = -d+(1-d)/nu
% c = nu int_0^1 (z/2)(1-z)e^{-nu z} dz  = (1/2)( 2(1-d)/nu^2 - (1+d)/nu ).
% 
% _______________________________________________________________________ %

I	= 0*u;
N	= length(u)-1;
if length(nu)==1,	nu(1:N)	= nu;	end
v	= 0*u;
IL	= 0;
IR	= 0;

% __________________Coefficients and quadrature strategy_________________ %
d	= exp(-nu);
a	=  1-(1-d)./nu;
b	= -d+(1-d)./nu;
c	= 1/2*(2*(1-d)./nu.^2 -(1+d)./nu);

% ______________________Compute v = (h_j/nu_j)^2 u"______________________ %
p	= nu(2)/nu(1);
q	= nu(3)/nu(1);
a0	= (1+(2+p)/(1+p+q))/(1+p);
a1	=-(1+(2+p)/(p+q)  )/ p;
a2	= (1+(2+p)/ q     )/(p+p^2);
a3	=-(2+p            )/((1+p+q)*q*(p+q));
%v(1)= 2/nu(1)^2*( a0*u(1   )+a1*u(2)+a2*u(3  )+a3*u(4  ) );
v(1)= 1/nu(1)^2*( 2*u(1   )-5*u(2)+4*u(3  )-u(4  ) );
for j = 2:N
	v(j)= 2*( (u(j+1)-u(j))/nu(j)-(u(j)-u(j-1))/nu(j-1) )/(nu(j)+nu(j-1));
end
p	= nu(N-1)/nu(N);
q	= nu(N-2)/nu(N);
a0	= (1+(2+p)/(1+p+q))/(1+p);
a1	=-(1+(2+p)/(p+q)  )/ p;
a2	= (1+(2+p)/ q     )/(p+p^2);
a3	=-(2+p            )/((1+p+q)*q*(p+q));
%v(N+1)= 2/nu(N)^2*( a0*u(N+1)+a1*u(N)+a2*u(N-1)+a3*u(N-2) );
v(N+1)= 1/nu(N)^2*( 2*u(N+1)-5*u(N)+4*u(N-1)-u(N-2) );

% _______________________Fast matrix-vector product______________________ %
for j = 1:N
	m = N+1-j;
	IL	= d(j)*IL+a(j)*u(j+1)+b(j)*u(j  )+c(j)*nu(j)^2*v(j+1);
	I(j+1)=I(j+1)+ IL;
	IR	= d(m)*IR+a(m)*u(m  )+b(m)*u(m+1)+c(m)*nu(m)^2*v(m);
	I(m)=I(m)+ IR;
end

end