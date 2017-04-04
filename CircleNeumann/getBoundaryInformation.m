%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: Returns data necessary for the interpolation of boundary 
%   data to the exterior endpoints needed in the x- and y-sweeps using 
%   quadratic interpolation with two interior data points and zero normal 
%   derivative on the boundary.
%
%
%   Inputs:
%   x_ind - x-index of the exterior endpoint
%   y_ind - y-index of the exterior endpoint
%   x - vector of the grid point x-coordinates
%   y - vector of the grid point y-coordinates
%   dx - uniform grid spacing in the x-direction (x(j+1)-x(j) = dx)
%   dy - uniform grid spacing in the y-direction (y(k+1)-y(k) = dy)
%   R - radius of the circular domain (centered at the origin)
%
%
%   Outputs:
%   norm_pt1_loc_x - x-coordinate of the first point along the normal
%   norm_pt1_loc_y - y-coordinate of the first point along the normal
%   norm_pt1_ind_x - x-index of the interpolation stencil for the first
%   point along the normal
%   norm_pt1_ind_y - y-index of the the interpolation stencil for the first
%   point along the normal
%   norm_pt1_offset_x - x-index offset for the interpolation stencil in the
%   x-direction (-1, 0 or 1) for the first point along the normal
%   norm_pt1_offset_y - y-index offset for the interpolation stencil in the
%   x-direction (-1, 0 or 1) for the first point along the normal
%   norm_pt1_dist - distance from the boundary to the first point along the
%   normal in units of dx
%   norm_pt2_loc_x - x-coordinate of the second point along the normal
%   norm_pt2_loc_y - y-coordinate of the second point along the normal
%   norm_pt2_ind_x - x-index of the interpolation stencil for the second
%   point along the normal
%   norm_pt2_ind_y - y-index of the the interpolation stencil for the
%   second point along the normal
%   norm_pt2_offset_x - x-index offset for the interpolation stencil in the
%   x-direction (-1, 0 or 1) for the second point along the normal
%   norm_pt2_offset_y - y-index offset for the interpolation stencil in the
%   x-direction (-1, 0 or 1) for the second point along the normal
%   norm_pt2_dist - distance from the boundary to the second point along the
%   normal in units of dx
%   ext_pt_dist - distance from the boundary to the exterior point along
%   the normal in units of dx
%
%   Author: Eric Wolf
%
%   Date: March 30, 2016 (commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [norm_pt1_loc_x, norm_pt1_loc_y,...
    norm_pt1_ind_x, norm_pt1_ind_y,...
    norm_pt1_offset_x,norm_pt1_offset_y,...
    norm_pt1_dist,...
    norm_pt2_loc_x, norm_pt2_loc_y,...
    norm_pt2_ind_x, norm_pt2_ind_y,...
    norm_pt2_offset_x,norm_pt2_offset_y,...
    norm_pt2_dist,...
    ext_pt_dist] = getBoundaryInformation(x_ind,y_ind,x,y,dx,dy,R)

%Set fixed distance from boundary to interpolation points
dsI = sqrt(2)*dx;

ext_pt_dist = sqrt(x(x_ind)^2+y(y_ind)^2)-R;

norm_pt1_loc_x = (R-dsI)/(R+ext_pt_dist)*x(x_ind);
norm_pt2_loc_x = (R-2*dsI)/(R+ext_pt_dist)*x(x_ind);

norm_pt1_loc_y = (R-dsI)/(R+ext_pt_dist)*y(y_ind);
norm_pt2_loc_y = (R-2*dsI)/(R+ext_pt_dist)*y(y_ind);

norm_pt1_ind_x = floor((norm_pt1_loc_x-x(1))/dx)+1;
norm_pt2_ind_x = floor((norm_pt2_loc_x-x(1))/dx)+1;

norm_pt1_ind_y = floor((norm_pt1_loc_y-y(1))/dy)+1;
norm_pt2_ind_y = floor((norm_pt2_loc_y-y(1))/dy)+1;

bool1 = checkInteriorCell(norm_pt1_ind_x,norm_pt1_ind_y,x,y,R);
bool2 = checkInteriorCell(norm_pt2_ind_x,norm_pt2_ind_y,x,y,R);

if (bool1==0)||(bool2==0)
    display('Warning, interpolation cell lies outside domain!')
end

norm_pt1_offset_x = 0;
norm_pt1_offset_y = 1;

norm_pt2_offset_x = 0;
norm_pt2_offset_y = 1;



norm_pt1_dist = R - sqrt(norm_pt1_loc_x^2+norm_pt1_loc_y^2);
norm_pt2_dist = R - sqrt(norm_pt2_loc_x^2+norm_pt2_loc_y^2);





end