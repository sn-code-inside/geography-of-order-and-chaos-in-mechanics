
if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure%('WindowButtonDownFcn', 'click_LSD')
    colormap(gray)
    surfc(D3prime, S3prime, freq_1, 'FaceColor', 'interp', 'LineStyle', ':');
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title('Frequency 1 \times1000', 'FontSize',14)
    
    figure%('WindowButtonDownFcn', 'click_LSD')
    colormap(gray)
    surfc(D3prime, S3prime, freq_2, 'FaceColor', 'interp', 'LineStyle', ':');
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title('Frequency 2 \times1000', 'FontSize',14)
    
    figure%('WindowButtonDownFcn', 'click_LSD')
    colormap(gray)
    surfc(D3prime, S3prime, freq_3, 'FaceColor', 'interp', 'LineStyle', ':');
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title('Frequency 3 \times1000', 'FontSize',14)
end

figure('Name', 'Frequencies', 'NumberTitle', 'on')
colormap(gray)
subplot(2,2,1); 
    surfc(D3prime, S3prime, freq_1, 'FaceColor', 'interp', 'LineStyle', ':');
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title('Frequency 1 \times1000', 'FontSize',14)
subplot(2,2,2);    
    surfc(D3prime, S3prime, freq_2, 'FaceColor', 'interp', 'LineStyle', ':');
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title('Frequency 2 \times1000', 'FontSize',14)
subplot(2,2,3);    
    surfc(D3prime, S3prime, freq_3, 'FaceColor', 'interp', 'LineStyle', ':');
    xlabel('\itD_3', 'FontSize',14), ylabel('\itS_3', 'FontSize',14)
    title('Frequency 3 \times1000', 'FontSize',14)