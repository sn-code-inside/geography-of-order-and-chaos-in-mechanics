function f = Oscillator(q_vec, p_vec)
k1 = 1.;
k2 = 1.;
k3 = 1.;
f = 1/2*(k1*q_vec(:,1).^2 + k2*q_vec(:,2).^2 + k3*q_vec(:,3).^2);