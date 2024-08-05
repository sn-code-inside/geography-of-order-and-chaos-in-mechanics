%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author 2023/03/25   B. Cordani
%%%%%% Input variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tot_time      = total integration time
% OutStep       = integration step
% Rel_Tol       = Relative tolerance
% Abs_Tol       = Absolute tolerance
% n_eq          = equation number
% y_init        = vector initial conditions
%%%%%% Output variables %%%%%%%%%%%%%%%
% tau     = time span
% X       = solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = [0 : OutStep : tot_time];
y = zeros(n_eq, tot_time/OutStep + 1);
y(:,1) = y_init;

for k = 1 : tot_time/OutStep
    exist HamiltonDir;
    if ans == 1; 
        y(:,k + 1) = eval(['ShampineGordon(@',Hamiltonian,',t(k),t(k+1), Abs_Tol, Rel_Tol, n_eq, y(:,k))']);
    else
        y(:,k + 1) = ShampineGordon(@DiffEquation,t(k),t(k+1), Abs_Tol, Rel_Tol, n_eq, y(:,k));
    end
end

tau = t;
X = y;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%