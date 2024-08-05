global epsilon1 epsilon2 epsilon3 epsilon4 epsilon5 deg1 deg2 deg3 deg4 deg5 Hp1 Hp2 Hp3 Hp4 Hp5
step_total = size(W,1);
step_i = floor(tau_i/tau_total*step_total)+1;
step_f = floor(tau_f/tau_total*step_total);
t = 1/(2*pi)*t_c(step_i:step_f);
Error = 1/2*norma(p_vec).^2 - 1./norma(q_vec) + Hp(q_vec, p_vec, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5)...
       -(1/2*norma(p_vec_o).^2 - 1./norma(q_vec_o) + Hp(q_vec_o, p_vec_o, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5)); 
figure
plot(t, Error)
title('H error (standard method)','FontSize',14)