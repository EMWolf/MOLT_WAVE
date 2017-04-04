%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function forms the solution at the new time step and
%   permutes the previous time step arrays.
%
%   Inputs: details - structure containing numerical parameters and
%   solution arrays
%
%   Outputs: details - structure containing numerical parameters and
%   solution arrays
%            
%
%   Author: Eric Wolf
%
%   Date: March 25, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function details = permuteTime(details)

%u^{n+1}+u^{n-1}+2u^{n}=2(I[u^{n}]+BC terms)
details.u = details.z-details.u0-2*details.u1;
details.u0 = details.u1;
details.u1 = details.u;

details.t=details.t+details.dt;
end