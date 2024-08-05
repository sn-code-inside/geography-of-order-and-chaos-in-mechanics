
if strcmp(get(app.SingleFigures, 'Checked'),'on')
    if str2num(get(app.nstep1LSD,'Value')) > 0;
        figure%('WindowButtonDownFcn', 'click_LSD')
        colormap(gray)
        surf(D3prime, S3prime, FMI_1, 'FaceColor', 'interp', 'LineStyle', 'none');
        view(2)
        xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
        title({'FMI 1'}, 'FontSize',14)
    end
 
    if str2num(get(app.nstep2LSD,'Value')) > 0;
        figure%('WindowButtonDownFcn', 'click_LSD')
        colormap(gray)
        surf(D3prime, S3prime, FMI_2, 'FaceColor', 'interp', 'LineStyle', 'none');
        view(2)
        xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
        title({'FMI 2'}, 'FontSize',14)
    end
    
    if str2num(get(app.nstep3LSD,'Value')) > 0;
        figure%('WindowButtonDownFcn', 'click_LSD')
        colormap(gray)
        surf(D3prime, S3prime, FMI_3, 'FaceColor', 'interp', 'LineStyle', 'none');
        view(2)
        xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
        title({'FMI 3'}, 'FontSize',14)
    end
end

figure('Name', 'Frequency Modulation Indicator', 'NumberTitle', 'on')
colormap(gray)
subplot(2,2,1);
    surf(D3prime, S3prime, FMI_1, 'FaceColor', 'interp', 'LineStyle', 'none');
    view(2)
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title({'FMI 1'}, 'FontSize',14)
subplot(2,2,2);
    surf(D3prime, S3prime, FMI_2, 'FaceColor', 'interp', 'LineStyle', 'none');
    view(2)
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title({'FMI 2'}, 'FontSize',14)
subplot(2,2,3);
    surf(D3prime, S3prime, FMI_3, 'FaceColor', 'interp', 'LineStyle', 'none');
    view(2)
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title({'FMI 3'}, 'FontSize',14)