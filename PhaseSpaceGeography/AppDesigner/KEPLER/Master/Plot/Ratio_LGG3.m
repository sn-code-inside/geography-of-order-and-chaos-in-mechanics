
freq_ratio_12(:,:) = abs(freq_1(:,:)./freq_2(:,:));
freq_ratio_13(:,:) = abs(freq_1(:,:)./freq_3(:,:));
freq_ratio_32(:,:) = abs(freq_3(:,:)./freq_2(:,:));

if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure%('WindowButtonDownFcn', 'click_LGG3')
    [C,h] = contour(G_3, G_, freq_ratio_12);
    clabel(C,h);
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title({'Level lines of the Frequency 1 over 2'}, 'FontSize',14)
    
    figure%('WindowButtonDownFcn', 'click_LGG3')
    [C,h] = contour(G_3, G_, freq_ratio_13);
    clabel(C,h);
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title({'Level lines of the Frequency 1 over 3'}, 'FontSize',14)    
    
    figure%('WindowButtonDownFcn', 'click_LGG3')
    [C,h] = contour(G_3, G_, freq_ratio_32);
    clabel(C,h);
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title({'Level lines of the Frequency 3 over 2'}, 'FontSize',14)
end

figure('Name', 'Frequency ratio', 'NumberTitle', 'on')
colormap(gray)
subplot(2,2,1);
    [C,h] = contour(G_3, G_, freq_ratio_12);
    clabel(C,h);
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title({'Level lines of the Frequency 1 over 2'}, 'FontSize',14)
subplot(2,2,2);
    [C,h] = contour(G_3, G_, freq_ratio_13);
    clabel(C,h);
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title({'Level lines of the Frequency 1 over 3'}, 'FontSize',14)
subplot(2,2,3);
    [C,h] = contour(G_3, G_, freq_ratio_32);
    clabel(C,h);
    xlabel('\itG_3', 'FontSize',14), ylabel('\itG', 'FontSize',14)
    title({'Level lines of the Frequency 3 over 2'}, 'FontSize',14)