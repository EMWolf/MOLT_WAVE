%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function initializes the results structure,
%   containing relevant numerical parameters and error arrays, to be passed
%   back to the top level refinement study script.
%
%   Inputs: details - structure containing numerical parameters and
%   solution arrays
%
%   Outputs: results - structure containing numerical parameters and error
%   arrays
%
%   Author: Eric Wolf
%
%   Date: March 23, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function results = setResults(details)

results.error = zeros(2,3,details.Nt);

results.errorPlot = zeros(details.Ny+1,details.Nx+1);

results.maxErrorLoc1 = zeros(2,details.Nt);
results.maxErrorLoc2 = zeros(2,details.Nt);
results.timeVec = details.timeVec;
results.dx = details.dx;
results.dy = details.dy;
results.dt = details.dt;
results.x = details.x;
results.y = details.y;
results.xCusp = 0;
results.yCusp = sqrt(details.R^2-details.gamma^2);
results.xc = details.x(details.Nx/2+1);
results.yc = details.y(details.Ny/2+1);
end