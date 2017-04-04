function d = twoCirclesLaplacian(r,K)

d = -12*K*cos(K*(r^2))^4*(-4*K*(r^2)+6*K*(r^2)*cos(2*K*(r^2))+sin(2*K*(r^2)));
    

end