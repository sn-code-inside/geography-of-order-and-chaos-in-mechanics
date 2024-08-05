function y = LaplaceCoeff(j,s,alpha)
% Computation of the numerical value of the Laplace coefficients b^(j)_s(alpha)
f = @(phi) 1/pi*1./((1 - 2*alpha*cos(phi) + alpha.^2).^s).*cos(j*phi);
y = integral(f,0,2*pi,'RelTol',1e-14,'AbsTol',1e-14);