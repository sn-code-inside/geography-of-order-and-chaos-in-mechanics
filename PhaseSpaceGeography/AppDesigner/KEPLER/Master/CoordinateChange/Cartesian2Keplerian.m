%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G_vec_o = vectorp(q_vec_o, p_vec_o);
G_o = norma(G_vec_o);
Ecc_vec_o = vectorp(p_vec_o, G_vec_o)-q_vec_o/norma(q_vec_o);
Ecc_o = norma(Ecc_vec_o);
sm_ax_o = G_o^2/(1-Ecc_o^2);
if (G_vec_o(1)^2+G_vec_o(2)^2) == 0
    node_o = [1  0  0];
else
    node_o = [-G_vec_o(2)/sqrt(G_vec_o(1)^2+G_vec_o(2)^2)...
             G_vec_o(1)/sqrt(G_vec_o(1)^2+G_vec_o(2)^2)...
             0];
end
Omega_o = 180/pi*atan2(node_o(2), node_o(1));
omega_o = 180/pi*atan2(scalarp(vectorp(node_o, Ecc_vec_o), G_vec_o)/G_o,...
        scalarp(node_o, Ecc_vec_o));
incl_o = 180/pi*acos(G_vec_o(3)/G_o);
if sm_ax_o <= 0
    warndlg(['The semimajor axis must be positive. The numerical result of the Regularization method may be incorrect. Try with the Standard method.'])
    return
end
global s_o
s_o = 180/pi*atan2(scalarp(q_vec_o,p_vec_o), (sm_ax_o-norma(q_vec_o))/sqrt(sm_ax_o));
f_o = 180/pi*2*atan(sqrt((1+Ecc_o)/(1-Ecc_o))*tan(s_o/2*pi/180));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Keplerian = [sm_ax_o  Ecc_o  Omega_o  omega_o  incl_o  f_o];  