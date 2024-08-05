% Calculate tau0 for eta
if eta0 > max(double(sol(tau,k))) & eta0 - max(double(sol(tau,k))) < 1e-3
    eta0 = max(double(sol(tau,k)));
elseif eta0 < min(double(sol(tau,k))) & min(double(sol(tau,k))) - eta0 < 1e-3
    eta0 = min(double(sol(tau,k)));        
end
if Vx0 == 0 & Vy0 == 0
    tau0 = double(vpasolve(eta0 == sol(z,k), z));
else
    tau0 = double(vpasolve(eta0 == sol(z,k), z));
    % Taking into account the sign of Veta, choose between the two values of tau0
    u_0 = tau0;
    u_1 = coeff_tau*step + tau0;
    eta_0 = eta0; % i.e., = double(sol(u_0,k));
    eta_1 = double(sol(u_1,k));
    delta_eta = eta_1 - eta_0;
    if Veta ~= 0
        counter = 0;
        while sign(delta_eta) ~= sign(Veta);
            if counter > 5
                warndlg(['Error due to one of the following two causes: '...
                    '1) The initial speed must be numerically null '...
                    'or -- alternatively -- sufficiently larger than the step. '...
                    '2) The initial distance from the vertical axis '...
                    'should be sufficiently larger than the step.'...
                    'In both cases, decrease the step to fix the problem.'],'Warning');
                return
            end
            tau0 = double(vpasolve(eta0 == sol(z,k), z, 'Random', true));
            u_0 = tau0;
            u_1 = coeff_tau*step + tau0;
            eta_0 = double(sol(u_0,k));
            eta_1 = double(sol(u_1,k));
            delta_eta = eta_1 - eta_0;
            counter = counter + 1;
        end
    end
end
u = coeff_tau*tau + tau0;
% Compute eta
eta = double(sol(u,k));
