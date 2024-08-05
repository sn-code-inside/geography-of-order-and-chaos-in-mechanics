
freq_ratio_12(:,:) = abs(freq_1(:,:)./freq_2(:,:));
freq_ratio_13(:,:) = abs(freq_1(:,:)./freq_3(:,:));
freq_ratio_23(:,:) = abs(freq_2(:,:)./freq_3(:,:));


if strcmp(get(app.SingleFigures, 'Checked'),'on')  
    figure%('WindowButtonDownFcn', 'click_LSD')
    [C,h] = contour(D3prime, S3prime, freq_ratio_12);
    clabel(C,h);
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title({'Level lines of the Frequency 1 over 2'}, 'FontSize',14)
    
    figure%('WindowButtonDownFcn', 'click_LSD')
    [C,h] = contour(D3prime, S3prime, freq_ratio_13);
    clabel(C,h);
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title({'Level lines of the Frequency 1 over 3'}, 'FontSize',14)    
    
    figure%('WindowButtonDownFcn', 'click_LSD')
    [C,h] = contour(D3prime, S3prime, freq_ratio_23);
    clabel(C,h);
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title({'Level lines of the Frequency 2 over 3'}, 'FontSize',14)
end

figure('Name', 'Frequency ratio', 'NumberTitle', 'on')
colormap(gray)
subplot(2,2,1);
    [C,h] = contour(D3prime, S3prime, freq_ratio_12);
    clabel(C,h);
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title({'Level lines of the Frequency 1 over 2'}, 'FontSize',14)
subplot(2,2,2);
    [C,h] = contour(D3prime, S3prime, freq_ratio_13);
    clabel(C,h);
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title({'Level lines of the Frequency 1 over 3'}, 'FontSize',14)  
subplot(2,2,3);
    [C,h] = contour(D3prime, S3prime, freq_ratio_23);
    clabel(C,h);
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title({'Level lines of the Frequency 2 over 3'}, 'FontSize',14)