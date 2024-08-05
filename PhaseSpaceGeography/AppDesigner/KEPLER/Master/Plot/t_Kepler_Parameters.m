%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = norma(x_vec);
t = lambda^3*cumtrapz(tau,x);
norma_q = sqrt((sum((q_vec.^2)'))');
sm_ax = norma_q./(2-((sum((p_vec.^2)'))').*norma_q);
G_vec = vectorp(q_vec, p_vec);
G = norma(G_vec);
Ecc_vec = vectorp(p_vec, G_vec)-q_vec./[norma(q_vec)  norma(q_vec)  norma(q_vec)];
Ecc = norma(Ecc_vec);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Planar system
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (G_vec(1:10,1).^2+G_vec(1:10,2).^2) == 0;
    if strcmp(get(app.warningbox, 'Checked'),'on')
        warndlg('Node line not defined')
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    omega = 180/pi*atan2(Ecc_vec(:,2), Ecc_vec(:,1));
    if any(sm_ax <= 0)
        warndlg('Some values of the semimajor axis are negative')
        return
    end
    s = 180/pi*atan2(scalarp(q_vec,p_vec), (sm_ax-norma(q_vec))./sqrt(sm_ax));
    f = 180/pi*2*atan(sqrt((1+Ecc)./(1-Ecc)).*tan(pi/180*s/2));    
    
    if strcmp(get(app.SingleFigures, 'Checked'),'on')
        figure
        plot(t, sm_ax)
        title('Semimajor axis \itvs \rmTime','FontSize',12)
        xlabel('\itt', 'FontSize',14), ylabel('\ita', 'FontSize',14)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure
        plot(t, Ecc)
        title('Eccentricity \itvs \rmTime','FontSize',12)
        xlabel('\itt', 'FontSize',14), ylabel('\itE', 'FontSize',14)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure
        plot(t, omega)
        title('Longitude of pericentre \itvs \rmTime','FontSize',12)
        if strcmp(get(app.no_degree, 'Checked'),'off')
            Degree_y
        end 
        xlabel('\itt', 'FontSize',14), ylabel('\omega   (degrees)', 'FontSize',14)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure
        plot(t, f)
        title('True anomaly \itvs \rmTime','FontSize',12)
        if strcmp(get(app.no_degree, 'Checked'),'off')
            Degree_y
        end         
        xlabel('\itt', 'FontSize',14), ylabel('\itf   \rm(degrees)', 'FontSize',14)
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure('Name', 'Keplerian parameters vs Time', 'NumberTitle', 'on')
    subplot(2,2,1); plot(t,sm_ax)
    title('Semimajor axis','FontSize',8)
    subplot(2,2,2); plot(t,Ecc)
    title('Eccentricity','FontSize',8)
    subplot(2,2,3); plot(t,omega)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end 
    title('Longitude of pericentre','FontSize',8)
    subplot(2,2,4); plot(t,f)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end 
    title('True anomaly','FontSize',8)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    return
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                3D system
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
node = [-G_vec(:,2)./sqrt(G_vec(:,1).^2+G_vec(:,2).^2)...
         G_vec(:,1)./sqrt(G_vec(:,1).^2+G_vec(:,2).^2)...
         zeros(size(G_vec(:,3)))];
Omega = 180/pi*atan2(node(:,2), node(:,1));
omega = 180/pi*atan2(scalarp(vectorp(node, Ecc_vec), G_vec)./G,...
        scalarp(node, Ecc_vec));
incl = 180/pi*acos(G_vec(:,3)./G);
if any(sm_ax <= 0)
    warndlg('Some values of the semimajor axis are negative')
    return
end
s = 180/pi*atan2(scalarp(q_vec,p_vec), (sm_ax-norma(q_vec))./sqrt(sm_ax));
f = 180/pi*2*atan(sqrt((1+Ecc)./(1-Ecc)).*tan(pi/180*s/2));

if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    plot(t, sm_ax)
    title('Semimajor axis \itvs \rmTime','FontSize',12)
    xlabel('\itt', 'FontSize',14), ylabel('\ita', 'FontSize',14)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure
    plot(t, Ecc)
    title('Eccentricity \itvs \rmTime','FontSize',12)
    xlabel('\itt', 'FontSize',14), ylabel('\itE', 'FontSize',14)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure
    plot(t, Omega)
    title('Longitude of the ascending node \itvs \rmTime','FontSize',12)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end     
    xlabel('\itt', 'FontSize',14), ylabel('\Omega   (degrees)', 'FontSize',14)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure
    plot(t, omega)
    title('Argument of pericentre \itvs \rmTime','FontSize',12)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end     
    xlabel('\itt', 'FontSize',14), ylabel('\omega   (degrees)', 'FontSize',14)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure
    plot(t, incl)
    title('Inclination \itvs \rmTime','FontSize',12)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end     
    xlabel('\itt', 'FontSize',14), ylabel('\itI   \rm(degrees)', 'FontSize',14)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure
    plot(t, f)
    title('True anomaly \itvs \rmTime','FontSize',12)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end     
    xlabel('\itt', 'FontSize',14), ylabel('\itf   \rm(degrees)', 'FontSize',14)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'Keplerian parameters vs Time', 'NumberTitle', 'on')
subplot(2,3,1); plot(t,sm_ax)
title('Semimajor axis','FontSize',8)
subplot(2,3,2); plot(t,Ecc)
title('Eccentricity','FontSize',8)
subplot(2,3,3); plot(t,Omega)
title('Longitude of ascending node (deg)','FontSize',8)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end
subplot(2,3,4); plot(t,omega)
title('Argument of pericentre (deg)','FontSize',8)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end
subplot(2,3,5); plot(t,incl)
title('Inclination (deg)','FontSize',8)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end
subplot(2,3,6); plot(t,f)
title('True anomaly (deg)','FontSize',8)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%