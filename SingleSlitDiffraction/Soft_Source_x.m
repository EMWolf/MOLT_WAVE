%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function calculates the convolution of the equivalent
%   source for the x-sweep.
%
%   Inputs: details - structure containing numerical parameters and
%   solution arrays
%           sweep - structure containing sweep data
%
%   Outputs: IS - convolved equivalent source
%
%   Author: Eric Wolf
%
%   Date: March 25, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function IS = Soft_Source_x(details,sweep)

S = zeros(sweep.endInd-sweep.startInd+1,1);
%IS = zeros(sweep.endInd-sweep.startInd+1,1);


%Generate source function
for m=1:length(S)
    x = details.x(sweep.startInd+m-1);
    y = details.y(sweep.dualInd);
    t = details.t;    
    S(m) = equivSource(details,x,y,t);
end

IS = GF_Quad(S',sweep.nu);
%IS = Apply_BC(S',IS,details.nux,sweep.nuL,sweep.nuR,4,4); %Periodic BC


end