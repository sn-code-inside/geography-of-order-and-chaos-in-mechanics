function f = Zeeman1(q_vec, p_vec)
f = q_vec(:,2).*p_vec(:,3)-q_vec(:,3).*p_vec(:,2);