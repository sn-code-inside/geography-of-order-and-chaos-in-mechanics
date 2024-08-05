m0 = get(app.edit_m0,'Value');
m1 = get(app.edit_m1,'Value');
m2 = get(app.edit_m2,'Value');
a1 = get(app.edit_a1,'Value');
a2 = get(app.edit_a2,'Value');
E1 = get(app.edit_E1,'Value');
E2 = get(app.edit_E2,'Value');

if a1*(1 + E1) >= a2*(1 - E2)
    opts = struct('WindowStyle','nonmodal','Interpreter','tex');
    warndlg('\fontsize{10}The orbits of m'' and m'''' may intersect each other. The results are not reliable','Warning', opts);
end

sigma0 = m0/(m0 + m1);  sigma1 = m1/(m0 + m1);
M1 = m0 + m1; M2 = m0 + m1 + m2;
mu1 = m0*m1/(m0 + m1); mu2 = M1*m2/(M1 + m2);
k1 = mu1*M1; k2 = mu2*M2;
%GN = 4*pi^2;
%k1 = GN*mu1*M1; k2 = GN*mu2*M2;
L1 = sqrt(mu1*a1*k1);
L2 = sqrt(mu2*a2*k2);
G1 = L1*sqrt(1 - E1^2);
G2 = L2*sqrt(1 - E2^2);
Gtot =  G1 + G2;
Gtotal = Gtot/(L1 + L2);
set(app.edit_Gtot,'Text',num2str(Gtotal,'%1.15g'));
if (Gtotal == 1)
    opts = struct('WindowStyle','nonmodal','Interpreter','tex');
    warndlg('\fontsize{10}All the three orbits are circular. The reduced manifold shrinks to a point','Warning', opts);    
end

if L1 < L2
    ximin = Gtot - 2*L1;
    if Gtot > L2 - L1
        ximax = -Gtot + 2*L2;
    else
        ximax = Gtot + 2*L1;
    end    
else
    if Gtot > L1 - L2
        ximin = Gtot - 2*L1;
    else
        ximin = -Gtot - 2*L2;
    end
    ximax = -Gtot + 2*L2;
end

xi1 = G2 - G1;