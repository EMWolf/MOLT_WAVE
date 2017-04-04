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

