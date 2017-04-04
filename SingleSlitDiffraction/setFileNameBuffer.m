%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function generates a string consiting of a index with 
%   zeros appended as to allow alphanumerical sorting.
%
%   Inputs: n - current integer index
%           Nmax - maximum integer index
%
%   Outputs: fileNameBuffer - string consiting of n with zeros appended to
%   the left such that the result has the same number of digits as Nmax
%
%   Author: Eric Wolf
%
%   Date: March 23, 2016 (code commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function fileNameBuffer = setFileNameBuffer(n,Nmax)

if n==0
    numDigits = 1;
else
    numDigits = ceil(log10(max(1,abs(n)+1)));
end
if Nmax ==0
    maxDigits = 1;
else
    maxDigits = ceil(log10(max(1,abs(Nmax)+1)));
end




fileNameBuffer = num2str(n);

while numDigits<maxDigits
    fileNameBuffer = strcat('0',fileNameBuffer);
    numDigits=numDigits+1;
end
end

