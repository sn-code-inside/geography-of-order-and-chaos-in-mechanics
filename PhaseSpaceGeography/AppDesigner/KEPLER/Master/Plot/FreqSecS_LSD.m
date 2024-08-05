    figure
    hold on
    plot(D3prime, freq_1(:,:),'r')
    plot(D3prime, freq_2(:,:),'k')
    plot(D3prime, freq_3(:,:),'b')
    legend('Frequency 1','Frequency 2', 'Frequency 3')
    hold off
    title(['Frequencies \times1000 \itvs \itD_3 \rmwith \itS_3 = \rm',S3_str],'FontSize',12)
    xlabel('\itD_3', 'FontSize',14), ylabel('Frequencies', 'FontSize',14)    