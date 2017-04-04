%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This script processes the results of refinement study for 
%   the implicit wave solver on the two circle cavity geometry and
%   determines the empirical order of accuracy.
%
%   Author: Eric Wolf
%   
%   Date: March 30, 2016 (commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



for n=1:Nlevels
dxvec(n) = levels(n).dx;
dyvec(n) = levels(n).dy;
dtvec(n) = levels(n).dt;
logdx(n)=log(levels(n).dx);
err_L2(n) = max(levels(n).error(1,2,:));
log_err_L2(n) = log(err_L2(n));
end

for n=1:Nlevels-1
    order(n) = (log_err_L2(n+1)-log_err_L2(n))/(logdx(n+1)-logdx(n));
end

dxvec = dxvec';
dyvec = dyvec';
dtvec = dtvec';
logdx = logdx';
err_L2 = err_L2';
log_err_L2 = log_err_L2';
order = order';