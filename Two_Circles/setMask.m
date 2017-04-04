% This function creates a mask array to support the embedded boundary
% method. The mask array contains entries corresponding to the Cartesian
% grid, and contains ones at interior (active) grid points and NaNs at
% exterior (inactive) grid points.
% Eric Wolf
% March 28, 2017

function mask = setMask(details,NxLines,xsweep)

mask = zeros(details.Ny+1,details.Nx+1);

mask(1:end,1:end) = nan;

for n = 1:NxLines
    for i=xsweep(n).startInd+1:xsweep(n).endInd-1
        mask(xsweep(n).dualInd,i) = 1;
    end
end


end

