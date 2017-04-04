%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: Evaluates a quadratic interpolant using two interior 
%   values and the zero normal derivative at the boundary
%
%   Inputs:
%   ext_pt_dist - distance from the exterior point to the boundary along
%   the normal at which the interpolant will be evaluated
%   norm_pt1_dist - distance from the boundary to the first point along the
%   normal
%   norm_pt2_dist - distance from the boundary to the second point along
%   the normal
%   val_pt1 - value of the function at the first point along the normal
%   val_pt2 - value fo the function at the second point along the normal
%
%   Outputs:
%   val_ext_pt - the interpolated value at the exterior point
%
%   Author: Eric Wolf
%
%   Date: March 30, 2016 (commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function val_ext_pt = evaluateBoundaryInterpolant(ext_pt_dist,...
    norm_pt1_dist,norm_pt2_dist,val_pt1,val_pt2)


val_ext_pt = val_pt1*((ext_pt_dist^2-norm_pt2_dist^2)/(norm_pt1_dist^2-norm_pt2_dist^2))+...
    val_pt2*((norm_pt1_dist^2-ext_pt_dist^2)/(norm_pt1_dist^2-norm_pt2_dist^2));

end