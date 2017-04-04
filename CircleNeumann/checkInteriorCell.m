%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function determines whether any vertex of a given
%   cell lies outside of a circle of radius R centered at the origin.
%
%   Inputs:
%   x_cell - index of the cell in the x-direction
%   y_cell - index of the cell in the y-direction
%   x - vector containing the x-locations of the cell edges
%   y - vector containing the y-locations of the cell edges
%   R - radius of the circle
%
%   Outputs:
%   bool - equals 1 if all vertices lie within the circle, equals 0 if not
%
%   Author: Eric Wolf
%
%   Date: March 30, 2016 (commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function bool = checkInteriorCell(x_cell,y_cell,x,y,R)

R1 = sqrt(x(x_cell)^2+y(y_cell)^2);
R2 = sqrt(x(x_cell+1)^2+y(y_cell)^2);
R3 = sqrt(x(x_cell+1)^2+y(y_cell+1)^2);
R4 = sqrt(x(x_cell)^2+y(y_cell+1)^2);

if max([R1, R2, R3, R4])<=R
    bool = 1;
else
    bool = 0;
end

end