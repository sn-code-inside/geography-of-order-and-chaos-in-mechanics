function [q, p] = SD2Cartesian(S, D, f_o)
G_vec_o = S + D;
R_vec_o = S - D;
sm_ax_o = G_vec_o*G_vec_o' + R_vec_o*R_vec_o';
if sm_ax_o <= 0
    warndlg('The semimajor axis must be positive')
    return
end
Ecc_vec_o = R_vec_o/sqrt(sm_ax_o);
Ecc_o = norma(Ecc_vec_o);
G_o = sqrt(G_vec_o(2)^2 + G_vec_o(3)^2);
if Ecc_o == 0
    Ecc_vers_o = [0  -G_vec_o(3)/G_o  G_vec_o(2)/G_o ];
else
    Ecc_vers_o = Ecc_vec_o/Ecc_o;
end
s_o = 2*atan(sqrt((1-Ecc_o)/(1+Ecc_o))*tan(f_o/2*pi/180));
q = sm_ax_o*cos(s_o)*Ecc_vers_o+sqrt(sm_ax_o)*sin(s_o)*...
    vectorp(G_vec_o,Ecc_vers_o)-sm_ax_o*Ecc_vec_o;
p = 1/(sm_ax_o*(1-Ecc_o*cos(s_o)))*(-sqrt(sm_ax_o)*sin(s_o)*...
    Ecc_vers_o + cos(s_o)*vectorp(G_vec_o,Ecc_vers_o));
%{
if Ecc_o == 0
    Ecc_vers_o = [1 0 0];
else
    Ecc_vers_o = Ecc_vec_o/Ecc_o;
end

G_o = norma(G_vec_o);

if (G_vec_o(1)^2+G_vec_o(2)^2) == 0
    node_o = [1 0 0];
else
    node_o = [-G_vec_o(2)/sqrt(G_vec_o(1)^2+G_vec_o(2)^2)...
         G_vec_o(1)/sqrt(G_vec_o(1)^2+G_vec_o(2)^2) 0];
end

Omega_o = 180/pi*atan2(node_o(2), node_o(1));
omega_o = 180/pi*atan2(scalarp(vectorp(node_o, Ecc_vec_o), G_vec_o)/G_o,...
        scalarp(node_o, Ecc_vec_o));
incl_o = 180/pi*acos(G_vec_o(3)/G_o);
f_o = 0;
s_o = 180/pi*2*atan(sqrt((1-Ecc_o)/(1+Ecc_o))*tan(f_o/2*pi/180));
q_vec_o = sm_ax_o*cos(pi/180*s_o)*Ecc_vers_o+sqrt(sm_ax_o)*sin(pi/180*s_o)*...
    vectorp(G_vec_o,Ecc_vers_o)-sm_ax_o*Ecc_vec_o; 
p_vec_o = 1/(sm_ax_o*(1-Ecc_o*cos(pi/180*s_o)))*(-sqrt(sm_ax_o)*sin(pi/180*s_o)*...
    Ecc_vers_o + cos(pi/180*s_o)*vectorp(G_vec_o,Ecc_vers_o));
%}