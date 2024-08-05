function f = Hill(q_vec, p_vec)
mu = 0.1; % Moon mass, with Moon mass + Earth mass = 1
f = mu/2*(-2*q_vec(:,1).^2 + q_vec(:,2).^2 + q_vec(:,3).^2);