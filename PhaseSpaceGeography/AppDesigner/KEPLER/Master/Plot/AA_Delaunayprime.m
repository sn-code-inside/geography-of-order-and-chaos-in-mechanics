%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = sqrt(sm_ax);
lprime = atan2(-uR(:,4), -vR(:,4));
Gprime_vec = Sprime_vec + Dprime_vec;
Rprime_vec = Sprime_vec - Dprime_vec;
Gprime = norma(Gprime_vec);
G3prime = Gprime_vec(:,3);
Eccprime_vec = Rprime_vec./[L L L];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G_prj = sqrt(Gprime_vec(:,1).^2+Gprime_vec(:,2).^2);
sz = size(G_prj);
if all(G_prj)
    node = [-Gprime_vec(:,2)./G_prj  Gprime_vec(:,1)./G_prj  zeros(sz)];           
else
    if any(G_prj)
        node = zeros(sz(1),3);
        node(1,:) = [1  0  0];
        for jsz = 1 : sz(1)
            if G_prj(jsz) == 0
                if jsz == 1
                else
                    node(jsz,:) = node(jsz-1,:);
                end
            else
                node(jsz,:) = [-Gprime_vec(jsz,2)/G_prj(jsz)  Gprime_vec(jsz,1)/G_prj(jsz)  0 ];
            end
        end
    else
        node = [ones(sz)  zeros(sz)  zeros(sz)];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Omegaprime = atan2(node(:,2), node(:,1));
omegaprime = atan2(scalarp(vectorp(node, Eccprime_vec), Gprime_vec)./Gprime,...
        scalarp(node, Eccprime_vec));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(get(app.SingleFigures, 'Checked'),'on')
    figure
    polar(lprime, L,'.')
    title({'\itL vs \rmRotated mean anomaly'})

    figure
    polar(omegaprime, Gprime./L,'.')
    title({'Rotated \itG/L vs \omega'})

    figure
    polar(Omegaprime, G3prime./L,'.')
    title({'Rotated \itG_3/L vs \Omega'})
end

figure('Name', 'Rotated-normalized Delaunay Action-Angle', 'NumberTitle', 'on')
subplot(2,2,1); polar(lprime, L,'.')
title({'\itL vs \rmRotated mean anomaly'})
subplot(2,2,2); polar(omegaprime, Gprime./L,'.')
title({'Rotated \itG/L vs \omega'})
subplot(2,2,3); polar(Omegaprime, G3prime./L,'.')
title({'Rotated \itG_3/L vs \Omega'})

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'Rotated-normalized Delaunay Action-Angle vs False time', 'NumberTitle', 'on')
subplot(2,3,1); plot(tau, L)
title('\itL','FontSize',8)
subplot(2,3,2); plot(tau, Gprime./L)
title('Rotated \itG/L','FontSize',8)
subplot(2,3,3); plot(tau, G3prime./L)
title('Rotated \itG_3/L','FontSize',8)
subplot(2,3,4); plot(tau, 180/pi*lprime)
title('Rotated mean anomaly','FontSize',8)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end
subplot(2,3,5); plot(tau, 180/pi*omegaprime)
title('Rotated \it\omega','FontSize',8)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end
subplot(2,3,6); plot(tau, 180/pi*Omegaprime)
title('Rotated \it\Omega','FontSize',8)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_y
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%