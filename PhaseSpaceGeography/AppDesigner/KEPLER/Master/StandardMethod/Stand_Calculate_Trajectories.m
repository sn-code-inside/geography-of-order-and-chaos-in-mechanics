%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
step_total = size(W,1);
step_i = floor(tau_i/tau_total*step_total)+1;
step_f = floor(tau_f/tau_total*step_total);
t = 1/(2*pi)*t_c(step_i:step_f);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q_vec = W(step_i:step_f,1:3);
p_vec = W(step_i:step_f,4:6);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%