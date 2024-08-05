
if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure%('WindowButtonDownFcn', 'click_LSD')
    [C,h] = contour(D3prime, S3prime, freq_1);
    clabel(C,h);
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title('Level lines of Frequency 1', 'FontSize',14)

    figure%('WindowButtonDownFcn', 'click_LSD')
    [C,h] = contour(D3prime, S3prime, freq_2);
    clabel(C,h);
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title('Level lines of Frequency 2', 'FontSize',14)
    
    figure%('WindowButtonDownFcn', 'click_LSD')
    [C,h] = contour(D3prime, S3prime, freq_3);
    clabel(C,h);
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title('Level lines of Frequency 3', 'FontSize',14)
end

figure('Name', 'Frequencies (level lines)', 'NumberTitle', 'on')
colormap(gray)
subplot(2,2,1);
    [C,h] = contour(D3prime, S3prime, freq_1);
    clabel(C,h);
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title('Level lines of Frequency 1', 'FontSize',14)
subplot(2,2,2);
    [C,h] = contour(D3prime, S3prime, freq_2);
    clabel(C,h);
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title('Level lines of Frequency 2', 'FontSize',14)
subplot(2,2,3);
    [C,h] = contour(D3prime, S3prime, freq_3);
    clabel(C,h);
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title('Level lines of Frequency 3', 'FontSize',14)