function y = ROT(x,epsilon1,epsilon2)
% Froescle' map for Rotation number. See Honjo,Kaneko: http://arxiv.org/abs/nlin/0307050
% 
y(1) = x(1) + epsilon1*sin(x(3)) + epsilon2*sin(x(3)+x(4));
y(2) = x(2) + epsilon1*sin(x(4)) + epsilon2*sin(x(3)+x(4));
y(3) = x(3) + x(1) + epsilon1*sin(x(3)) + epsilon2*sin(x(3)+x(4));
y(4) = x(4) + x(2) + epsilon1*sin(x(4)) + epsilon2*sin(x(3)+x(4));