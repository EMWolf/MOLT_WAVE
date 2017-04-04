%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function calculates the equivalent
%   source value at a given (x,y,t) for a launching a plane wave.
%
%   Inputs: details - structure containing numerical parameters and
%   solution arrays
%           x - x-coordinate
%           y - y-coordinate
%           t - time
%
%   Outputs: S - equivalent source value
%
%   Author: Eric Wolf
%
%   Date: March 25, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function S = equivSource(details,x,y,t)
L = details.sourceWidth;
y0 = details.sourceEnd;
S = -details.c^2*...
    ((1/L)^2*transFunc_2ndDeriv((y0-y)/L)*incPlaneWave(details,x,y,t)-...
    2*(1/L)*transFunc_1stDeriv((y0-y)/L)*incPlaneWave_Deriv(details,x,y,t));


end