function [x, y] = uv2xy(u, v)
Ko = 1/2*(sqrt(u'*u) + sqrt(v'*v));
A = (u(4)*v(1:3) - v(4)*u(1:3))/Ko;
x = u(1:3)' - A';
y = v(1:3)'/sqrt(x*x');