%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%   Description: Solves the wave equation using the implicit wave solver on
%   the two circle cavity geometry on a highly-refined reference grid. The 
%   cavity is embedded in a Cartesian grid of NxRef by NyRef cells.
%
%   Inputs: T - final simulation time
%           NxRef - number of cells in the x-direction
%           NyRef - number of cells in the y-direction
%           CFLRef - CFL number, determining time step size
%           startSaveTime - time to begin saving reference solution
%           endSaveTme - time to end saving reference solution
%
%   Outputs: reference - structure containing the reference solution
%
%   Author: Eric Wolf
%
%   Date: March 23, 2016 (code cleaned and commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function reference = twoCirclesReferenceSolution(T,NxRef,NyRef,CFLRef,startSaveTime,endSaveTime)

disp({'Beginning two circles simulation with:'; strcat('Nx = ',num2str(NxRef));['Ny = ',num2str(NyRef)];['CFL = ',num2str(CFLRef)]})

%Set up

display('Preprocessing...')
%Initialize the details strucutre, containing numerical parameters and
%solution arrays
details = setDetails(T,NxRef,NyRef,CFLRef);

%Initialize the referece structure, containing numerical parameters and
%reference solution array
reference = setReference(details,startSaveTime,endSaveTime);

%Initialize the line-by-line data structures based on the two circles
%geometry
[xsweep,NxLines] = setXSweep(details);
[ysweep,NyLines] = setYSweep(details);
mask = setMask(details,NxLines,xsweep);



%Time loop
display('Beginning simulation...')
for n=1:details.Nt
    [details,xsweep] = doXSweep(details,xsweep,NxLines);
    [details,ysweep] = doYSweep(details,ysweep,NyLines);
    details = permuteTime(details);
    
    %Save reference time steps
    if reference.startSaveIndex<=n&&n<=reference.endSaveIndex
        reference = saveReferenceTimeStep(details,reference,n);
    end

end