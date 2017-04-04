function writeLogFile(logFileName,logHeader,logEntries)

[hrows,hcols] = size(logHeader);
[nrows,ncols]=size(logEntries);

fid = fopen(logFileName,'w');
        
for row=1:hrows
    fprintf(fid,'%s\n',logHeader{row,:});
end

fprintf(fid,'\nParameters:\n');

for row = 1:nrows
    fprintf(fid,'%s = %f\n',logEntries{row,:});
end

fclose(fid);


end