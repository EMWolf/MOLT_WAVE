%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function initializes the reference structure,
%   containing relevant numerical parameters and solution arrays, to be 
%   passed back to the top level refinement study script.
%
%   Inputs: details - structure containing numerical parameters and
%   solution arrays
%           startSaveTime - time to begin saving reference solution
%           endSaveTme - time to end saving reference solution
%
%   Outputs: reference - structure containing numerical parameters and
%   reference solution array
%
%   Author: Eric Wolf
%
%   Date: March 23, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function reference = setReference(details,startSaveTime,endSaveTime)

reference.Nx = details.Nx;
reference.Ny = details.Ny;
reference.Nt = details.Nt;

reference.dx = details.dx;
reference.dy = details.dy;
reference.dt = details.dt;

reference.startSaveTime = startSaveTime;
reference.endSaveTime = endSaveTime;

reference.startSaveIndex = floor(reference.startSaveTime/details.dt)-1;
reference.endSaveIndex = ceil(reference.endSaveTime/details.dt)-1;

reference.NTimeSteps = reference.endSaveIndex - reference.startSaveIndex + 1;

reference.uRef = zeros(reference.NTimeSteps,reference.Ny+1,reference.Nx+1);


end