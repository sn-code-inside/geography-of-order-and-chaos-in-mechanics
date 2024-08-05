%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Symbolic (non perturbative)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear maplemex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms z1 z2 z3 z4 w1 w2 w3 w4 real
syms tau x x1 x2 x3 y1 y2 y3 real
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 =  2*z1*z3 + 2*z2*z4;
x2 =  2*z2*z3 - 2*z1*z4;
x3 = -z1^2 - z2^2 + z3^2 + z4^2;
x  =  z1^2 + z2^2 + z3^2 + z4^2;
y1 =  (z1*w3 + z2*w4 + z3*w1 + z4*w2)/(z1^2 + z2^2 + z3^2 + z4^2);
y2 = -(z1*w4 - z2*w3 - z3*w2 + z4*w1)/(z1^2 + z2^2 + z3^2 + z4^2);
y3 = -(z1*w1 + z2*w2 - z3*w3 - z4*w4)/(z1^2 + z2^2 + z3^2 + z4^2);

K = Kp([x1 x2 x3],[y1 y2 y3], lambda, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, deg1, deg2, deg3, deg4, deg5, Hp1, Hp2, Hp3, Hp4, Hp5);        
Kper = x*Kp([x1 x2 x3],[y1 y2 y3], lambda, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, deg1, deg2, deg3, deg4, deg5, Hp1, Hp2, Hp3, Hp4, Hp5);

F = pi*[w1 + diff(Kper,w1),  w2 + diff(Kper,w2),  w3 + diff(Kper,w3),  w4 + diff(Kper,w4),...
     -z1 - diff(Kper,z1),  -z2 - diff(Kper,z2),  -z3 - diff(Kper,z3),  -z4 - diff(Kper,z4)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 