if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure%('WindowButtonDownFcn', 'click_LGG3')
    colormap(gray)
    surfc(G_3, G_, freq_1, 'FaceColor', 'interp', 'LineStyle', ':');
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title('Frequency 1 \times1000', 'FontSize',14)
    
    figure%('WindowButtonDownFcn', 'click_LGG3')
    colormap(gray)
    surfc(G_3, G_, freq_2, 'FaceColor', 'interp', 'LineStyle', ':');
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title('Frequency 2 \times1000', 'FontSize',14)
    
    figure%('WindowButtonDownFcn', 'click_LGG3')
    colormap(gray)
    surfc(G_3, G_, freq_3, 'FaceColor', 'interp', 'LineStyle', ':');
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title('Frequency 3 \times1000', 'FontSize',14)
end

figure('Name', 'Frequencies', 'NumberTitle', 'on')
colormap(gray)
subplot(2,2,1);  
    surfc(G_3, G_, freq_1, 'FaceColor', 'interp', 'LineStyle', ':');
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title('Frequency 1 \times1000', 'FontSize',14)

subplot(2,2,2);
    surfc(G_3, G_, freq_2, 'FaceColor', 'interp', 'LineStyle', ':');
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title('Frequency 2 \times1000', 'FontSize',14)
    
subplot(2,2,3);
    surfc(G_3, G_, freq_3, 'FaceColor', 'interp', 'LineStyle', ':');
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title('Frequency 3 \times1000', 'FontSize',14)