%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Plot trajectories
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global dist1 dist2 dist3
if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    view(3)
    hold on
    plot3(q_vec(:,1), q_vec(:,2), q_vec(:,3))   
    plot3(0,0,0,'-mo','MarkerFaceColor','yellow','MarkerSize',5)
    if dist1
        plot3(dist1,0,0,'-mo','MarkerFaceColor','black','MarkerSize',5)
    end
    if dist2
        plot3(0,dist2,0,'-mo','MarkerFaceColor','black','MarkerSize',5)
    end
    if dist3
        plot3(0,0,dist3,'-mo','MarkerFaceColor','black','MarkerSize',5)
    end
    title('Space trajectory', 'FontSize',14)
    xlabel('\itq_1', 'FontSize',14), ylabel('\itq_2', 'FontSize',14),...
        zlabel('\itq_3', 'FontSize',14)
    hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure
    plot3(p_vec(:,1), p_vec(:,2), p_vec(:,3))
    title('Momentum trajectory', 'FontSize',14)
    xlabel('\itp_1', 'FontSize',14), ylabel('\itp_2', 'FontSize',14),...
        zlabel('\itp_3', 'FontSize',14)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'Trajectories', 'NumberTitle', 'on',...
    'Units','pixels', 'Position',[12,250,1000,400])
subplot(1,2,1)
hold on
plot3(q_vec(:,1), q_vec(:,2), q_vec(:,3))
view(3)
plot3(0,0,0,'-mo','MarkerFaceColor','yellow','MarkerSize',5)
    if dist1
        plot3(dist1,0,0,'-mo','MarkerFaceColor','black','MarkerSize',5)
    end
    if dist2
        plot3(0,dist2,0,'-mo','MarkerFaceColor','black','MarkerSize',5)
    end
    if dist3
        plot3(0,0,dist3,'-mo','MarkerFaceColor','black','MarkerSize',5)
    end
title('Space trajectory', 'FontSize',14)
xlabel('\itq_1', 'FontSize',14), ylabel('\itq_2', 'FontSize',14),...
    zlabel('\itq_3', 'FontSize',14)
hold off
subplot(1,2,2);plot3(p_vec(:,1), p_vec(:,2), p_vec(:,3))
title('Momentum trajectory', 'FontSize',14)
xlabel('\itp_1', 'FontSize',14), ylabel('\itp_2', 'FontSize',14),...
    zlabel('\itp_3', 'FontSize',14)
