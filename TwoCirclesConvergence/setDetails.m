%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function initializes the details structure,
%   containing relevant numerical parameters and solution arrays.
%
%   Inputs: T - final simulation time
%           Nx - number of cells in the x-direction
%           Ny - number of cells in the y-direction
%           CFL - CFL number, determining time step size
%
%   Outputs: details - structure containing numerical parameters and
%   solution array
%
%   Author: Eric Wolf
%
%   Date: March 23, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function details = setDetails(T,Nx,Ny,CFL)

% ------------------------Two circles geometry parameters---------------- %
details.R = 0.3;    %Radius of each circle
details.gamma = 0.2;    %Displacement of center from the origin along the x-axis

% --------
details.Lx = 2*(details.R+details.gamma)+0.05;%1.1; %Width of domain in x-direction
details.Ly = 2*details.R+0.05; %1.1; %Width of domain in y-direction
details.Nx = Nx;   %Number of subintervals in x-direction
details.Ny = Ny;    %Number of subintervals in y-direction
details.CFL = CFL;   
details.c = 1;    %Wave speed
details.T = T;    %Final simulation time
details.t = 0;  %Initial time

% --------------------Define numerical parameters------------------------ %
details.dx = details.Lx/details.Nx;
details.dy = details.Ly/details.Ny;
details.dt = details.CFL*min(details.dx,details.dy)/details.c;
details.t = details.dt;
details.Nt = round(details.T/details.dt);				%Total number of time steps

details.x = (0:details.Nx)'*details.dx-details.Lx/2;	%xj = j*dx, 1<=j<=Nx+1
details.y = (0:details.Ny)'*details.dy-details.Ly/2;	%yj = j*dy, 1<=j<=Ny+1
details.timeVec = details.dt*(2:1:(details.Nt+1));

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

%IC argument: K*(x^2+y^2)

K = (pi/2)/(0.9*details.gamma)^2;

for i=1:details.Nx+1
    for j=1:details.Ny+1
        if details.x(i)>0
            r = sqrt((details.x(i)-details.gamma)^2+details.y(j)^2);
            %theta = (pi/2)*((details.x(i)-details.gamma)^2+details.y(j)^2)/(0.9*(details.gamma));
            if K*r^2<pi/2
                details.u0(j,i)=cos(K*r^2)^6;
                details.u1(j,i)=details.u0(j,i)+details.dt^2/2*details.c^2*twoCirclesLaplacian(r,K);
            end
        else
            r = sqrt((details.x(i)+details.gamma)^2+details.y(j)^2);
            %theta = (pi/2)*((details.x(i)+details.gamma)^2+details.y(j)^2)/(0.9*(details.gamma));
            if K*r^2<pi/2
                details.u0(j,i)=-cos(K*r^2)^6;
                details.u1(j,i)=details.u0(j,i)-details.dt^2/2*details.c^2*twoCirclesLaplacian(r,K);
            end
        end
    end
end

%Additional solution arrays
details.u  = zeros(details.Ny+1,details.Nx+1);
details.w  = zeros(details.Ny+1,details.Nx+1);			%w is a temp vector for the 1st ADI stage
details.z  = zeros(details.Ny+1,details.Nx+1);				%z is a temp vector for the 2nd ADI stage
details.maxu = 0;




end