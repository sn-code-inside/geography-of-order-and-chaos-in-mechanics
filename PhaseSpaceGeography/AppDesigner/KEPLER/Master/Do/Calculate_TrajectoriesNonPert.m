%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Calculate Trajectories (non perturbative)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
step_total = size(W,1);
step_i = floor(tau_i/tau_total*step_total)+1;
step_f = floor(tau_f/tau_total*step_total);
tau = tau_c(step_i:step_f);
%
tau_floor = tau - floor(tau);
%
x_vec = [2*W(step_i:step_f,1).*W(step_i:step_f,3) + 2*W(step_i:step_f,2).*W(step_i:step_f,4),...
    2*W(step_i:step_f,2).*W(step_i:step_f,3) - 2*W(step_i:step_f,1).*W(step_i:step_f,4),...
    -W(step_i:step_f,1).^2 - W(step_i:step_f,2).^2 + W(step_i:step_f,3).^2 + W(step_i:step_f,4).^2];

norma_x = W(step_i:step_f,1).^2 + W(step_i:step_f,2).^2 + W(step_i:step_f,3).^2 + W(step_i:step_f,4).^2;

y_vec = [-(W(step_i:step_f,1).*W(step_i:step_f,7) + W(step_i:step_f,2).*W(step_i:step_f,8)...
                + W(step_i:step_f,3).*W(step_i:step_f,5) + W(step_i:step_f,4).*W(step_i:step_f,6))./norma_x,...
         (W(step_i:step_f,1).*W(step_i:step_f,8) - W(step_i:step_f,2).*W(step_i:step_f,7)...
                - W(step_i:step_f,3).*W(step_i:step_f,6) + W(step_i:step_f,4).*W(step_i:step_f,5))./norma_x,...       
         (W(step_i:step_f,1).*W(step_i:step_f,5) + W(step_i:step_f,2).*W(step_i:step_f,6)...
                - W(step_i:step_f,3).*W(step_i:step_f,7) - W(step_i:step_f,4).*W(step_i:step_f,8))./norma_x];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
q_vec =  (lambda^2)*x_vec;   
p_vec = -(1/lambda)*y_vec;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%