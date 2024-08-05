function dotW = FGLmod(tau,W)
% For modified FGL Hamiltonian system
global epsilon
dotW = zeros(6,1);

 dotW(1) = W(4); 
 dotW(2) = W(5);
 dotW(3) = W(6);
 dotW(4) = epsilon * sin(W(1)) / (cos(W(1)) + cos(W(2)) + cos(W(3)) + 4)^2;
 dotW(5) = epsilon * sin(W(2)) / (cos(W(1)) + cos(W(2)) + cos(W(3)) + 4)^2;
 dotW(6) = epsilon * sin(W(3)) / (cos(W(1)) + cos(W(2)) + cos(W(3)) + 4)^2;