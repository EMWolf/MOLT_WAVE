%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function computes the error of the numerical solution
%   compared to the reference solution.
%
%   Inputs: results - structure containing numerical parameters and error
%           arrays
%           details - structure containing numerical parameters and
%           solution arrays
%           mask - array containing values of 1 corresponding to interior
%   grid points and NaN corresponding to exterior grid points
%           n - current time step index
%           reference - structure containing numerical parameters and
%   reference solution array
%
%   Outputs: results - structure containing numerical parameters and error
%           arrays
%
%   Author: Eric Wolf
%
%   Date: March 23, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function results = computeError(results,details,mask,n,reference)

if details.dx<details.dy
    Ncoarse = details.Nx;
else
    Ncoarse = details.Ny;
end

if reference.dx<reference.dy
    Nfine = reference.Nx;
else
    Nfine = reference.Ny;
end


%Compute error against a reference solution
temp = nan*ones(details.Ny+1,details.Nx+1);
d1=0;
d2=0;
m=0;
for j = 1:details.Ny+1
for i = 1:details.Nx+1
    if mask(j,i)==1;
    iRef = coarseToFineIndex(i,details.Nx,reference.Nx);
    jRef = coarseToFineIndex(j,details.Ny,reference.Ny);
    nRef = coarseToFineTimeIndex(n,...
        Ncoarse,...
        Nfine)-...
        reference.startSaveIndex+1;
    temp(j,i) = abs(details.u(j,i)-reference.uRef(nRef,jRef,iRef));
    %if sqrt((details.x(i)-results.xCusp)^2+(details.y(j)-results.yCusp)^2)>.1&&...
    %     sqrt((details.x(i)-results.xCusp)^2+(details.y(j)+results.yCusp)^2)>.1
    d1 = d1 + details.dx*details.dy*temp(j,i);
    d2 = d2 + details.dx*details.dy*temp(j,i)^2;
    m = max(m,temp(j,i));
    if temp(j,i)==m
        results.maxErrorLoc1(:,n)=[j i];
    end
    %end
    end
end
end

results.error(1,1,n)=d1;
results.error(1,2,n)=sqrt(d2);
results.error(1,3,n)=m;

if max(max(temp))>max(max(results.errorPlot))
    results.errorPlot = temp;
end

end