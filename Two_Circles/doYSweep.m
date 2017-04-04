% This function loops through the y-sweep lines and performs the y-sweeps.
% Eric Wolf
% March 28, 2017

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
   
  
   
   temp = Apply_BC(I,details.nuy,nu(1),nu(end),BCL,BCR,IL,IR);
   details.z(ind,i)=temp';
   

    
end

end