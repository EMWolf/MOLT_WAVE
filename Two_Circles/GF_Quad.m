function I = GF_Quad(u,nu)
% 
% ______________________________Description______________________________ %
% Performs parabolic quadrature on the expression
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
% Let the collocation points be labelled as {a=x_0,x_1,...,x_N,x_{N+1}=b},
% where h_j =x_j-x_{j-1} varies depending on j. Now, we decompose the
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
% h_j^2u"(xi_j) = A_j u_{j-2} + B_j (u_{j-1}+u_j) + C_j u_{j+1}.
% 
% At x = a and b, h_j^2 u" is taken from a smaller stencil. Now, we
% integrate the expression analytically, and get
% 
% IL_{j  } = d_j IL_{j-1} +a_j u_j +b_j u_{j-1} +c_j h_j^2u"( xi_j ),
% IR_{j-1} = d_j IR_{j  } +b_j u_j +a_j u_{j-1} +c_j h_j^2u"( xi_j ),
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
v	= 0*u(1:N);
IL	= 0*u;
IR	= 0*u;

% __________________Coefficients and quadrature strategy_________________ %
d	= exp(-nu);
a	=  1-(1-d)./nu;
b	= -d+(1-d)./nu;
c	= 1/2*(2*(1-d)./nu.^2 -(1+d)./nu);

% __________________________Compute v = h_j^2u"__________________________ %
% L	= nu(2)/nu(1);
% r	= (nu(2)+nu(3))/nu(1);
% a1	= (1+2*r)     /((r-L)*(L+1)*L);
% a2	= (3+2*L+2*r)/(       (L+1)*(1+r));
% a3	= -(2*r+2*L+1)/(         r *L);
% a4	= -(1+2*L)     /((r-L)*(r+1)*r);
% v(1)= a2*u(1) +a3*u(2) + a1*u(3) + a4*u(4);
r	= nu(2)/nu(1);
v(1)= 2/(r+r^2)*( u(3  ) - (1+r)*u(2) + r*u(1  ) );
for j = 2:N-1
	q1	= 1+2*nu(j-1)/nu(j);
	q3	= 1+2*nu(j+1)/nu(j);
	q2	= (q1+q3)/2;
	r	= q2*(q1*q3-1);
	v(j)= 4/r*( q1*u(j+2) - q2*u(j+1) - q2*u(j) + q3*u(j-1) );
% 	L	= nu(j-1)/nu(j);
% 	r	= nu(j+1)/nu(j);
% 	a1	= (1+2*r)     /((1+L+r)*(L+1)*L);
% 	a2	= (2*L-2*r-1)/(         (r+1)*L);
% 	a3	= (2*r-2*L-1)/(         (L+1)*r);
% 	a4	= (1+2*L)     /((1+r+L)*(r+1)*r);
% 	v(j)= a1*u(j-1) +a2*u(j) + a3*u(j+1) + a4*u(j+2);
end
r	= nu(N-1)/nu(N);
v(N)= 2/(r+r^2)*( u(N-1) - (1+r)*u(N) + r*u(N+1) );

% _______________________Fast matrix-vector product______________________ %
for j = 1:N
	m = N+1-j;
	IL(j+1)	= d(j)*IL(j  )+a(j)*u(j+1)+b(j)*u(j  )+c(j)*v(j);
	IR(m  )	= d(m)*IR(m+1)+a(m)*u(m  )+b(m)*u(m+1)+c(m)*v(m);
end

I	= IL+IR;
end