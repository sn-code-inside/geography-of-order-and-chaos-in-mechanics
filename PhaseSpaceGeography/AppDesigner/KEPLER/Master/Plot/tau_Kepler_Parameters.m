%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    s = atan2(scalarp(q_vec,p_vec), (sm_ax-norma(q_vec))./sqrt(abs(sm_ax)));
    f = 180/pi*2*atan(sqrt((1+Ecc)./(1-Ecc)).*tan(s/2));    
    
    if strcmp(get(app.SingleFigures, 'Checked'),'on')
        figure
        plot(tau, sm_ax)
        title('Semimajor axis \itvs \rmFalse time','FontSize',12)
        xlabel('\tau', 'FontSize',14), ylabel('\ita', 'FontSize',14)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure
        plot(tau, Ecc)
        title('Eccentricity \itvs \rmFalse time','FontSize',12)
        xlabel('\tau', 'FontSize',14), ylabel('\itE', 'FontSize',14)   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure
        plot(tau, omega)
        title('Longitude of pericentre \itvs \rmFalse time','FontSize',12)
        if strcmp(get(app.no_degree, 'Checked'),'off')
            Degree_y
        end
        xlabel('\tau', 'FontSize',14), ylabel('\omega   (degrees)', 'FontSize',14)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure
        plot(tau, f)
        title('True anomaly \itvs \rmFalse time','FontSize',12)
        if strcmp(get(app.no_degree, 'Checked'),'off')
            Degree_y
        end        
        xlabel('\tau', 'FontSize',14), ylabel('\itf   \rm(degrees)', 'FontSize',14)
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure('Name', 'Keplerian parameters vs False time', 'NumberTitle', 'on')
    subplot(2,2,1); plot(tau,sm_ax)
    title('Semimajor axis','FontSize',8)
    subplot(2,2,2); plot(tau,Ecc)
    title('Eccentricity','FontSize',8)
    subplot(2,2,3); plot(tau,f)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end
    title('True anomaly','FontSize',8)
    subplot(2,2,4); plot(tau,omega)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end    
    title('Longitude of pericentre','FontSize',8)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    return
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 3D system
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
node = [-G_vec(:,2)./sqrt(G_vec(:,1).^2+G_vec(:,2).^2)...
         G_vec(:,1)./sqrt(G_vec(:,1).^2+G_vec(:,2).^2)...
         zeros(size(G_vec(:,3)))];
Omega = 180/pi*atan2(node(:,2), node(:,1));
omega = 180/pi*atan2(scalarp(vectorp(node, Ecc_vec), G_vec)./G,...
        scalarp(node, Ecc_vec));
incl = 180/pi*acos(G_vec(:,3)./G);
s = atan2(scalarp(q_vec,p_vec), (sm_ax-norma(q_vec))./sqrt(sm_ax));
f = 180/pi*2*atan(sqrt((1+Ecc)./(1-Ecc)).*tan(s/2));

if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    plot(tau, sm_ax)
    title('Semimajor axis \itvs \rmFalse time','FontSize',12)
    xlabel('\tau', 'FontSize',14), ylabel('\ita', 'FontSize',14)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure
    plot(tau, Ecc)
    title('Eccentricity \itvs \rmFalse time','FontSize',12)
    xlabel('\tau', 'FontSize',14), ylabel('\itE', 'FontSize',14)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure
    plot(tau, Omega)
    title('Longitude of the ascending node \itvs \rmFalse time','FontSize',12)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end     
    xlabel('\tau', 'FontSize',14), ylabel('\Omega   (degrees)', 'FontSize',14)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure
    plot(tau, omega)
    title('Argument of pericentre \itvs \rmFalse time','FontSize',12)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end     
    xlabel('\tau', 'FontSize',14), ylabel('\omega   (degrees)', 'FontSize',14)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure
    plot(tau, incl)
    title('Inclination \itvs \rmFalse time','FontSize',12)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end     
    xlabel('\tau', 'FontSize',14), ylabel('\itI   \rm(degrees)', 'FontSize',14)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure
    plot(tau, f)
    title('True anomaly \itvs \rmFalse time','FontSize',12)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_y
    end     
    xlabel('\tau', 'FontSize',14), ylabel('\itf   \rm(degrees)', 'FontSize',14)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'Keplerian parameters vs False time', 'NumberTitle', 'on')
subplot(2,3,1); plot(tau,sm_ax)
title('Semimajor axis','FontSize',8)
subplot(2,3,2); plot(tau,Ecc)
title('Eccentricity','FontSize',8)
subplot(2,3,3); plot(tau,Omega)
title('Longitude of ascending node (deg)','FontSize',8)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end 
subplot(2,3,4); plot(tau,omega)
title('Argument of pericentre (deg)','FontSize',8)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end 
subplot(2,3,5); plot(tau,incl)
title('Inclination (deg)','FontSize',8)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end 
subplot(2,3,6); plot(tau,f)
title('True anomaly (deg)','FontSize',8)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%