global epsilon1 epsilon2 epsilon3 epsilon4 epsilon5 deg1 deg2 deg3 deg4 deg5 Hp1 Hp2 Hp3 Hp4 Hp5

if get(app.check_nonpert, 'Value') == 1
    global W
%    Error1 = W(:,1).*W(:,6) - W(:,2).*W(:,5) + W(:,3).*W(:,8) - W(:,4).*W(:,7);
Error1 = W(step_i:step_f,1).*W(step_i:step_f,6) - W(step_i:step_f,2).*W(step_i:step_f,5)...
       + W(step_i:step_f,3).*W(step_i:step_f,8) - W(step_i:step_f,4).*W(step_i:step_f,7);
    if strcmp(get(app.SingleFigures, 'Checked'),'on')
        figure
        plot(tau, Error1)
        title('Twistor''s norm','FontSize',14)
        xlabel('\tau', 'FontSize',14)
    end
    %----------------------------------------------------------------------
    x = norma(x_vec);
    y = norma(y_vec);
    Error2 = 1/2*x.*(y.^2 + 1) + x.*Kp(x_vec, -y_vec, lambda, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, deg1, deg2, deg3, deg4, deg5, Hp1, Hp2, Hp3, Hp4, Hp5)-1;
    if strcmp(get(app.SingleFigures, 'Checked'),'on')
        figure
        plot(tau, Error2)
        title('K -- 1','FontSize',14)
        xlabel('\tau', 'FontSize',14)
    end
    %-----------------------------------------------------------------------
    value = lambda;
    lambda = 1;
    Error3 = 1/2*norma(p_vec).^2 - 1./norma(q_vec) + Hp(q_vec, p_vec, epsilon1, epsilon2, epsilon3, epsilon4,epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5)...
     -(1/2*norma(p_vec_o).^2 - 1./norma(q_vec_o) + Hp(q_vec_o, p_vec_o, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5));
    lambda = value;
    if strcmp(get(app.SingleFigures, 'Checked'),'on')
        figure    
        plot(tau, Error3)
        title('H error','FontSize',14)
        xlabel('\tau', 'FontSize',14)
    end
    %----------------------------------------------------------------------
    figure('Name', 'Integration errors vs False time', 'NumberTitle', 'on')
    subplot(2,2,1); plot(tau,Error1)
    title('Twistor''s norm','FontSize',8)
    subplot(2,2,3); plot(tau,Error2)
    title('K -- 1','FontSize',8)
    subplot(2,2,4); plot(tau,Error3)
    title('H error','FontSize',8)
    return
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Error1 = (sum((W(step_i:step_f,1:4).^2)'))' - (sum((W(step_i:step_f,5:8).^2)'))';
if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    plot(tau, Error1)
    title('U^2 -- V^2','FontSize',14)
    xlabel('\tau', 'FontSize',14)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Error2 = (sum((W(step_i:step_f,1:4).*W(step_i:step_f,5:8))'))';
if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    plot(tau, Error2)
    title('U\cdotV','FontSize',14)
    xlabel('\tau', 'FontSize',14)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = norma(x_vec);
Error3 = Ko + x.*Kp(x_vec,y_vec, lambda, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5,...
    deg1, deg2, deg3, deg4, deg5, Hp1, Hp2, Hp3, Hp4, Hp5)-1;
if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    plot(tau, Error3)
    title('K -- 1','FontSize',14)
    xlabel('\tau', 'FontSize',14)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
value = lambda;
lambda = 1;
Error4 = 1/2*norma(p_vec).^2 - 1./norma(q_vec) + Hp(q_vec, p_vec, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5)...
     -(1/2*norma(p_vec_o).^2 - 1./norma(q_vec_o) + Hp(q_vec_o, p_vec_o, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5));
lambda = value;
if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    plot(tau, Error4)
    title('H error','FontSize',14)
    xlabel('\tau', 'FontSize',14)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'Integration errors vs False time', 'NumberTitle', 'on')
subplot(2,2,1); plot(tau,Error1)
title('U^2 -- V^2','FontSize',8)
subplot(2,2,2); plot(tau,Error2)
title('U\cdotV','FontSize',8)
subplot(2,2,3); plot(tau,Error3)
title('K -- 1','FontSize',8)
subplot(2,2,4); plot(tau,Error4)
title('H error','FontSize',8)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%