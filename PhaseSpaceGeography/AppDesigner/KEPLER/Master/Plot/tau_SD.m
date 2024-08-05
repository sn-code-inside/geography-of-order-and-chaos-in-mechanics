%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
norma_q = sqrt((sum((q_vec.^2)'))');
sm_ax = norma_q./(2-((sum((p_vec.^2)'))').*norma_q);
L = sqrt(sm_ax);
G_vec = vectorp(q_vec, p_vec);
Ecc_vec = vectorp(p_vec, G_vec)-q_vec./[norma_q  norma_q  norma_q];
S_vec = 1/2*(G_vec + Ecc_vec.*[L L L]);
D_vec = 1/2*(G_vec - Ecc_vec.*[L L L]);
%
meanS1 = trapz(tau, S_vec(:,1))/(tau_f-tau_i);
meanS2 = trapz(tau, S_vec(:,2))/(tau_f-tau_i);
meanS3 = trapz(tau, S_vec(:,3))/(tau_f-tau_i);
meanD1 = trapz(tau, D_vec(:,1))/(tau_f-tau_i);
meanD2 = trapz(tau, D_vec(:,2))/(tau_f-tau_i);
meanD3 = trapz(tau, D_vec(:,3))/(tau_f-tau_i);

if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    plot(tau, S_vec(:,1))
    title('\itS_1 \itvs \rmFalse time','FontSize',12)
    xlabel('\tau', 'FontSize',14), ylabel('\itS_1', 'FontSize',14)

    figure
    plot(tau, S_vec(:,2))
    title('\itS_2 \itvs \rmFalse time','FontSize',12)
    xlabel('\tau', 'FontSize',14), ylabel('\itS_2', 'FontSize',14)

    figure
    plot(tau, S_vec(:,3))
    title('\itS_3 \itvs \rmFalse time','FontSize',12)
    xlabel('\tau', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)

    figure
    plot(tau, D_vec(:,1))
    title('\itD_1 \itvs \rmFalse time','FontSize',12)
    xlabel('\tau', 'FontSize',14), ylabel('\itD_1', 'FontSize',14)

    figure
    plot(tau, D_vec(:,2))
    title('\itD_2 \itvs \rmFalse time','FontSize',12)
    xlabel('\tau', 'FontSize',14), ylabel('\itD_2', 'FontSize',14)

    figure
    plot(tau, D_vec(:,3))
    title('\itD_3 \itvs \rmFalse time','FontSize',12)
    xlabel('\tau', 'FontSize',14), ylabel('\itD_3', 'FontSize',14)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'S and D vectors vs False time', 'NumberTitle', 'on')
subplot(2,3,1); plot(tau, S_vec(:,1))
title('\itS_1','FontSize',8)
subplot(2,3,2); plot(tau, S_vec(:,2))
title('\itS_2','FontSize',8)
subplot(2,3,3); plot(tau, S_vec(:,3))
title('\itS_3','FontSize',8)
subplot(2,3,4); plot(tau, D_vec(:,1))
title('\itD_1','FontSize',8)
subplot(2,3,5); plot(tau, D_vec(:,2))
title('\itD_2','FontSize',8)
subplot(2,3,6); plot(tau, D_vec(:,3))
title('\itD_3','FontSize',8)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S_vec_mean = [meanS1  meanS2  meanS3];
S_vec_o = S_vec_mean...
          ./[norma(S_vec_mean) norma(S_vec_mean) norma(S_vec_mean)];
D_vec_mean = [meanD1  meanD2  meanD3];
D_vec_o = D_vec_mean...
          ./[norma(D_vec_mean) norma(D_vec_mean) norma(D_vec_mean)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%