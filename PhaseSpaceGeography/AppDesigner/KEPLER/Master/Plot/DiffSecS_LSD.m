if strcmp(get(app.SingleFigures, 'Checked'),'on')
    if str2num(get(app.nstep1LSD,'Value')) > 0;
        figure
        plot(D3prime, FMI_1(:,:))
        title(['FMI 1 \itvs \itD_3 \rmwith \itS_3 = ', S3_str], 'FontSize',12)
        xlabel('\itD_3', 'FontSize',14), ylabel('FMI 1', 'FontSize',14)
    end
   
    if str2num(get(app.nstep2LSD,'Value')) > 0;
        figure
        plot(D3prime, FMI_2(:,:))
        title(['FMI 2 \itvs \itD_3 \rmwith \itS_3 = ', S3_str], 'FontSize',12)
        xlabel('\itD_3', 'FontSize',14), ylabel('FMI 2', 'FontSize',14)
    end

    if str2num(get(app.nstep3LSD,'Value')) > 0;
        figure
        plot(D3prime, FMI_3(:,:))
        title(['FMI 3 \itvs \itD_3 \rmwith \itS_3 = ', S3_str], 'FontSize',12)
        xlabel('\itD_3', 'FontSize',14), ylabel('FMI 3', 'FontSize',14)
    end
end

figure('Name', 'FMI (section S3)', 'NumberTitle', 'on')
colormap(gray)
subplot(2,2,1);
    plot(D3prime, FMI_1(:,:))
    title(['FMI 1 \itvs \itD_3 \rmwith \itS_3 = ', S3_str], 'FontSize',12)
    xlabel('\itD_3', 'FontSize',14), ylabel('FMI 1', 'FontSize',14)
subplot(2,2,2);
    plot(D3prime, FMI_2(:,:))
    title(['FMI 2 \itvs \itD_3 \rmwith \itS_3 = ', S3_str], 'FontSize',12)
    xlabel('\itD_3', 'FontSize',14), ylabel('FMI 2', 'FontSize',14)
subplot(2,2,3);
    plot(D3prime, FMI_3(:,:))
    title(['FMI 3 \itvs \itD_3 \rmwith \itS_3 = ', S3_str], 'FontSize',12)
    xlabel('\itD_3', 'FontSize',14), ylabel('FMI 3', 'FontSize',14)