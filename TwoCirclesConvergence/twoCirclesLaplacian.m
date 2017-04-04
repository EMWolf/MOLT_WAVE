%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function calculates the Laplacian of the initial
%   condition for the two circles problem in order to calculate the second
%   time level to second-order accuracy via the Lax-Wendroff procedure.
%
%   Inputs: r - distance from the center of a given IC bump
%           K - parameter specifying the width of the IC bump
%
%   Outputs: d - the value of the Laplacian
%
%   Author: Eric Wolf
%
%   Date: March 23, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function d = twoCirclesLaplacian(r,K)

d = -12*K*cos(K*(r^2))^4*(-4*K*(r^2)+6*K*(r^2)*cos(2*K*(r^2))+sin(2*K*(r^2)));
    

end