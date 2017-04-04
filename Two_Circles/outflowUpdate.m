%Generates equvialent outflow source through exponential recursion
%Inputs:
%outflowInterp: interpolation used to approximate integral, 'linear' or
%'quadratic'
%beta: numerical parameter
%s: outflow source from previous time step
%v0: u^{n} at boundary
%v1: u^{n-1} at boundary
%v2: u^{n-2} at boundary
%Output:
%s: outflow source at current time step

function s = outflowUpdate(outflowInterp,beta,s,v0,v1,v2)


d = exp(-beta);

switch lower(outflowInterp)
    case {'linear'}
        s = d*s+(1-d)*v0+((1-d*(beta+1))/beta)*(v1-v0);
    case {'quadratic'}
%         s = d*s+(1-d)*v0-(1-d*(beta+1))/(2*beta)*(3*v0-4*v1+v2)+...
%             (1-d*(beta^2/2+beta+1))/(beta^2)*(v0-2*v1+v2);
        
        g0 = (1-d)/beta^2-(3-d)/(2*beta)+1;
        g1 = -2*(1-d)/beta^2+2/beta-d;
        g2 = (1-d)/beta^2-(1+d)/(2*beta);
        
        
        s = d*s + g0*v0+g1*v1+g2*v2;
end

end