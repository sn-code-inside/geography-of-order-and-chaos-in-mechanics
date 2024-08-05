if strcmp(get(app.SingleFigures, 'Checked'),'on')
    if str2num(get(app.nstep1LGG3,'Value')) > 0;
        figure
        plot(G_, FMI_1(:,:))
        title(['FMI 1 \itvs \itG \rmwith \itG_3 = ', G3_Value], 'FontSize',12)
        xlabel('\itG', 'FontSize',14), ylabel('FMI 1', 'FontSize',14)
    end
 
    if str2num(get(app.nstep2LGG3,'Value')) > 0;
        figure
        plot(G_, FMI_2(:,:))
        title(['FMI 2 \itvs \itG \rmwith \itG_3 = ', G3_Value], 'FontSize',12)
        xlabel('\itG', 'FontSize',14), ylabel('FMI 2', 'FontSize',14)
    end

    if str2num(get(app.nstep3LGG3,'Value')) > 0;
        figure
        plot(G_, FMI_3(:,:))
        title(['FMI 3 \itvs \itG \rmwith \itG_3 = ', G3_Value], 'FontSize',12)
        xlabel('\itG', 'FontSize',14), ylabel('FMI 3', 'FontSize',14)
    end
end

figure('Name', 'FMI (section G3)', 'NumberTitle', 'on')
colormap(gray)
subplot(2,2,1);
    plot(G_, FMI_1(:,:))
    title(['FMI 1 \itvs \itG \rmwith \itG_3 = ', G3_Value], 'FontSize',12)
    xlabel('\itG', 'FontSize',14), ylabel('FMI 1', 'FontSize',14)
subplot(2,2,2);
    plot(G_, FMI_2(:,:))
    title(['FMI 2 \itvs \itG \rmwith \itG_3 = ', G3_Value], 'FontSize',12)
    xlabel('\itG', 'FontSize',14), ylabel('FMI 2', 'FontSize',14)
subplot(2,2,3);
    plot(G_, FMI_3(:,:))
    title(['FMI 3 \itvs \itG \rmwith \itG_3 = ', G3_Value], 'FontSize',12)
    xlabel('\itG', 'FontSize',14), ylabel('FMI 3', 'FontSize',14)