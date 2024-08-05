    figure
    hold on
    plot(G_, freq_1(:,:),'r')
    plot(G_, freq_2(:,:),'k')
    plot(G_, freq_3(:,:),'b')
    legend('Frequency 1','Frequency 2', 'Frequency 3')
    hold off
    title(['Frequencies \times1000 \itvs \itG \rmwith \itG_3 = \rm',G3_Value],'FontSize',12)
    xlabel('\itG', 'FontSize',14), ylabel('Frequencies', 'FontSize',14)