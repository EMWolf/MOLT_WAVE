%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function calculates the convolution of the equivalent
%   source for the y-sweep.
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

function IS = Soft_Source_y(details,sweep)

S = zeros(sweep.endInd-sweep.startInd+1,1);
IS = zeros(sweep.endInd-sweep.startInd+1,1);


%Generate source function
for m=1:length(S)
    x = details.x(sweep.xInd);
    y = details.y(sweep.startInd+m-1);
    t = details.t;  
    if (details.sourceStart<=y)&&(y<=details.sourceEnd)
    S(m) = equivSource(details,x,y,t);
    end
end

IS = GF_Quad(S',details.nuy,sweep.nuB,sweep.nuT);



end