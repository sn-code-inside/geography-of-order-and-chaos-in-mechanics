global lambda epsilon1 epsilon2 epsilon3 epsilon4 epsilon5 Hp1 Hp2 Hp3 Hp4 Hp5
value = lambda;
lambda = 1;
UserFunction(:,1) = 1/2*norma(p_vec).^2 - 1./norma(q_vec) + Hp(q_vec, p_vec,...
         epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5);
lambda = value;