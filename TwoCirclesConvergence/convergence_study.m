%Makes plots to demonstrate orders of convergence

for n=1:Nlevels
   logdx(n)=log(levels(n).dx);
   logdy(n)=log(levels(n).dy);
   
   err_L1(n) = max(levels(n).error(1,1,:));
   err_L2(n) = max(levels(n).error(1,2,:));
   err_max(n) = max(levels(n).error(1,3,:));
   
   
   
   log_err_L1(n)=log(err_L1(n));
   log_err_L2(n) = log(err_L2(n));
   log_err_max(n) = log(err_max(n));
   

end

figure;
plot(logdx,log_err_L1,'x');
title(['Log-Log Plot of Error vs Grid Size, CFL = ',num2str(levels(1).CFL)],'fontsize',14)
xlabel('log(dx)')
ylabel('log(error)')
legend('L^1 Error','Location','SouthEast')

figure;
plot(logdx(1:3),log_err_L2(1:3),'x');
title(['Log-Log Plot of Error vs Grid Size, CFL = ',num2str(levels(1).CFL)],'fontsize',14)
xlabel('log(dx)')
ylabel('log(error)')
legend('L^2 Error','Location','SouthEast')

figure;
plot(logdx,log_err_max,'x');
title(['Log-Log Plot of Error vs Grid Size, CFL = ',num2str(levels(1).CFL)],'fontsize',14)
xlabel('log(dx)')
ylabel('log(error)')
legend('L^\infty Error','Location','SouthEast')