% Userfunction = gamma - TotalEnergy
global epsilon1 q_vec_o p_vec_o dist3
G_vec = vectorp(q_vec, p_vec);
Ecc_vec = vectorp(p_vec, G_vec)-q_vec./[norma(q_vec)  norma(q_vec)  norma(q_vec)];
G_vec_o = vectorp(q_vec_o, p_vec_o);
Ecc_vec_o = vectorp(p_vec_o, G_vec_o)-q_vec_o./[norma(q_vec_o)  norma(q_vec_o)  norma(q_vec_o)];
UserFunction(:,1) = Ecc_vec(:,3) - 1/dist3*(norma(G_vec)).^2 + epsilon1*(q3-dist3)./sqrt(q1.^2 + q2.^2 + (q3-dist3).^2);
