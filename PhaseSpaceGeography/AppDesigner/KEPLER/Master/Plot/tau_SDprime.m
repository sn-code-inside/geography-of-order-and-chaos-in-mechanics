%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
qp2SD
SD2SpDp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    plot(tau, Sprime_vec(:,1)*2./L)
    title('Rotated-normalized \itS_1 \itvs \rmFalse time','FontSize',12)
    xlabel('\tau', 'FontSize',14)%, ylabel('Rotated \itS_1', 'FontSize',14)

    figure
    plot(tau, Sprime_vec(:,2)*2./L)
    title('Rotated-normalized \itS_2 \itvs \rmFalse time','FontSize',12)
    xlabel('\tau', 'FontSize',14)%, ylabel('Rotated \itS_2', 'FontSize',14)

    figure
    plot(tau, Sprime_vec(:,3)*2./L)
    title('Rotated-normalized \itS_3 \itvs \rmFalse time','FontSize',12)
    xlabel('\tau', 'FontSize',14)%, ylabel('Rotated \itS_3', 'FontSize',14)

    figure
    plot(tau, Dprime_vec(:,1)*2./L)
    title('Rotated-normalized \itD_1 \itvs \rmFalse time','FontSize',12)
    xlabel('\tau', 'FontSize',14)%, ylabel('Rotated \itD_1', 'FontSize',14)

    figure
    plot(tau, Dprime_vec(:,2)*2./L)
    title('Rotated-normalized \itD_2 \itvs \rmFalse time','FontSize',12)
    xlabel('\tau', 'FontSize',14)%, ylabel('Rotated \itD_2', 'FontSize',14)

    figure
    plot(tau, Dprime_vec(:,3)*2./L)
    title('Rotated-normalized \itD_3 \itvs \rmFalse time','FontSize',12)
    xlabel('\tau', 'FontSize',14)%, ylabel('Rotated \itD_3', 'FontSize',14)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'Rotated-normalized S and D vectors vs False time', 'NumberTitle', 'on')
subplot(2,3,1); plot(tau, Sprime_vec(:,1)*2./L)
title('Rotated-normalized \itS_1','FontSize',9)
subplot(2,3,2); plot(tau, Sprime_vec(:,2)*2./L)
title('Rotated-normalized \itS_2','FontSize',9)
subplot(2,3,3); plot(tau, Sprime_vec(:,3)*2./L)
title('Rotated-normalized \itS_3','FontSize',9)
subplot(2,3,4); plot(tau, Dprime_vec(:,1)*2./L)
title('Rotated-normalized \itD_1','FontSize',9)
subplot(2,3,5); plot(tau, Dprime_vec(:,2)*2./L)
title('Rotated-normalized \itD_2','FontSize',9)
subplot(2,3,6); plot(tau, Dprime_vec(:,3)*2./L)
title('Rotated-normalized \itD_3','FontSize',9)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'Rotated-normalized S and D vectors', 'NumberTitle', 'on',...
    'Units','pixels', 'Position',[100,240,824,340])
subplot(1,2,1); plot(Sprime_vec(:,1)*2./L, Sprime_vec(:,2)*2./L)
xlabel('Rotated-normalized \itS_1', 'FontSize',12), ylabel('Rotated-normalized  \itS_2', 'FontSize',12)
subplot(1,2,2); plot(Dprime_vec(:,1)*2./L, Dprime_vec(:,2)*2./L)
xlabel('Rotated-normalized \itD_1', 'FontSize',12), ylabel('Rotated-normalized  \itD_2', 'FontSize',12)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%