function dotW = StandDiffEq(tau,W)
global pick tau_total
if tau > pick + tau_total/100;
    waitbar(tau/tau_total);
    pick = tau;
end
dotW = zeros(8,1);
%
% SUBSTITUTIONS
%
 q1 = W(1);
 q2 = W(2);
 q3 = W(3);
 p1 = W(4);
 p2 = W(5);
 p3 = W(6);
 q = sqrt(q1^2+q2^2+q3^2);
%
% EQUATIONS
%
 dotW(1) = p1 - (2*q2)/25;
 dotW(2) = p2 + (2*q1)/25;
 dotW(3) = p3;
 dotW(4) = - (2*p2)/25 - (4*q1)/625 - q1/q^3 - 4/25;
 dotW(5) = (2*p1)/25 - (4*q2)/625 - q2/q^3;
 dotW(6) = -q3/q^3;
 dotW(7) = 0;
 dotW(8) = 0;
