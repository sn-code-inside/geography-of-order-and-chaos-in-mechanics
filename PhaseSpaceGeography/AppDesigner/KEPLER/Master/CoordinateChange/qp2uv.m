%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
norma_q = sqrt((sum((q_vec.^2)'))');
sm_ax = norma_q./(2-((sum((p_vec.^2)'))').*norma_q);
L = sqrt(sm_ax);
G_vec = vectorp(q_vec, p_vec);
Ecc_vec = vectorp(p_vec, G_vec)-q_vec./[norma_q  norma_q  norma_q];
S_vec = 1/2*(G_vec + Ecc_vec.*[L L L]);
D_vec = 1/2*(G_vec - Ecc_vec.*[L L L]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sc_q_p = scalarp(q_vec,p_vec);
Delta = sc_q_p./L;
clear U_ V_
U_(:,1) = L.*(-sc_q_p.*p_vec(:,1) + q_vec(:,1)./norma_q);
U_(:,2) = L.*(-sc_q_p.*p_vec(:,2) + q_vec(:,2)./norma_q);
U_(:,3) = L.*(-sc_q_p.*p_vec(:,3) + q_vec(:,3)./norma_q);
U_(:,4) = -sc_q_p;
V_(:,1) = norma_q.*p_vec(:,1);
V_(:,2) = norma_q.*p_vec(:,2);
V_(:,3) = norma_q.*p_vec(:,3);
V_(:,4) = L.*(1 - (norma(p_vec)).^2.*norma_q);
u = [cos(Delta)  cos(Delta)  cos(Delta)  cos(Delta)].*U_...
    -[sin(Delta)  sin(Delta)  sin(Delta)  sin(Delta)] .*V_;
v = [sin(Delta)  sin(Delta)  sin(Delta)  sin(Delta)].*U_...
    +[cos(Delta)  cos(Delta)  cos(Delta)  cos(Delta)] .*V_;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%