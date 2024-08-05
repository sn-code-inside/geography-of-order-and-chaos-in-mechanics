function [sm_ax  Ecc  Omega  omega  incl] = SD2Keplerian(S, D)
G_vec = 1/2*(S + D);
R_vec = 1/2*(S - D);
sm_ax = G_vec*G_vec' + R_vec*R_vec';
if sm_ax <= 0
    warndlg('The semimajor axis must be positive')
    return
end
Ecc_vec = R_vec/sqrt(sm_ax);
Ecc = norma(Ecc_vec);
G = norma(G_vec);
if (G_vec(1)^2 + G_vec(2)^2) == 0
    node = [1 0 0];
else
    node = [-G_vec(2)/sqrt(G_vec(1)^2 + G_vec(2)^2)...
             G_vec(1)/sqrt(G_vec(1)^2 + G_vec(2)^2)...
             0];  
end
Omega = 180/pi*atan2(node(2), node(1));
omega = 180/pi*atan2(scalarp(vectorp(node, Ecc_vec), G_vec)/G,...
                       scalarp(node, Ecc_vec));  
incl = 180/pi*acos(G_vec(3)/G);