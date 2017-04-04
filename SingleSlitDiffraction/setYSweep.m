%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function generates the line-by-line information for
%   the y-sweeps of the ADI algorithm.
%
%   Inputs: details - structure containing numerical parameters and
%   solution arrays
%
%   Outputs: ysweep - structure containing y-sweep data
%            Nlines - number of y-sweep lines
%
%   Author: Eric Wolf
%
%   Date: March 25, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ysweep,Nlines] = setYSweep(details)

%Get parameters for brevity below
a = details.a;
delta = details.delta;
x = details.x;
y = details.y;
dy = details.dy;
dt = details.dt;
c = details.c;

Nlines = 0;
for i=1:details.Nx+1
   if abs(x(i))<a/2
       %Passing through the slit
       %Just one interval of integration
       Nlines = Nlines+1;
       y1 = -details.Ly/2;
       y2 = details.Ly/2;
       %[startInd,endInd,nuB,nuT] = findEndPoints(yB,yT,y,dy,dt,c);
       ysweep(Nlines).y1=y1;
       ysweep(Nlines).y2=y2;
       ysweep(Nlines).startInd=1;
       ysweep(Nlines).endInd=details.Ny+1;
       ysweep(Nlines).nu = details.nuy*ones(ysweep(Nlines).endInd-ysweep(Nlines).startInd,1);
       ysweep(Nlines).dualInd = i;
       ysweep(Nlines).bdryType1 = 'outflow';
       ysweep(Nlines).bdryType2 = 'outflow';
       ysweep(Nlines).s1=0;
       ysweep(Nlines).s2=0;
       ysweep(Nlines).w10=0;
       ysweep(Nlines).w11=0;
       ysweep(Nlines).w12=0;
       ysweep(Nlines).w20=0;
       ysweep(Nlines).w21=0;
       ysweep(Nlines).w22=0;
       
   else
       %Partitioned by the screen
       %Two intervals of integration
       %Bottom
       Nlines = Nlines + 1;
       y1 = -details.Ly/2;
       y2 = -delta/2;
       [startInd,endInd,nu1,nu2] = findEndPoints(y1,y2,y,dy,dt,c,details.beta);
       ysweep(Nlines).loc1=y1;
       ysweep(Nlines).loc2=y2;
       ysweep(Nlines).startInd=1;
       ysweep(Nlines).endInd=endInd;
       ysweep(Nlines).nu = details.nuy*ones(ysweep(Nlines).endInd-ysweep(Nlines).startInd,1);
       ysweep(Nlines).nu(end)=nu2;
       ysweep(Nlines).dualInd = i;
       ysweep(Nlines).bdryType1 = 'outflow';
       ysweep(Nlines).bdryType2 = 'dirichlet';
       ysweep(Nlines).s1=0;
       ysweep(Nlines).w10=0;
       ysweep(Nlines).w11=0;
       ysweep(Nlines).w12=0;
       
       %Bottom
       Nlines = Nlines + 1;
       y1 = delta/2;
       y2 = details.Ly/2;
       [startInd,endInd,nu1,nu2] = findEndPoints(y1,y2,y,dy,dt,c,details.beta);
       ysweep(Nlines).y1=y1;
       ysweep(Nlines).y2=y2;
       ysweep(Nlines).startInd=startInd;
       ysweep(Nlines).endInd=details.Ny+1;
       ysweep(Nlines).nu = details.nuy*ones(ysweep(Nlines).endInd-ysweep(Nlines).startInd,1);
       ysweep(Nlines).nu(1)=nu1;
       ysweep(Nlines).dualInd = i;
       ysweep(Nlines).bdryType1 = 'dirichlet';
       ysweep(Nlines).bdryType2 = 'outflow';
       ysweep(Nlines).s2=0;
       ysweep(Nlines).w20=0;
       ysweep(Nlines).w21=0;
       ysweep(Nlines).w22=0;
       
   end
    
end


end