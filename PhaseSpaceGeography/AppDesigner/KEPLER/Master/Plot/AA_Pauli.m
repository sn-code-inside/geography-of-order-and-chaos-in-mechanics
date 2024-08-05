%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
qp2uv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = sqrt(sm_ax);
l_Pauli = atan2(2*u(:,3).*v(:,3)+2*u(:,4).*v(:,4), v(:,3).^2+v(:,4).^2-u(:,3).^2-u(:,4).^2);
phiS = atan2(S_vec(:,2), S_vec(:,1));
phiD = atan2(D_vec(:,2), D_vec(:,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    polar(l_Pauli, L,'.')
    title({'\itL'; '\itvs'; '\rmPauli Mean anomaly'})

    figure
    polar(phiS, S_vec(:,3),'.')
    title({'\itS_3 vs \phi_S'})

    figure
    polar(phiD, D_vec(:,3),'.')
    title({'\itD_3 vs \phi_D'})
end

figure('Name', 'Pauli (true) Action-Angle', 'NumberTitle', 'on')
subplot(2,2,1); polar(l_Pauli, L,'.')
title({'\itL'; '\itvs'; '\rmPauli Mean anomaly'})
subplot(2,2,2); polar(phiS, S_vec(:,3),'.')
title({'\itS_3 vs \phi_S'})
subplot(2,2,3); polar(phiD, D_vec(:,3),'.')
title({'\itD_3 vs \phi_D'})
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R1 = S_vec(:,1) - D_vec(:,1);
R2 = S_vec(:,2) - D_vec(:,2);
R3 = S_vec(:,3) - D_vec(:,3);
G1 = S_vec(:,1) + D_vec(:,1);
G2 = S_vec(:,2) + D_vec(:,2);
G3 = S_vec(:,3) + D_vec(:,3);
phiR = atan2(2*(G1.*R2-R1.*G2), (G1.^2+G2.^2-R1.^2-R2.^2));
phiG = atan2(2*(G1.*G2-R1.*R2), (G1.^2-G2.^2-R1.^2+R2.^2));

if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    polar(l_Pauli, L,'.')
    title({'\itL'; '\itvs'; '\rmPauli Mean anomaly'})
    
    figure
    polar(phiR, R3,'.')
    title({'\itR_3 vs \phi_R'})

    figure
    polar(phiG, G3,'.')
    title({'\itG_3 vs \phi_G'})
end

figure('Name', 'Pauli (true) Action-Angle', 'NumberTitle', 'on')
subplot(2,2,1); polar(l_Pauli, L,'.')
title({'\itL'; '\itvs'; '\rmPauli Mean anomaly'})
subplot(2,2,2); polar(phiR, R3,'.')
title({'\itR_3 vs \phi_R'})
subplot(2,2,3); polar(phiG, G3,'.')
title({'\itG_3 vs \phi_G'})
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%}
figure('Name', 'Pauli (true) Action-Angle vs False time', 'NumberTitle', 'on')
subplot(2,3,1); plot(tau, L)
title('\itL','FontSize',8)
subplot(2,3,2); plot(tau, S_vec(:,3))
title('\itS_3','FontSize',8)
subplot(2,3,3); plot(tau, D_vec(:,3))
title('\itD_3','FontSize',8)
subplot(2,3,4); plot(tau, 180/pi*l_Pauli)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end
title('Pauli Mean anomaly','FontSize',8)
subplot(2,3,5); plot(tau, 180/pi*phiS)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end
title('\it\phi_S','FontSize',8)
subplot(2,3,6); plot(tau, 180/pi*phiD)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end
title('\it\phi_D','FontSize',8)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
figure
if strcmp(get(app.LargeMS, 'Checked'),'on')
    MarkSize = 6;
else
    MarkSize = 4;
end
plot3(R3.*cos(l_Pauli), R3.*sin(l_Pauli), 180/pi*l_Pauli,'.','MarkerSize',MarkSize)
title('Torus \itR_3- \phi_R','FontSize',12)
xlabel('Polar \itR_3- \phi_R', 'FontSize',10)
ylabel('Polar \itR_3- \phi_R', 'FontSize',10)
zlabel('Mean anomaly (degrees)', 'FontSize',10)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_z
end
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%