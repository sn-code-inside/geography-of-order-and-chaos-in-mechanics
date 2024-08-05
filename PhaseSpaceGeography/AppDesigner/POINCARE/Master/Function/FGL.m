function y = FGL(x,epsilon1,epsilon2,epsilon3)
% See Froeschle',Guzzo,Lega: PhysicaD 163 (2002) 1-25
% 
y(1) = x(1) + epsilon1*sin(x(1)+x(3)) + epsilon3*sin(x(1)+x(2)+x(3)+x(4));
y(2) = x(2) + epsilon2*sin(x(2)+x(4)) + epsilon3*sin(x(1)+x(2)+x(3)+x(4));
y(3) = x(1)+x(3);
y(4) = x(2)+x(4);