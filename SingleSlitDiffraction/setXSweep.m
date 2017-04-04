%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function generates the line-by-line information for
%   the x-sweeps of the ADI algorithm.
%
%   Inputs: details - structure containing numerical parameters and
%   solution arrays
%
%   Outputs: xsweep - structure containing x-sweep data
%            Nlines - number of x-sweep lines
%
%   Author: Eric Wolf
%
%   Date: March 25, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [xsweep,Nlines] = setXSweep(details)

%Get parameters for brevity below
a = details.a;
delta = details.delta;
x = details.x;
y = details.y;
dx = details.dx;
dt = details.dt;
c = details.c;

Nlines = 0;
for j=1:details.Ny+1
   if abs(details.y(j))<=delta/2
       %Inside the slit itself
       %Just one interval of integration
       Nlines = Nlines+1;
       x1 = -a/2; %Left endpoint location
       x2 = a/2;  %Right endpoint location
       [startInd,endInd,nu1,nu2] = findEndPoints(x1,x2,x,dx,dt,c,details.beta);
       xsweep(Nlines).x1=x1;
       xsweep(Nlines).x2=x2;
       xsweep(Nlines).startInd=startInd;
       xsweep(Nlines).endInd=endInd;
       xsweep(Nlines).nu = details.nux*ones(xsweep(Nlines).endInd-xsweep(Nlines).startInd,1);
       xsweep(Nlines).nu(1)=nu1;
       xsweep(Nlines).nu(end)=nu2;
       xsweep(Nlines).dualInd = j;
       xsweep(Nlines).bdryType1 = 'dirichlet';
       xsweep(Nlines).bdryType2 = 'dirichlet';
       
   elseif delta<abs(details.y(j))
       %On either side of the screen
       %Just one interval of integration
       Nlines = Nlines+1;
       x1 = -details.Lx/2;
       x2 = details.Lx/2;

       xsweep(Nlines).x1=x1;
       xsweep(Nlines).x2=x2;
       xsweep(Nlines).startInd=1;
       xsweep(Nlines).endInd=details.Nx+1;
       xsweep(Nlines).nu = details.nux*ones(xsweep(Nlines).endInd-xsweep(Nlines).startInd,1);
       xsweep(Nlines).dualInd = j;
       xsweep(Nlines).bdryType1 = 'periodic';
       xsweep(Nlines).bdryType2 = 'periodic';
       
       
       
   end
    
end


end