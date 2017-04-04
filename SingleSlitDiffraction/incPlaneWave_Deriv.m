%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function calculates the value of the derivative of a 
%   plane wave function at a given (x,y,t).
%
%   Inputs: details - structure containing numerical parameters and
%   solution arrays
%           x - x-coordinate
%           y - y-coordinate
%           t - time
%
%   Outputs: u - plane wave function derivative value
%
%   Author: Eric Wolf
%
%   Date: March 25, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function u = incPlaneWave_Deriv(details,x,y,t)
w = details.kInc/details.c;
kx = details.kInc*cos(details.angleInc);
ky = details.kInc*sin(details.angleInc);

u = ky*sin(w*t-kx*x-ky*y);

end