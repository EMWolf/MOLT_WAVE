%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function calculates the value of the first derivative
%   of a transition function, that is, a function that smoothly transitions
%   from zero to one.
%
%   Inputs: y - y-coordinate
%
%   Outputs: T - transition function first derivative value
%
%   Author: Eric Wolf
%
%   Date: March 25, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function T = transFunc_1stDeriv(y)

T = 30*y^2*(1-2*y+y^2);

end