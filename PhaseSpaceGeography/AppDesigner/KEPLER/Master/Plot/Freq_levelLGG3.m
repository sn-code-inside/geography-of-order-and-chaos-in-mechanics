
if strcmp(get(app.SingleFigures, 'Checked'),'on')    
    figure%('WindowButtonDownFcn', 'click_LGG3')
    [C,h] = contour(G_3, G_, freq_1);
    clabel(C,h);
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title('Level lines of Frequency 1', 'FontSize',14)

    figure%('WindowButtonDownFcn', 'click_LGG3')
    [C,h] = contour(G_3, G_, freq_2);
    clabel(C,h);
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title('Level lines of Frequency 2', 'FontSize',14)
    
    figure%('WindowButtonDownFcn', 'click_LGG3')
    [C,h] = contour(G_3, G_, freq_3);
    clabel(C,h);
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title('Level lines of Frequency 3', 'FontSize',14)
end

figure('Name', 'Frequencies (level lines)', 'NumberTitle', 'on')
colormap(gray)
subplot(2,2,1);   
    [C,h] = contour(G_3, G_, freq_1);
    clabel(C,h);
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title('Level lines of Frequency 1', 'FontSize',14)
subplot(2,2,2);
    [C,h] = contour(G_3, G_, freq_2);
    clabel(C,h);
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title('Level lines of Frequency 2', 'FontSize',14) 
subplot(2,2,3);
    [C,h] = contour(G_3, G_, freq_3);
    clabel(C,h);
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title('Level lines of Frequency 3', 'FontSize',14)