%Two Circles Example
%Eric Wolf
%Department of Mathematics
%Michigan State University
%April 11, 2013

clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Set up %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display('Preprocessing...')
%Define problem parameters and initialize data structures
details = setDetails();
%Define problem geometry
[xsweep,NxLines] = setXSweep(details);
[ysweep,NyLines] = setYSweep(details);
mask = setMask(details,NxLines,xsweep);

%Settings

%Graphics Mode
%'display' - display plots only (don't save to file)
%'save_plots' - save selected plots to file
%'save_movie' - save movie to file
%'off' - disable graphics output
graphicsMode = 'save_plots';

%Number of steps between displaying plots
dispStep = 1;

%Time step indices to be saved as output in 'plot' mode
saveInd = chooseSaveInd(details);
saveNumber = 1;
saveTime = zeros(length(saveInd),1);

%Plot color scale
clims = [-1 1];

%Filename stub
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
%colorbar
set(gca, 'nextplot','replacechildren');
switch lower(graphicsMode)
    case {'save_plots'}
        delete('figures/*.*');
        close all;
        if ismember(0,saveInd)
        Make_Surf(x,y,details.u0.*mask);
        caxis(clims);
        %axis square;
        axis off;
        %set(gcf, 'PaperPosition', [0 0 5 5]); %Position plot at left hand corner with width 5 and height 5.
        %set(gcf, 'PaperSize', [5 5]); %Set the paper to have width 5 and height 5.
        
        %xlabel('x')
        %ylabel('y')
        %title('t = 0')
        
        fileNameBuffer = setFileNameBuffer(saveNumber,length(saveInd));
        saveas(gcf,['figures/' fileName fileNameBuffer '.pdf'],'pdf');
        saveTime(saveNumber)=0;
        saveNumber = saveNumber+1;
        end
    case {'save_movie'}
        delete('movies/*.*');
        aviobj = avifile(['movies/' fileName '.avi'],'compression','None');
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
                %colorbar
                xlabel('x')
                ylabel('y')
                title(['t = ' num2str(details.t)])
                pause(0.01)
            end
            
        case {'save_plots'}
            if ismember(n,saveInd)
                
                %imagesc(details.x,details.y,details.u1)%clims)
                Make_Surf(x,y,details.u1.*mask);
                caxis(clims);
                axis off;
                %set(gcf, 'PaperPosition', [0 0 5 5]); %Position plot at left hand corner with width 5 and height 5.
                %set(gcf, 'PaperSize', [5 5]); %Set the paper to have width 5 and height 5.
                %xlabel('x')
                %ylabel('y')
                %title(['t = ' num2str(details.t)])
                fileNameBuffer = setFileNameBuffer(saveNumber,length(saveInd));
                saveas(gcf,['figures/' fileName fileNameBuffer '.pdf'],'pdf');
                saveTime(saveNumber)=details.t;
                saveNumber = saveNumber+1;
            end
            
        case {'save_movie'}
            if mod(n,dispStep)==0
                %umax = max(max(details.u1(1:floor(details.Ny/2)-1,:)));
                %umin = min(min(details.u1(1:floor(details.Ny/2)-1,:)));
                %imagesc(details.x,details.y,details.u1,clims)
                %contourf(details.x,details.y,details.u1,20);
                %surf(y,x,details.u1); shading interp; view([0,90]);
                %caxis(clims);
                Make_Surf(x,y,details.u1.*mask);
                xlabel('x')
                ylabel('y')
                title(['t = ' num2str(details.t)])
                %pause(0.001);
                F = getframe(gca);
                aviobj = addframe(aviobj,F);
                
            end
            
            
    end
    
    
end

%%%%%%%%%%%%%% Graphics output clean up & write log file %%%%%%%%%%%%%%%%%%

logHeader = {'Simulation Log';...
    'Implicit Wave Equation Solver';...
    'Two Circles Example';...
    date};


logEntries = {'dx',details.dx;...
    'dy',details.dy;...
    'dt',details.dt;...
    'CFL',details.CFL;...
    'Nx',details.Nx;...
    'Ny',details.Ny;...
    'T',details.T;...
    'R (circle radius)',details.R;...
    'gamma (center shift)',details.gamma};


switch lower(graphicsMode)
    case {'save_plots'}
        for n=1:length(saveInd)
            logEntries = cat(1,logEntries,...
                {['Time of plot ',num2str(n)],saveTime(n)});
        end
        logFileName = ['figures/',fileName,'_log.txt'];
        writeLogFile(logFileName,logHeader,logEntries);
        
        
    case {'save_movie'}
        close(gcf);
        aviobj = close(aviobj);
        
        logFileName = ['movies/',fileName,'_log.txt'];
        writeLogFile(logFileName,logHeader,logEntries);
               
end

close all;
