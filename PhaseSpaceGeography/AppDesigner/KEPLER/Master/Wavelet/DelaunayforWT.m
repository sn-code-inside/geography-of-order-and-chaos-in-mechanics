%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
norma_q = sqrt((sum((q_vec.^2)'))');
sm_ax = norma_q./(2-((sum((p_vec.^2)'))').*norma_q);
L = sqrt(sm_ax);
Delta = scalarp(q_vec,p_vec)./L;
delta = (sm_ax-norma_q)./sm_ax;
l = atan2(-delta.*sin(Delta)+Delta.*cos(Delta), delta.*cos(Delta)+Delta.*sin(Delta));
Lx = L.*cos(l);
Ly = L.*sin(l);
signal = Lx + i*Ly;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%