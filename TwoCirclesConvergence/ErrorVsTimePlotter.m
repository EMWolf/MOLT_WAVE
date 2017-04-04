%Plotting the error vs time

%L^infty error
for n=1:Nlevels
    hold on;
    err1 = zeros(length(levels(n).timeVec),1);
    err2 = zeros(length(levels(n).timeVec),1);
    for i=1:length(err1)
        err1(i) = levels(n).error(1,1,i);
        err2(i) = levels(n).error(2,1,i);
    end
    plot(levels(n).timeVec,err1,levels(n).timeVec,err2)
    %plot(levels(n).timeVec,err2)
    
end
title('L^1 error over time')
xlabel('t')
ylabel('L^1 error')

figure
%L^2 error
for n=1:Nlevels
    hold on;
    err1 = zeros(length(levels(n).timeVec),1);
    err2 = zeros(length(levels(n).timeVec),1);
    for i=1:length(err1)
        err1(i) = levels(n).error(1,2,i);
        err2(i) = levels(n).error(2,2,i);
    end
    plot(levels(n).timeVec,err1,levels(n).timeVec,err2)
    %plot(levels(n).timeVec,err2)
end
title('L^2 error over time')
xlabel('t')
ylabel('L^2 error')

figure
%L^infty error
for n=1:Nlevels
   hold on;
   err1 = zeros(length(levels(n).timeVec),1);
    err2 = zeros(length(levels(n).timeVec),1);
    for i=1:length(err1)
        err1(i) = levels(n).error(1,3,i);
        err2(i) = levels(n).error(2,3,i);
    end
    plot(levels(n).timeVec,err1,levels(n).timeVec,err2)
    %plot(levels(n).timeVec,err2)
end
title('L^\infty error over time')
xlabel('t')
ylabel('L^\infty error')
