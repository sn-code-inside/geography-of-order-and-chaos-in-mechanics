% Calculate tau0 for csi
if csi0 > max(double(sol(tau,k))) & csi0 - max(double(sol(tau,k))) < 1e-3
    csi0 = max(double(sol(tau,k)));
elseif csi0 < min(double(sol(tau,k))) & min(double(sol(tau,k))) - csi0 < 1e-3
    csi0 = min(double(sol(tau,k)));        
end
if Vx0 == 0 & Vy0 == 0
    tau0 = double(vpasolve(csi0 == sol(z,k), z));
else
    tau0 = double(vpasolve(csi0 == sol(z,k), z));
    % Taking into account the sign of Vcsi, choose between the two values of tau0
    u_0 = tau0;
    u_1 = coeff_tau*step + tau0;
    csi_0 = csi0; % i.e., = double(sol(u_0,k));
    csi_1 = double(sol(u_1,k));
    delta_csi = csi_1 - csi_0;
    if Vcsi ~= 0
        counter = 0;
        while sign(delta_csi) ~= sign(Vcsi);
            if counter > 5
                warndlg(['Error due to one of the following two causes: '...
                    '1) The initial speed must be numerically null '...
                    'or -- alternatively -- sufficiently larger than the step. '...
                    '2) The initial distance from the vertical axis '...
                    'should be sufficiently larger than the step.'...
                    'In both cases, decrease the step to fix the problem.'],'Warning');
                return
            end                 
            tau0 = double(vpasolve(csi0 == sol(z,k), z, 'Random', true));
            u_0 = tau0;
            u_1 = coeff_tau*step + tau0;
            csi_0 = double(sol(u_0,k));
            csi_1 = double(sol(u_1,k));
            delta_csi = csi_1 - csi_0;       
            counter = counter + 1;
        end
    end
end
u = coeff_tau*tau + tau0;
% Compute csi and if H > 0 erase the points csi < 0 (meaningless results)
if H < 0
    csi = double(sol(u,k));
else
    numpoint = floor(delta/step + 1);
    for h = 1:numpoint
        csi(h) = double(sol(u(h),k));
        if csi(h) < 0
            csi(h:numpoint) = NaN;
            return
        end
    end
end
