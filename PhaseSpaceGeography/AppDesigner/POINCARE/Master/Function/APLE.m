function Y = APLE(X,epsilon1)
% See Lukes-Gerakopoulos,Voglis,Efthymiopoulos: PhysicaA 387 (2008) 1907-1925
%
Y(1) = X(1) - epsilon1*sin(X(1)+X(3))/(cos(X(1)+X(3))+cos(X(2)+X(4))+4)^2;
Y(2) = X(2) - epsilon1*sin(X(2)+X(4))/(cos(X(1)+X(3))+cos(X(2)+X(4))+4)^2;
Y(3) = X(1)+X(3);
Y(4) = X(2)+X(4);