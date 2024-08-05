function f = Zeeman2(q_vec, p_vec)
f = q_vec(:,3).*p_vec(:,1)-q_vec(:,1).*p_vec(:,3);