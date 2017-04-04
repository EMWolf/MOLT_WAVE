%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function records the reference solution into the
%   reference data structure.
%
%   Inputs: details - structure containing numerical parameters and
%   solution arrays
%           reference - structure containing numerical parameters and
%   reference solution array
%            n - current time step number
%
%   Outputs: reference - structure containing numerical parameters and
%   reference solution array
%            
%
%   Author: Eric Wolf
%
%   Date: March 25, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function reference = saveReferenceTimeStep(details,reference,n)

if reference.startSaveIndex<=n&&n<=reference.endSaveIndex
        reference.uRef(n-reference.startSaveIndex+1,:,:) = details.u;
end

end