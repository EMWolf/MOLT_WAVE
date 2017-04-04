%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function performs the y-sweep for the ADI algorithm.
%
%   Inputs: details - structure containing numerical parameters and
%   solution arrays
%           ysweep - structure containing y-sweep data
%           NyLines - number of y-sweep lines
%
%   Outputs: details - structure containing numerical parameters and
%   solution arrays
%           ysweep - structure containing x-sweep data
%
%   Author: Eric Wolf
%
%   Date: March 25, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [details,ysweep] = doYSweep(details,ysweep,NyLines)

for n=1:NyLines
   %display(['Y sweep number ',num2str(n)])
   nu = ysweep(n).nu;
   i = ysweep(n).dualInd;
   ind = ysweep(n).startInd:ysweep(n).endInd;
   alpha = details.nuy/details.dy;
   
   I=GF_Quad(details.w(ind,i)',nu);
   switch lower(ysweep(n).bdryType1)
       case {'periodic'}
           BCL = 3;
           IL = I(end);
       case {'dirichlet'}
           BCL = 1;
           IL = 0;
       case {'neumann'}
           BCL = 2;
           IL = 0;
       case {'outflow'}
           BCL = 3;
           ysweep(n).w10=details.w(ind(1),i);
           ysweep(n).s1 = outflowUpdate('quadratic',details.beta,ysweep(n).s1,...
               ysweep(n).w10,ysweep(n).w11,ysweep(n).w12);
           IL = ysweep(n).s1;
           ysweep(n).w12=ysweep(n).w11;
           ysweep(n).w11=ysweep(n).w10;
   end
   switch lower(ysweep(n).bdryType2)
       case {'periodic'}
           BCR = 3;
           IR = I(1);
       case {'dirichlet'}
           BCR = 1;
           IR = 0;
       case {'neumann'}
           BCR = 2;
           IR = 0;
       case {'outflow'}
           BCR = 3;
           ysweep(n).w20=details.w(ind(end),i);
           ysweep(n).s2 = outflowUpdate('quadratic',details.beta,ysweep(n).s2,...
               ysweep(n).w20,ysweep(n).w21,ysweep(n).w22);
           IR = ysweep(n).s2;
           ysweep(n).w22=ysweep(n).w21;
           ysweep(n).w21=ysweep(n).w20;
   end
   
   
   %display(['y sweep number ',num2str(n),' boundry 1 ',ysweep(n).bdryType1, ' boundary 2 ', ysweep(n).bdryType2])
   
   temp = Apply_BC(I,details.nuy,nu(1),nu(end),BCL,BCR,IL,IR);
   
   %temp = I + IL*details.v1y+IR*details.v2y;
   details.z(ind,i)=temp';
   
   %IS = (1/alpha)^2*Soft_Source_y(details,ysweep(n));
   %details.z(ind,i)=details.z(ind,i)+IS';
    
end

end