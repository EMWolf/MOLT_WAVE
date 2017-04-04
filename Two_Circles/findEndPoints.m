function [startInd,endInd,nuL,nuR]=findEndPoints(xL,xR,x,dx,dt,c,beta)
tol = 1e-3*dx;

startInd=1;
while x(startInd+1)<xL
      startInd=startInd+1;
end
%Now, x(startInd)<xL<=x(startInd+1)
%If x(startInd+1) is sufficently close to xL, discard the initial boundary
%point
dxL = x(startInd+1)-xL;
if dxL<tol
    startInd=startInd+1;
    dxL = dx;
    display('resetting L boundary point')
end

nuL	= beta*dxL/(c*dt);

endInd = startInd;
while x(endInd+1)<xR
    endInd = endInd+1;
end
endInd = endInd+1;
%Now, x(endInd-1)<xR<x(endInd)
%If x(endInd-1) is sufficiently close to xR, discard the inital boundary
%point

dxR = xR-x(endInd-1);
if dxR<0
    display('dxR negative')
elseif x(endInd)-xR<0
    display('endInd too small')
end
if dxR<tol
    endInd = endInd-1;
    dxR = dx;
    display('resetting R boundary point')
end

nuR	= beta*dxR/(c*dt);


end