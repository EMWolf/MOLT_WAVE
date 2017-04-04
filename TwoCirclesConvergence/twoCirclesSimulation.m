%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%   Description: Solves the wave equation using the implicit wave solver on
%   the two circle cavity geometry. The cavity is embedded in a Cartesian
%   grid of Nx by Ny cells.
%
%   Inputs: T - final simulation time
%           Nx - number of cells in the x-direction
%           Ny - number of cells in the y-direction
%           CFL - CFL number, determining time step size
%           reference - structure containing reference solution data
%           computed by the twoCirclesReferenceSolution function
%
%   Outputs: results - structure containing the error computed against the
%   reference solution
%
%   Author: Eric Wolf
%
%   Date: March 23, 2016 (code cleaned and commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function results = twoCirclesSimulation(T,Nx,Ny,CFL,reference)

disp({'Beginning two circles simulation with:'; strcat('Nx = ',num2str(Nx));['Ny = ',num2str(Ny)];['CFL = ',num2str(CFL)]})

%Set up
display('Preprocessing...')
%Initialize the details strucutre, containing numerical parameters and
%solution arrays
details = setDetails(T,Nx,Ny,CFL); 
display(['dt = ',num2str(details.dt)])

%Initialize the results structure, containing numerical parameters and
%error arrays needed in the refinement study
results = setResults(details); 

%Initialize the line-by-line data structures based on the two circles
%geometry
[xsweep,NxLines] = setXSweep(details);
[ysweep,NyLines] = setYSweep(details);
mask = setMask(details,NxLines,xsweep);



%Time loop
display('Beginning simulation...')
for n=1:details.Nt
    [details,xsweep] = doXSweep(details,xsweep,NxLines); %Perform x-sweep
    [details,ysweep] = doYSweep(details,ysweep,NyLines); %Perform y-sweep
    details = permuteTime(details);
    %display(['t = ',num2str(details.t),' (n+1)*dt = ',num2str((n+1)*details.dt)])
    
    %Compute error
    if ((reference.startSaveTime<details.t)&&(details.t<reference.endSaveTime))
        results = computeError(results,details,mask,n,reference);
    end
    %display(['L^{infty} error: ',num2str(results.error(1,n))])
    %display(['L^{2} error: ',num2str(results.error(2,n))])
    
   


end

end
