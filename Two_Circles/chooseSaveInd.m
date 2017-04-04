function saveInd = chooseSaveInd(details)


saveTime = [0, .25, .5, 1.09, 1.5, 1.75];

saveInd = zeros(length(saveTime),1);

for i=1:length(saveTime)
    saveInd(i) = round(saveTime(i)/details.dt);
end




end


