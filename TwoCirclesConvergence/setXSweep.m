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
%   Date: March 23, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [xsweep,Nlines] = setXSweep(details)

%Get two circles parameter for brevity below
R = details.R;
gamma = details.gamma;
beta = details.beta;
x = details.x;
y = details.y;
dx = details.dx;
dt = details.dt;
c = details.c;

Nlines = 0;
for j=1:details.Ny+1
   if abs(details.y(j))<sqrt(R^2-gamma^2)
       %Just one interval of integration
       Nlines = Nlines+1;
       x1 = -sqrt(R^2-y(j)^2)-gamma; %Left endpoint location
       x2 = sqrt(R^2-y(j)^2)+gamma;  %Right endpoint location
       [startInd,endInd,nu1,nu2] = findEndPoints(x1,x2,x,dx,dt,c,beta);
       xsweep(Nlines).x1=x1;
       xsweep(Nlines).x2=x2;
       xsweep(Nlines).startInd=startInd;
       xsweep(Nlines).endInd=endInd;
       xsweep(Nlines).nu = details.nux*ones(xsweep(Nlines).endInd-xsweep(Nlines).startInd,1);
       xsweep(Nlines).nu(1)= nu1;
       xsweep(Nlines).nu(end) = nu2;
       xsweep(Nlines).dualInd = j;
       xsweep(Nlines).bdryType1 = 'dirichlet';
       xsweep(Nlines).bdryType2 = 'dirichlet';
       
   elseif (sqrt(R^2-gamma^2)<=abs(details.y(j)))&&(abs(details.y(j))<R)
       %Two intervals of integration
       %Left interval
       Nlines = Nlines+1;
       x1 = -sqrt(R^2-y(j)^2)-gamma;
       x2 = sqrt(R^2-y(j)^2)-gamma;
       [startInd,endInd,nu1,nu2] = findEndPoints(x1,x2,x,dx,dt,c,beta);
       xsweep(Nlines).x1=x1;
       xsweep(Nlines).x2=x2;
       xsweep(Nlines).startInd=startInd;
       xsweep(Nlines).endInd=endInd;
       xsweep(Nlines).nu = details.nux*ones(xsweep(Nlines).endInd-xsweep(Nlines).startInd,1);
       xsweep(Nlines).nu(1)= nu1;
       xsweep(Nlines).nu(end) = nu2;
       xsweep(Nlines).dualInd = j;
       xsweep(Nlines).bdryType1 = 'dirichlet';
       xsweep(Nlines).bdryType2 = 'dirichlet';
       
       %Right interval
       Nlines = Nlines+1;
       x1 = -sqrt(R^2-y(j)^2)+gamma;
       x2 = sqrt(R^2-y(j)^2)+gamma;
       [startInd,endInd,nu1,nu2] = findEndPoints(x1,x2,x,dx,dt,c,beta);
       xsweep(Nlines).x1=x1;
       xsweep(Nlines).x2=x2;
       xsweep(Nlines).startInd=startInd;
       xsweep(Nlines).endInd=endInd;
       xsweep(Nlines).nu = details.nux*ones(xsweep(Nlines).endInd-xsweep(Nlines).startInd,1);
       xsweep(Nlines).nu(1)= nu1;
       xsweep(Nlines).nu(end) = nu2;
       xsweep(Nlines).dualInd = j;
       xsweep(Nlines).bdryType1 = 'dirichlet';
       xsweep(Nlines).bdryType2 = 'dirichlet';
       
       
   end
    
end


end