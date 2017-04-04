%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function calculates the value of the second 
%   derivative of a transition function, that is, a function that smoothly 
%   transitions from zero to one.
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

function T = transFunc_2ndDeriv(y)

T = 60*y*(1-3*y+2*y^2);

end