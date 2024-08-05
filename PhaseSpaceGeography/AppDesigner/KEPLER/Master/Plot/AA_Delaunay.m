%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
norma_q = sqrt((sum((q_vec.^2)'))');
sm_ax = norma_q./(2-((sum((p_vec.^2)'))').*norma_q);
L = sqrt(sm_ax);
Delta = scalarp(q_vec,p_vec)./L;
delta = (sm_ax-norma(q_vec))./sm_ax;
l = 180/pi*atan2(-delta.*sin(Delta)+Delta.*cos(Delta), delta.*cos(Delta)+Delta.*sin(Delta));
G_vec = vectorp(q_vec, p_vec);
G = norma(G_vec);
Ecc_vec = vectorp(p_vec, G_vec)-q_vec./[norma_q  norma_q  norma_q];
Ecc = norma(Ecc_vec);
G_prj = sqrt(G_vec(:,1).^2+G_vec(:,2).^2);
if all(G_prj < 1e-15)
    if strcmp(get(app.warningbox, 'Checked'),'on')
        warndlg('Node line not defined')
    end
    omega = 180/pi*atan2(Ecc_vec(:,2), Ecc_vec(:,1));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure
    polar(pi/180*l, L,'.')
    title({'Semimajor axis'; '\itvs'; '\rmMean Longitude'})

    figure
    polar(pi/180*omega, G,'.')
    title({'\itG vs \omega'})
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure('Name', 'Delaunay Action-Angle vs False time', 'NumberTitle', 'on')    
    subplot(2,2,1); plot(tau, L)
    title('\itL','FontSize',8)
    subplot(2,2,2); plot(tau, G)
    title('Angular momentum','FontSize',8)
    subplot(2,2,3); plot(tau, l)
    title('Mean Longitude','FontSize',8)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end    
    subplot(2,2,4); plot(tau, omega)
    title('Longitude of pericenter','FontSize',8)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %{
    figure
    if strcmp(get(app.LargeMS, 'Checked'),'on')
        MarkSize = 6;
    else
        MarkSize = 4;
    end
    plot3(G.*cos(pi/180*omega), G.*sin(pi/180*omega), l,'.','MarkerSize',MarkSize)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_z
    end
    title('Torus Angular momentum - Longitude of pericenter','FontSize',12)
    xlabel('Polar \itG - \omega', 'FontSize',10)
    ylabel('Polar \itG - \omega', 'FontSize',10)
    zlabel('Mean anomaly (degrees)', 'FontSize',10)
    %}
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    node = [-G_vec(:,2)./sqrt(G_vec(:,1).^2+G_vec(:,2).^2)...
             G_vec(:,1)./sqrt(G_vec(:,1).^2+G_vec(:,2).^2)...
             zeros(size(G_vec(:,3)))];
    Omega = 180/pi*atan2(node(:,2), node(:,1));
    omega = 180/pi*atan2(scalarp(vectorp(node, Ecc_vec), G_vec)./G,...
            scalarp(node, Ecc_vec));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if strcmp(get(app.SingleFigures, 'Checked'),'on')
        figure
        polar(pi/180*l, L,'.')
        title({'\itL vs \rmmean anomaly'})

        figure
        polar(pi/180*omega, G,'.')
        title('\itG vs \omega')

        figure
        polar(pi/180*Omega, G_vec(:,3),'.')
        title('\itG_3 vs \Omega')
    end
    
    figure('Name', 'Delaunay (true) Action-Angle', 'NumberTitle', 'on')
    subplot(2,2,1); polar(pi/180*l, L,'.')
    title({'\itL vs \rmmean anomaly'})
    subplot(2,2,2); polar(pi/180*omega, G,'.')
    title('\itG vs \omega')
    subplot(2,2,3); polar(pi/180*Omega, G_vec(:,3),'.')
    title('\itG_3 vs \Omega')
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure('Name', 'Delaunay (true) Action-Angle vs False time', 'NumberTitle', 'on')
    subplot(2,3,1); plot(tau, L)
    title('\itL','FontSize',8)
    subplot(2,3,2); plot(tau, G)
    title('\itG','FontSize',8)
    subplot(2,3,3); plot(tau, G_vec(:,3))
    title('\itG_3','FontSize',8)
    subplot(2,3,4); plot(tau, l)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end
    title('Mean anomaly','FontSize',8)
    subplot(2,3,5); plot(tau, omega)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end
    title('Argument of pericenter','FontSize',8)
    subplot(2,3,6); plot(tau, Omega)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end
    title('Longitude of Ascending node','FontSize',8)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %{
    if all((abs(G_vec(:,3) - G_vec(1,3))) <= 1e-5) 
        figure
        if strcmp(get(app.LargeMS, 'Checked'),'on')
            MarkSize = 6;
        else
            MarkSize = 4;
        end
        plot3(G.*cos(pi/180*omega), G.*sin(pi/180*omega), l,'.','MarkerSize',MarkSize)
        if strcmp(get(app.no_degree, 'Checked'),'off')
            Degree_z
        end      
        title('Torus Angular momentum - Argument of pericenter','FontSize',12)
        xlabel('Polar \itG - \omega', 'FontSize',10)
        ylabel('Polar \itG - \omega', 'FontSize',10)
        zlabel('Mean anomaly (degrees)', 'FontSize',10)
    end
    %}
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%