%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = sqrt(sm_ax);
l_Pauliprime = atan2(2*uR(:,3).*vR(:,3)+2*uR(:,4).*vR(:,4), vR(:,3).^2+vR(:,4).^2-uR(:,3).^2-uR(:,4).^2);
phiSprime = atan2(Sprime_vec(:,2), Sprime_vec(:,1));
phiDprime = atan2(Dprime_vec(:,2), Dprime_vec(:,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    polar(l_Pauliprime, L,'.')
    title({'\itL vs'; '\rm Rotated Pauli Mean anomaly'})

    figure
    polar(phiSprime, 2*Sprime_vec(:,3)./L,'.')
    title({'Rotated \it2S_3/L vs \phi_S'})

    figure
    polar(phiDprime, 2*Dprime_vec(:,3)./L,'.')
    title({'Rotated \it2D_3/L vs \phi_D'})
end

figure('Name', 'Rotated-normalized S-D Action-Angle', 'NumberTitle', 'on')
subplot(2,2,1); polar(l_Pauliprime, L,'.')
title({'\itL vs'; '\rm Rotated Pauli Mean anomaly'})
subplot(2,2,2); polar(phiSprime, 2*Sprime_vec(:,3)./L,'.')
title({'Rotated \it2S_3/L vs \phi_S'})
subplot(2,2,3); polar(phiDprime, 2*Dprime_vec(:,3)./L,'.')
title({'Rotated \it2D_3/L vs \phi_D'})
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
R1 = Sprime_vec(:,1) - Dprime_vec(:,1);
R2 = Sprime_vec(:,2) - Dprime_vec(:,2);
R3 = Sprime_vec(:,3) - Dprime_vec(:,3);
G1 = Sprime_vec(:,1) + Dprime_vec(:,1);
G2 = Sprime_vec(:,2) + Dprime_vec(:,2);
G3 = Sprime_vec(:,3) + Dprime_vec(:,3);
phiR = atan2(2*(G1.*R2-R1.*G2), (G1.^2+G2.^2-R1.^2-R2.^2));
phiG = atan2(2*(G1.*G2-R1.*R2), (G1.^2-G2.^2-R1.^2+R2.^2));

if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    polar(l_Pauliprime, L,'.')
    title({'\itL'; '\itvs'; '\rm Rotated Pauli Mean anomaly'})
    
    figure
    polar(phiR, R3./L,'.')
    title({'Rotated-normalized \itR_3 vs \phi_R'})

    figure
    polar(phiG, G3./L,'.')
    title({'Rotated-normalized \itG_3 vs \phi_G'})
end

figure('Name', 'Rotated-normalized Pauli Action-Angle', 'NumberTitle', 'on')
subplot(2,2,1); polar(l_Pauliprime, L,'.')
title({'\itL'; '\itvs'; '\rm Rotated Pauli Mean anomaly'})
subplot(2,2,2); polar(phiR, R3./L,'.')
title({'Rotated-normalized \itR_3 vs \phi_R'})
subplot(2,2,3); polar(phiG, G3./L,'.')
title({'Rotated-normalized \itG_3 vs \phi_G'})
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'Rotated-normalized Pauli Action-Angle vs False time', 'NumberTitle', 'on')
subplot(2,3,1); plot(tau, L)
title('\itL','FontSize',8)
subplot(2,3,2); plot(tau, 2*Sprime_vec(:,3)./L)
title('Rotated \it2S_3/L','FontSize',8)
subplot(2,3,3); plot(tau, 2*Dprime_vec(:,3)./L)
title('Rotated \it2D_3/L','FontSize',8)
subplot(2,3,4); plot(tau, 180/pi*l_Pauliprime)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end
title('Rotated Pauli Mean anomaly','FontSize',8)
subplot(2,3,5); plot(tau, 180/pi*phiSprime)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end
title('Rotated \it\phi_S','FontSize',8)
subplot(2,3,6); plot(tau, 180/pi*phiDprime)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end
title('Rotated \it\phi_D','FontSize',8)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%