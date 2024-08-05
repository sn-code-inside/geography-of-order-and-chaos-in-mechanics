global epsilon1
G_vec = vectorp(q_vec, p_vec);
Ecc_vec = vectorp(p_vec, G_vec)-q_vec./[norma(q_vec)  norma(q_vec)  norma(q_vec)];
UserFunction(:,1) = Ecc_vec(:,3) - 1/2*epsilon1*(q1.^2+q2.^2);