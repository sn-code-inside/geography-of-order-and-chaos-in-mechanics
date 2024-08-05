function y = User(x,epsilon1)
% Written by the User. Change the right member at will.
%
y(3) = x(3) + x(1);
y(4) = x(4) - x(2) + x(2)^2;
y(1) = x(1) - epsilon1*sin(y(3));
y(2) = x(2) - epsilon1*sin(y(4));