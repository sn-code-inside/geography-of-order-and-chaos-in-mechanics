function y = FGLsteep(x,epsilon1,m)
% See Froeschle',Guzzo,Lega: PhysicaD 163 (2002) 1-25
% 
y(3) = x(3) + x(1);
y(4) = x(4) - x(2) + m*x(2)^2;
y(1) = x(1) - epsilon1*sin(y(3))/(cos(y(3)) + cos(y(4)) + 4)^2;
y(2) = x(2) - epsilon1*sin(y(4))/(cos(y(3)) + cos(y(4)) + 4)^2;