G_vec_o = vectorp(q_vec_o, p_vec_o);
Ecc_vec_o = vectorp(p_vec_o, G_vec_o)-q_vec_o/norma(q_vec_o);
G_o = norma(G_vec_o);
Ecc_o = norma(Ecc_vec_o);
sm_ax_o = G_o^2/(1-Ecc_o^2);
if sm_ax_o <= 0
    warndlg('The semimajor axis must be positive')
    return
end
R_vec_o = sqrt(sm_ax_o)* Ecc_vec_o;
S_vec_o = 1/2*(G_vec_o + R_vec_o);
D_vec_o = 1/2*(G_vec_o - R_vec_o);
normaS = norma(S_vec_o);
normaD = norma(D_vec_o);
S1 = S_vec_o(1)/normaS;
S2 = S_vec_o(2)/normaS;
S3 = S_vec_o(3)/normaS;
D1 = D_vec_o(1)/normaD;
D2 = D_vec_o(2)/normaD;
D3 = D_vec_o(3)/normaD;