%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: Evaluates the bilinear interpolant for the points ordered
%   counter clockwise as 
%   1. (y_cell,x_cell), 2. (y_cell,x_cell+1), 3. (y_cell+1,x_cell+1), 
%   4. (y_cell+1,x_cell) as evaluated at location (x_loc,y_loc)
%
%
%   Inputs:
%   array_in - the array from which values are to be interpolated
%   x_loc - the x-coordinate of the evaluation point for the interpolant
%   y_loc - the y-coordinate of the evaluation point for the interpolant
%   x_cell - the x-index of the interpolation cell
%   y_cell - the y-index of the interpolation cell
%   x - vector of the grid point x-coordinates
%   y - vector of the grid point y-coordinates
%   dx - uniform grid spacing in the x-direction (x(j+1)-x(j) = dx)
%   dy - uniform grid spacing in the y-direction (y(k+1)-y(k) = dy)
%
%   Outputs:
%   interpolated_value - the value of the bilinear interpolant evaluated at
%   location (x_loc,y_loc)
%
%   Author: Eric Wolf
%
%   Date: March 30, 2016 (commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function interpolated_value = evaluateBilinearInterpolant(...
    array_in,...
    x_loc,y_loc,...
    x_cell,y_cell,...
    x,y,...
    dx,dy)

weight1 = (x(x_cell+1)-x_loc)*(y(y_cell+1)-y_loc)/(dx*dy);
weight2 = (x_loc-x(x_cell))*(y(y_cell+1)-y_loc)/(dx*dy);
weight3 = (x_loc-x(x_cell))*(y_loc-y(y_cell))/(dx*dy);
weight4 = (x(x_cell+1)-x_loc)*(y_loc-y(y_cell))/(dx*dy);

interpolated_value = weight1*array_in(y_cell,x_cell)+...
    weight2*array_in(y_cell,x_cell+1)+...
    weight3*array_in(y_cell+1,x_cell+1)+...
    weight4*array_in(y_cell+1,x_cell);

end