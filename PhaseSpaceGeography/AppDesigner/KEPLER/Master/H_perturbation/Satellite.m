function f = Satellite(q_vec, p_vec)
q = sqrt(q_vec(:,1).^2 + q_vec(:,2).^2 + q_vec(:,3).^2);
f = -(1/2*(q_vec(:,1).^2 + q_vec(:,2).^2) - q_vec(:,3).^2)./q.^5;