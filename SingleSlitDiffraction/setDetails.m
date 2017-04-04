%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function initializes the details structure,
%   containing relevant numerical parameters and solution arrays.
%
%   Inputs: none
%
%   Outputs: details - structure containing numerical parameters and
%   solution array
%
%   Author: Eric Wolf
%
%   Date: March 23, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function details = setDetails()

% --------
details.Lx = 1; %Width of domain in x-direction
details.Ly = 1; %Width of domain in y-direction
details.Nx = 200;   %Number of subintervals in x-direction
details.Ny = 200;   %Number of subintervals in y-direction
details.CFL = 2;    
details.c = 1;    %Wave speed
details.T = 2;    %Final simulation time
details.t = 0;  %Initial time

% --------------------Define numerical parameters------------------------ %
details.dx = details.Lx/details.Nx;
details.dy = details.Ly/details.Ny;
details.dt = details.CFL*min(details.dx,details.dy)/details.c;
details.t = details.dt;
details.Nt = round(details.T/details.dt);				%Total number of time steps

details.x = (0:details.Nx)'*details.dx-details.Lx/2;	%xj = j*dx, 1<=j<=Nx+1
details.y = (0:details.Ny)'*details.dy-details.Ly/2;	%yj = j*dy, 1<=j<=Ny+1
% ------------------------Slit geometry---------------- %
details.a = 0.1;    %Aperature width - slit extends from x=-a/2 to x=a/2
details.delta = 0.001;    %Screen thickness - screen extends from y=-delta/2 to y=delta/2

% -------------------------Incident Plane Wave----------------------------%
details.kInc = 2*pi/details.a;
%details.kInc = 2*pi/(40*details.dx);
details.sourcePeriod = 2*pi/(details.c*details.kInc);
details.angleInc = pi/2;

%details.sourceStart = 0.1;
%details.sourceEnd = 0.2;
details.sourceStart = -0.2;
details.sourceEnd = -0.1;
details.sourceWidth = details.sourceEnd-details.sourceStart;
details.sourceDuration = 2;
details.sourceRampTime = 0.2;



%---------Numerical Parameters for implicit solver--------%
details.beta = 2;
details.nux = details.beta*details.dx/(details.c*details.dt);		%nu = alpha*dx = sqrt(2)*dx/(c*dt)
details.ex  = exp(-details.nux);

details.v1x = details.ex.^(0:details.Nx);
details.v2x = fliplr(details.v1x);

details.nuy = details.beta*details.dy/(details.c*details.dt);		%nu = alpha*dy = sqrt(2)*dy/(c*dt)
details.ey  = exp(-details.nuy);

details.v1y = details.ey.^(0:details.Ny);
details.v2y = fliplr(details.v1y);

% --------------------Initialize solution vectors------------------------ %
details.u0 = zeros(details.Ny+1,details.Nx+1);
details.u1 = zeros(details.Ny+1,details.Nx+1);


details.u  = zeros(details.Ny+1,details.Nx+1);
details.w  = zeros(details.Ny+1,details.Nx+1);			%w is a temp vector for the 1st ADI stage
details.z  = zeros(details.Ny+1,details.Nx+1);				%z is a temp vector for the 2nd ADI stage
details.maxu = 0;




end