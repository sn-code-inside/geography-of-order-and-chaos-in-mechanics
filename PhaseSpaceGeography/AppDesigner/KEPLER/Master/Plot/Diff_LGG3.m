if strcmp(get(app.SingleFigures, 'Checked'),'on')
    if str2num(get(app.nstep1LGG3,'Value')) > 0;
        figure%('WindowButtonDownFcn', 'click_LGG3')
        colormap(jet)
        surf(G_3, G_, FMI_1, 'FaceColor', 'interp', 'LineStyle', 'none');
        view(2)
        xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
        title({'FMI 1'}, 'FontSize',14)
    end

    if str2num(get(app.nstep2LGG3,'Value')) > 0;
        figure%('WindowButtonDownFcn', 'click_LGG3')
        colormap(jet)
        surf(G_3, G_, FMI_2, 'FaceColor', 'interp', 'LineStyle', 'none');
        view(2)
        xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
        title({'FMI 2'}, 'FontSize',14)
    end

    if str2num(get(app.nstep3LGG3,'Value')) > 0;
        figure%('WindowButtonDownFcn', 'click_LGG3')
        colormap(jet)
        surf(G_3, G_, FMI_3, 'FaceColor', 'interp', 'LineStyle', 'none');
        view(2)
        xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
        title({'FMI 3'}, 'FontSize',14)
    end
end

figure('Name', 'Frequency Modulation Indicator', 'NumberTitle', 'on')
colormap(gray)
subplot(2,2,1); 
    surf(G_3, G_, FMI_1, 'FaceColor', 'interp', 'LineStyle', 'none');
    view(2)
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title({'FMI 1'}, 'FontSize',14)
subplot(2,2,2);
    surf(G_3, G_, FMI_2, 'FaceColor', 'interp', 'LineStyle', 'none');
    view(2)
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title({'FMI 2'}, 'FontSize',14)
subplot(2,2,3);
    surf(G_3, G_, FMI_3, 'FaceColor', 'interp', 'LineStyle', 'none');
    view(2)
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title({'FMI 3'}, 'FontSize',14)