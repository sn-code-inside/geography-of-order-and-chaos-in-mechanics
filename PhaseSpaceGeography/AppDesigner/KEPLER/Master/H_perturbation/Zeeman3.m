function f = Zeeman3(q_vec, p_vec)
f = q_vec(:,1).*p_vec(:,2)-q_vec(:,2).*p_vec(:,1);