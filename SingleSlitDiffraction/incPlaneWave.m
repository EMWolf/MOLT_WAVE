%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function calculates the value of a plane wave 
%   function at a given (x,y,t).
%
%   Inputs: details - structure containing numerical parameters and
%   solution arrays
%           x - x-coordinate
%           y - y-coordinate
%           t - time
%
%   Outputs: u - plane wave function value
%
%   Author: Eric Wolf
%
%   Date: March 25, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function u = incPlaneWave(details,x,y,t)
w = details.kInc/details.c;
kx = details.kInc*cos(details.angleInc);
ky = details.kInc*sin(details.angleInc);

u = cos(w*t-kx*x-ky*y);

end