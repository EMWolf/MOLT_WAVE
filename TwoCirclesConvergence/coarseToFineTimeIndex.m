% Description: Assume we have a course grid and fine grid defined by
% x(ic) = (ic-1)*dxc-Lx/2, dxc = Lx/Ncoarse on the coarse grid,
% x(if) = (if-1)*dxf-Lx/2, dxf = Lx/Nfine on the fine grid,
% such that Nfine/Ncoarse is an integer.
% Assume dt = CFL*dx on each grid, t = (n+1)*dt
% Then given the coarseTimeIndex, this program outputs the corresponding
% fineTimeIndex
function fineTimeIndex = coarseToFineTimeIndex(coarseTimeIndex,Ncoarse,Nfine)

fineTimeIndex = (Nfine/Ncoarse)*(coarseTimeIndex+1)-1;

if isinteger(fineTimeIndex)==0||fineTimeIndex<0
    display('Warning - coarse to fine time index restriction error!')
end

end