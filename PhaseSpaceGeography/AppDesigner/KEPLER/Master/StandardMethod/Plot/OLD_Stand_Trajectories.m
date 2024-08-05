%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Plot trajectories
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nHp1 = str2num(app.popupmenuHp1.Value);
nHp2 = str2num(app.popupmenuHp2.Value);
nHp3 = str2num(app.popupmenuHp3.Value);
nHp4 = str2num(app.popupmenuHp4.Value);
nHp5 = str2num(app.popupmenuHp5.Value);

if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    hold on
    plot3(q_vec(:,1), q_vec(:,2), q_vec(:,3))

    if (nHp1==11)|(nHp2==11)|(nHp3==11)|(nHp4==11)|(nHp5==11)
        plot3(2,0,0,'-mo','MarkerFaceColor','black','MarkerSize',5)
        plot3(0,0,0,'-mo','MarkerFaceColor','black','MarkerSize',5)
    end

    if (nHp1==12)|(nHp2==12)|(nHp3==12)|(nHp4==12)|(nHp5==12)
        plot3(0,2,0,'-mo','MarkerFaceColor','black','MarkerSize',5)
        plot3(0,0,0,'-mo','MarkerFaceColor','black','MarkerSize',5)
    end

    if (nHp1==13)|(nHp2==13)|(nHp3==13)|(nHp4==13)|(nHp5==13)
        plot3(0,0,2,'-mo','MarkerFaceColor','black','MarkerSize',5)
        plot3(0,0,0,'-mo','MarkerFaceColor','black','MarkerSize',5)
    end

    title('Space trajectory (standard method)', 'FontSize',14)
    xlabel('\itq_1', 'FontSize',14), ylabel('\itq_2', 'FontSize',14),...
        zlabel('\itq_3', 'FontSize',14)

    hold off

    figure
    plot3(p_vec(:,1), p_vec(:,2), p_vec(:,3))

    title('Momentum trajectory (standard method)', 'FontSize',14)
    xlabel('\itp_1', 'FontSize',14), ylabel('\itp_2', 'FontSize',14),...
        zlabel('\itp_3', 'FontSize',14)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'Trajectories', 'NumberTitle', 'on',...
    'Units','pixels', 'Position',[12,250,1000,400])
subplot(1,2,1); plot3(q_vec(:,1), q_vec(:,2), q_vec(:,3))
hold on
    if (nHp1==11)|(nHp2==11)|(nHp3==11)|(nHp4==11)|(nHp5==11)
        plot3(2,0,0,'-mo','MarkerFaceColor','black','MarkerSize',5)
        plot3(0,0,0,'-mo','MarkerFaceColor','black','MarkerSize',5)
    end

    if (nHp1==12)|(nHp2==12)|(nHp3==12)|(nHp4==12)|(nHp5==12)
        plot3(0,2,0,'-mo','MarkerFaceColor','black','MarkerSize',5)
        plot3(0,0,0,'-mo','MarkerFaceColor','black','MarkerSize',5)
    end

    if (nHp1==13)|(nHp2==13)|(nHp3==13)|(nHp4==13)|(nHp5==13)
        plot3(0,0,2,'-mo','MarkerFaceColor','black','MarkerSize',5)
        plot3(0,0,0,'-mo','MarkerFaceColor','black','MarkerSize',5)
    end
hold off
    title('Space trajectory (standard method)', 'FontSize',14)
    xlabel('\itq_1', 'FontSize',14), ylabel('\itq_2', 'FontSize',14),...
        zlabel('\itq_3', 'FontSize',14)

subplot(1,2,2); plot3(p_vec(:,1), p_vec(:,2), p_vec(:,3))
    title('Momentum trajectory (standard method)', 'FontSize',14)
    xlabel('\itp_1', 'FontSize',14), ylabel('\itp_2', 'FontSize',14),...
        zlabel('\itp_3', 'FontSize',14)    