%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This script performs the solution of the wave equation
%   with Dirichlet boundary conditions on a nonconvex domain with a
%   nonsmooth boundary formed by two intersecting circles using the
%   implicit wave solver.
%
%   Author: Eric Wolf (former PhD student at Michigan State University
%   under advisor Prof. Andrew Christlieb, current postdoc at AFRL-WPAFB)
%
%   Date: April 11, 2013 (commented March 30, 2016)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Set up %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display('Preprocessing...')
Nx = 100;
Ny = 100;
T = 1;
CFL = 2;
details = setDetails(T,Nx,Ny,CFL);
[xsweep,NxLines] = setXSweep(details);
[ysweep,NyLines] = setYSweep(details);

mask = setMask(details,NxLines,xsweep);

%Settings

%Graphics Mode
%'display' - display plots only (don't save to file)
%'save_plots' - save select plots to file
%'save_movie' - save movie to file
%'off' - display and save no graphics
graphicsMode = 'display';

%Number of steps between displaying plots
dispStep = 1;

%Time step indices to be saved as output in 'plot' mode
saveInd = [0];

clims = [-1 1];

%Filename for 'save_movie'
fileName = 'Two_Circles';

[x,y] = meshgrid(details.x,details.y);

%# figure
% callfig;
% figure, set(gcf, 'Color','white')
% imagesc(details.x,details.y,details.u1,clims);  axis tight
% contourf(x,y,details.u1,10);
% surf(y,x,details.u1); shading interp; view([0,90]);
Make_Surf(x,y,details.u0.*mask);
caxis(clims);
xlabel('x')
ylabel('y')
title('t = 0')
colorbar
set(gca, 'nextplot','replacechildren');
switch lower(graphicsMode)
    case {'save_plots'}
        saveas(gcf,'figures/0.eps','epsc');
    case {'save_movie'}
        aviobj = avifile(['movies/',fileName,'.avi'],'compression','None');
        F = getframe(gca);
        aviobj = addframe(aviobj,F);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Time loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display('Beginning simulation...')
for n=1:details.Nt

    [details,xsweep] = doXSweep(details,xsweep,NxLines);
    [details,ysweep] = doYSweep(details,ysweep,NyLines);
    details = permuteTime(details);
    
    %Graphics output
    switch lower(graphicsMode)
        case {'display'}
            if mod(n,dispStep)==0;
                
                %imagesc(details.x,details.y,details.u1,clims)
                Make_Surf(x,y,details.u1.*mask);
                colorbar
                xlabel('x')
                ylabel('y')
                title(['t = ' num2str(details.t)])
                pause(0.01)
            end
            
        case {'save_plots'}
            if ismember(n,saveInd)
                
                %imagesc(details.x,details.y,details.u1)%clims)
                Make_Surf(x,y,details.u1);
                colorbar
                xlabel('x')
                ylabel('y')
                title(['t = ' num2str(details.t)])
                saveas(gcf,['figures/' num2str(n) '.eps'],'epsc');
            end
            
        case {'save_movie'}
            if mod(n,dispStep)==0
                %umax = max(max(details.u1(1:floor(details.Ny/2)-1,:)));
                %umin = min(min(details.u1(1:floor(details.Ny/2)-1,:)));
                %imagesc(details.x,details.y,details.u1,clims)
                %contourf(details.x,details.y,details.u1,20);
                %surf(y,x,details.u1); shading interp; view([0,90]);
                %caxis(clims);
                Make_Surf(x,y,details.u1);
                colorbar
                xlabel('x')
                ylabel('y')
                title(['t = ' num2str(details.t)])
                pause(0.001);
                F = getframe(gca);
                aviobj = addframe(aviobj,F);
                
            end
            
            
    end
    
    
end

%Graphics output clean up
switch lower(graphicsMode)
    case {'save_movie'}
        close(gcf);
        aviobj = close(aviobj);
        
end