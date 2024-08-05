    figure
    hold on
    plot(S3prime, freq_1(:,:),'r')
    plot(S3prime, freq_2(:,:),'k')
    plot(S3prime, freq_3(:,:),'b')
    legend('Frequency 1','Frequency 2', 'Frequency 3')
    hold off
    title(['Frequencies \times1000 \itvs \itS_3 \rmwith \itD_3 = \rm',D3_str],'FontSize',12)
    xlabel('\itS_3', 'FontSize',14), ylabel('Frequencies', 'FontSize',14) 