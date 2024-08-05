function f = Euler2(q_vec, p_vec)
global lambda dist2 
if lambda
    % do nothing
else
    lambda = 1;
end
dist2 = 2;
f = -1./sqrt(q_vec(:,1).^2 + (q_vec(:,2)-dist2/lambda^2).^2 + q_vec(:,3).^2);
