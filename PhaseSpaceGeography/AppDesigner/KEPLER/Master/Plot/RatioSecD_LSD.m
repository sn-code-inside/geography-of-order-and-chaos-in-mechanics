    freq_ratio_12(:,:) = abs(freq_1(:,:)./freq_2(:,:));
    freq_ratio_13(:,:) = abs(freq_1(:,:)./freq_3(:,:));
    freq_ratio_23(:,:) = abs(freq_2(:,:)./freq_3(:,:));
    
    figure
    hold on
    plot(S3prime, freq_ratio_12(:,1),'r')
    plot(S3prime, freq_ratio_13(:,1),'k')
    plot(S3prime, freq_ratio_23(:,1),'b')
    legend('Frequency 1 over 2','Frequency 1 over 3', 'Frequency 2 over 3')
    hold off
    title(['Frequency ratios \itvs \itS_3 \rmwith \itD_3 = \rm',D3_str],'FontSize',12)
    xlabel('\itS_3', 'FontSize',14), ylabel('Frequency ratios', 'FontSize',14) 