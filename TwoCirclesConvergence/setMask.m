%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function generates a mask array containing values of
%   1 corresponding to interior grid points and NaN corresponding to
%   exterior grid points.
%   
%   Inputs: details - structure containing numerical parameters and
%   solution arrays
%           NxLines - number of lines in the x-direction
%           xsweep - structure containing information on the x-sweeps
%
%   Outputs: mask - array containing values of 1 corresponding to interior
%   grid points and NaN corresponding to exterior grid points
%
%   Author: Eric Wolf
%
%   Date: March 23, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function mask = setMask(details,NxLines,xsweep)

mask = zeros(details.Ny+1,details.Nx+1);

mask(1:end,1:end) = nan;

for n = 1:NxLines
    for i=xsweep(n).startInd+1:xsweep(n).endInd-1
        mask(xsweep(n).dualInd,i) = 1;
    end
end


end

