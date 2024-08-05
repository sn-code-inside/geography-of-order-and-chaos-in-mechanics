function f = Euler1(q_vec, p_vec)
global lambda dist1 
if lambda
    % do nothing
else
    lambda = 1;
end
dist1 = 2;
f = -1./sqrt((q_vec(:,1)-dist1/lambda^2).^2 + q_vec(:,2).^2 + q_vec(:,3).^2);
