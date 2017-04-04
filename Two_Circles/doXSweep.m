% This function loops through the x-sweep lines and performs the x-sweeps.
% Eric Wolf
% March 28, 2017

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
           xsweep(n).s2 = outflowUpdate('linear',details.beta,xsweep(n).s2,...
               xsweep(n).w20,xsweep(n).w21,xsweep(n).w22);
           IR = xsweep(n).s2;
           xsweep(n).w22=xsweep(n).w21;
           xsweep(n).w21=xsweep(n).w20;
   end
      
   %Apply BC
   details.w(j,ind)=Apply_BC(I,details.nux,nu(1),nu(end),BCL,BCR,IL,IR);
   
end

end