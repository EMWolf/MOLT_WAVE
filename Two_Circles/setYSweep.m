% This function generates an array of structures, ysweep, 
% for the y-sweep lines, containing data such as line end points, 
% boundary conditions, and embedded boundary information.
% This data structure, along with xsweep, encodes the problem geometry.
% Eric Wolf
% March 28, 2017

function [ysweep,Nlines] = setYSweep(details)

%Get two circles parameter for brevity below
R = details.R;
gamma = details.gamma;
beta = details.beta;
x = details.x;
y = details.y;
dy = details.dy;
dt = details.dt;
c = details.c;

Nlines = 0;
for i=1:details.Nx+1
   if abs(x(i))<(R+gamma)
       %Just one interval of integration
       Nlines = Nlines+1;
       if x(i) <=0
           y1 = -sqrt(R^2-(x(i)+gamma)^2); %Bottom endpoint location
           y2 = sqrt(R^2-(x(i)+gamma)^2);   %Top endpoint location
       else
           y1 = -sqrt(R^2-(x(i)-gamma)^2);
           y2 = sqrt(R^2-(x(i)-gamma)^2);
       end
       [startInd,endInd,nu1,nu2] = findEndPoints(y1,y2,y,dy,dt,c,beta);
       ysweep(Nlines).y1=y1;
       ysweep(Nlines).y2=y2;
       ysweep(Nlines).startInd=startInd;
       ysweep(Nlines).endInd=endInd;
       ysweep(Nlines).nu = details.nuy*ones(ysweep(Nlines).endInd-ysweep(Nlines).startInd,1);
       ysweep(Nlines).nu(1)= nu1;
       ysweep(Nlines).nu(end) = nu2;
       ysweep(Nlines).dualInd = i;
       ysweep(Nlines).bdryType1 = 'dirichlet';
       ysweep(Nlines).bdryType2 = 'dirichlet';
   
   end
    
end


end