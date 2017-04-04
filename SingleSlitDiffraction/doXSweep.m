%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function performs the x-sweep for the ADI algorithm.
%
%   Inputs: details - structure containing numerical parameters and
%   solution arrays
%           xsweep - structure containing x-sweep data
%           NxLines - number of x-sweep lines
%
%   Outputs: details - structure containing numerical parameters and
%   solution arrays
%           xsweep - structure containing x-sweep data
%
%   Author: Eric Wolf
%
%   Date: March 25, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [details,xsweep] = doXSweep(details,xsweep,NxLines)

for n=1:NxLines
   nu = xsweep(n).nu;
   j = xsweep(n).dualInd;
   ind = xsweep(n).startInd:xsweep(n).endInd;
   alpha = details.nux/details.dx;
   
   %details.w(j,ind)
   %Perform quadrature in interior points
   I=GF_Quad(details.u1(j,ind),nu);
   
   %Source update
   if details.t<details.sourceDuration
   y = details.y(xsweep(n).dualInd);
   if (details.sourceStart<=y)&&(y<=details.sourceEnd)
   IS = (1/alpha)^2*Soft_Source_x(details,xsweep(n));
   I=I+IS;
   end
   end
   
   %Apply BC
   switch lower(xsweep(n).bdryType1)
       case {'periodic'}
           BCL = 3;
           IL = I(end);
       case {'dirichlet'}
           BCL = 1;
           IL = 0;
       case {'neumann'}
           BCL = 2;
       case {'outflow'}
           BCL = 3;
           xsweep(n).w10 = details.u1(j,ind(1));
           xsweep(n).s1 = outflowUpdate('quadratic',details.beta,xsweep(n).s1,...
               xsweep(n).w10,xsweep(n).w11,xsweep(n).w12);
           IL = xsweep(n).s1;
           xsweep(n).w12=xsweep(n).w11;
           xsweep(n).w11=xsweep(n).w10;
           
   end
   switch lower(xsweep(n).bdryType2)
       case {'periodic'}
           BCR = 3;
           IR = I(1);
       case {'dirichlet'}
           BCR = 1;
           IR = 0;
       case {'neumann'}
           BCR = 2;
       case {'outflow'}
           BCR = 3;
           xsweep(n).w20=details.u1(j,ind(end));
           xsweep(n).s2 = outflowUpdate('quadratic',details.beta,xsweep(n).s2,...
               xsweep(n).w20,xsweep(n).w21,xsweep(n).w22);
           IR = xsweep(n).s2;
           xsweep(n).w22=xsweep(n).w21;
           xsweep(n).w21=xsweep(n).w20;
   end
      
   %Apply BC
   details.w(j,ind)=Apply_BC(I,details.nux,nu(1),nu(end),BCL,BCR,IL,IR);
    %details.w(j,ind) = I+IL*details.v1x+IR*details.v2x; 
end

end