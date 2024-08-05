function f = Euler3(q_vec, p_vec)
global lambda dist3
if lambda
    % do nothing
else
    lambda = 1;
end
dist3 = 2;
f = -1./sqrt(q_vec(:,1).^2 + q_vec(:,2).^2 + (q_vec(:,3)-dist3/lambda^2).^2);

