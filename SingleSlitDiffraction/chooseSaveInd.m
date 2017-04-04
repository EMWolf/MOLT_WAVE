%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function selects time step indices for saving plots
%   from selected time values.
%
%   Inputs: details - structure containing numerical parameters and
%   solution array
%
%   Outputs: saveInd - array of time indices at which to save plots
%
%   Author: Eric Wolf
%
%   Date: March 25, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function saveInd = chooseSaveInd(details)


saveTime = [.1,.3,.5,1,1.5,2]; %Time values to save plots

saveInd = zeros(length(saveTime),1);

for i=1:length(saveTime)
    saveInd(i) = round(saveTime(i)/details.dt);
end




end


