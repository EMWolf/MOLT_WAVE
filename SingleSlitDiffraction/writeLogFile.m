%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function writes a log file containing information
%   about a simulation.
%
%   Inputs: logFileName - file name for the log file
%           logHeader - structure containing a header for the log file
%           logEntries - structure containing the entries for the log file
%
%   Outputs: none
%
%   Author: Eric Wolf
%
%   Date: March 25, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



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