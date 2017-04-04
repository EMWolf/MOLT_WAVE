% This function permutes the time levels to advance to the next time step.
% Eric Wolf
% March 28, 2017


function details = permuteTime(details)


%u  = details.z/2-details.u0;	%z=(u^{n+1}+u^{n-1})/2

%u^{n+1}+u^{n-1}+2u^{n}=2(I[u^{n}]+BC terms)
details.u = details.z-details.u0-2*details.u1;
details.u0 = details.u1;
details.u1 = details.u;
details.t = details.t+details.dt;
end