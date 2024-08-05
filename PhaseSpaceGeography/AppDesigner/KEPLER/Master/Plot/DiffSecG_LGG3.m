if strcmp(get(app.SingleFigures, 'Checked'),'on')
    if str2num(get(app.nstep1LGG3,'Value')) > 0;
        figure
        plot(G_3, FMI_1(:,:))
        title(['FMI 1 \itvs \itG_3 \rmwith \itG = ', G_Value], 'FontSize',12)
        xlabel('\itG_3', 'FontSize',14), ylabel('FMI 1', 'FontSize',14)
    end

    if str2num(get(app.nstep2LGG3,'Value')) > 0;
        figure
        plot(G_3, FMI_2(:,:))
        title(['FMI 2 \itvs \itG_3 \rmwith \itG = ', G_Value], 'FontSize',12)
        xlabel('\itG_3', 'FontSize',14), ylabel('FMI 2', 'FontSize',14)
    end

    if str2num(get(app.nstep1LGG3,'Value')) > 0;
        figure
        plot(G_3, FMI_3(:,:))
        title(['FMI 3 \itvs \itG_3 \rmwith \itG = ', G_Value], 'FontSize',12)
        xlabel('\itG_3', 'FontSize',14), ylabel('FMI 3', 'FontSize',14)
    end
end

figure('Name', 'FMI (section G)', 'NumberTitle', 'on')
colormap(gray)
subplot(2,2,1);
    plot(G_3, FMI_1(:,:))
    title(['FMI 1 \itvs \itG_3 \rmwith \itG = ', G_Value], 'FontSize',12)
    xlabel('\itG_3', 'FontSize',14), ylabel('FMI_ 1', 'FontSize',14)
subplot(2,2,2);
    plot(G_3, FMI_2(:,:))
    title(['FMI 2 \itvs \itG_3 \rmwith \itG = ', G_Value], 'FontSize',12)
    xlabel('\itG_3', 'FontSize',14), ylabel('FMI 2', 'FontSize',14)
subplot(2,2,3);
    plot(G_3, FMI_3(:,:))
    title(['FMI 3 \itvs \itG_3 \rmwith \itG = ', G_Value], 'FontSize',12)
    xlabel('\itG_3', 'FontSize',14), ylabel('FMI 3', 'FontSize',14)