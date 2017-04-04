%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function interpolates from interior grid points onto 
%   a point along the normal through a ghost point.
%
%   Inputs:
%   array_in - array from which values are to be interpolated
%   norm_pt_loc_x - x-coordinate of the point along the normal
%   norm_pt_loc_y - y-coordinate of the point along the normal
%   norm_pt_ind_x - x-index of the interpolation stencil for the
%   point along the normal
%   norm_pt_ind_y - y-index of the interpolation stencil for the
%   point along the normal
%   norm_pt_offset_x - x-index offset for the interpolation stencil in the
%   x-direction (-1, 0 or 1) for the intersection point along the normal
%   (not used with bilinear interpolation)
%   norm_pt_offset_y - y-index offset for the interpolation stencil in the 
%   x-direction (-1, 0 or 1) for the intersection point along the normal
%   (not used with bilinear interpolation)
%   x - vector of the grid point x-coordinates
%   y - vector of the grid point y-coordinates
%   dx - uniform grid spacing in the x-direction (x(j+1)-x(j) = dx)
%   dy - uniform grid spacing in the y-direction (y(k+1)-y(k) = dy)
%
%   Output:
%   val - value interpolated to the given intersection point
%   
%   Author: Eric Wolf
%
%   Date: March 30, 2016 (commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function val = evaluateInteriorInterpolation(array_in,...
    norm_pt_loc_x, norm_pt_loc_y,...
    norm_pt_ind_x, norm_pt_ind_y,...
    norm_pt_offset_x, norm_pt_offset_y,...
    x,y,dx,dy)

val = evaluateBilinearInterpolant(array_in,norm_pt_loc_x,norm_pt_loc_y,...
    norm_pt_ind_x,norm_pt_ind_y,x,y,dx,dy);



end