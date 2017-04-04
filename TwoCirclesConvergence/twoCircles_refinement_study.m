%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This top level script performs a refinement study for the 
%       implicit wave solver on the two circle cavity geometry.
%
%   Author: Eric Wolf, formerly PhD student at Michigan State University
%   with Andrew Christlieb, currently postdoc at WPAFB
%   
%   Date: March 23, 2016 (code cleaned and commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;
close all;
clc;


T = 0.3;    %Final simulation time
startSaveTime = 0.28;   %Start time for saving solution for error calculation
endSaveTime = 0.29; %End time for saving solution
CFL = 2; %CFL number

Nlevels = 4; %Number of levels of refinement


%Compute reference solution on a fine mesh
NxRef = 75*2^6; %Number of cells in the x-direction in the reference solution
NyRef = NxRef;  %Number of cells in the y-direction in the reference solution
CFLRef = CFL; %CFL number for the reference solution

%Compute the reference solution
reference = twoCirclesReferenceSolution(T,NxRef,NyRef,CFLRef,startSaveTime,endSaveTime);

%Perform the refinement study, recording relevant data in the levels
%structure
for n=1:Nlevels
    levels(n).Nx = 75*2^n;
    levels(n).Ny = 75*2^n;
    levels(n).CFL = CFL;
    
    results = twoCirclesSimulation(T,...
        levels(n).Nx,levels(n).Ny,levels(n).CFL,reference);
    
    levels(n).x = results.x;
    levels(n).y = results.y;
    
    levels(n).dx = results.dx;
    levels(n).dy = results.dy;
    levels(n).dt = results.dt;
    
    display([num2str(results.xc),num2str(results.yc)]);
    levels(n).error = results.error;
    levels(n).maxErrorLoc1 = results.maxErrorLoc1;
    levels(n).maxErrorLoc2 = results.maxErrorLoc2;
    levels(n).xCusp = results.xCusp;
    levels(n).yCusp = results.yCusp;
    
    levels(n).timeVec = results.timeVec;
end

%Process results
error_convergence_postprocessing;

%filename = ['levels_CFL',num2str(CFL),'.mat'];

%save(filename,'-struct',levels);