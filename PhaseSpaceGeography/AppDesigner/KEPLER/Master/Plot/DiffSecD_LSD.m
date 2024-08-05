if strcmp(get(app.SingleFigures, 'Checked'),'on')
    if str2num(get(app.nstep1LSD,'Value')) > 0;
        figure
        plot(S3prime, FMI_1(:,:))
        title(['FMI 1 \itvs \itS_3 \rmwith \itD_3 = ', D3_str], 'FontSize',12)
        xlabel('\itS_3', 'FontSize',14), ylabel('FMI 1', 'FontSize',14)
    end

    if str2num(get(app.nstep2LSD,'Value')) > 0;
        figure
        plot(S3prime, FMI_2(:,:))
        title(['FMI 2 \itvs \itS_3 \rmwith \itD_3 = ', D3_str], 'FontSize',12)
        xlabel('\itS_3', 'FontSize',14), ylabel('FMI 2', 'FontSize',14)
    end

    if str2num(get(app.nstep3LSD,'Value')) > 0;
        figure
        plot(S3prime, FMI_3(:,:))
        title(['FMI 3 \itvs \itS_3 \rmwith \itD_3 = ', D3_str], 'FontSize',12)
        xlabel('\itS_3', 'FontSize',14), ylabel('FMI 3', 'FontSize',14)
    end
end

figure('Name', 'FMI (section D3)', 'NumberTitle', 'on')
colormap(gray)
subplot(2,2,1);
    plot(S3prime, FMI_1(:,:))
    title(['FMI 1 \itvs \itS_3 \rmwith \itD_3 = ', D3_str], 'FontSize',12)
    xlabel('\itS_3', 'FontSize',14), ylabel('FMI 1', 'FontSize',14)

subplot(2,2,2);
    plot(S3prime, FMI_2(:,:))
    title(['FMI 2 \itvs \itS_3 \rmwith \itD_3 = ', D3_str], 'FontSize',12)
    xlabel('\itS_3', 'FontSize',14), ylabel('FMI 2', 'FontSize',14)

subplot(2,2,3);
    plot(S3prime, FMI_3(:,:))
    title(['FMI 3 \itvs \itS_3 \rmwith \itD_3 = ', D3_str], 'FontSize',12)
    xlabel('\itS_3', 'FontSize',14), ylabel('FMI 3', 'FontSize',14)