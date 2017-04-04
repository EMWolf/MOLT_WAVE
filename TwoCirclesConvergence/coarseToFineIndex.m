% Description: Assume we have a course grid and fine grid defined by
% x(ic) = (ic-1)*dxc-Lx/2, dxc = Lx/Ncoarse on the coarse grid,
% x(if) = (if-1)*dxf-Lx/2, dxf = Lx/Nfine on the fine grid,
% such that Nfine/Ncoarse is an integer.
% Then, given an index on the coarse grid, coarseIndex, this function
% determines the corresponding index on the fine grid, fineIndex.

function fineIndex = coarseToFineIndex(coarseIndex,Ncoarse,Nfine)

fineIndex = (Nfine/Ncoarse)*(coarseIndex-1)+1;


end