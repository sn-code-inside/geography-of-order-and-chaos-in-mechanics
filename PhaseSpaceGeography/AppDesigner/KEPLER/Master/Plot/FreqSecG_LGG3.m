    figure
    hold on
    plot(G_3, freq_1(:,:),'r')
    plot(G_3, freq_2(:,:),'k')
    plot(G_3, freq_3(:,:),'b')
    legend('Frequency 1','Frequency 2', 'Frequency 3')
    hold off
    title(['Frequencies \times1000 \itvs \itG_3 \rmwith \itG = \rm',G_Value],'FontSize',12)
    xlabel('\itG_3', 'FontSize',14), ylabel('Frequencies', 'FontSize',14) 