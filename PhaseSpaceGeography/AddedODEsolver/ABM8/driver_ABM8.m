%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author 2023/03/25   B. Cordani
%%%%%%% Input variables %%%%%%%%%%
% n_eq    = equation number
% y_0     = initial conditions
% h       = OutStep
% t_end   = total integration time
%%%%%%%% Output variables %%%%%%%%
% tau     = time span
% X       = solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t_0 = 0;
Steps = t_end/h;
X = zeros(Steps + 1, n_eq + 1);

f_hist = zeros(8,n_eq + 1);
f_hist(1,1) = t_0;
f_hist(1,2:n_eq + 1) = y_0;
for i=2:8
    exist DiffEquation;
    if ans == 1;
        y_0 = eval(['RK4(@',DiffEquation,',t_0,y_0,h)']);
    elseif ans == 2;
        y_0 = RK4(@DiffEquation,t_0,y_0,h);
    end
    t_0 = t_0+h;
    f_hist(i,1) = t_0;
    f_hist(i, 2 : n_eq + 1) = y_0;
end

X(1:8,:) = f_hist;

for j=8:Steps
    if ans == 1;
        y = eval(['ABM8(@',DiffEquation,',f_hist,h,n_eq)']);
    elseif ans == 2;
        y = ABM8(@DiffEquation,f_hist,h,n_eq);
    end        
    t_0 = t_0+h;
    f_hist(1:7,:) = f_hist(2:8,:);
    f_hist(8,1) = t_0;
    f_hist(8,2:n_eq + 1) = y;
    X(j+1,1) = t_0;
    X(j+1,2:n_eq + 1) = y;
end

tau = X(:,1);
for i = 1:n_eq
    X(:,i) = X(:,i+1);
end    
X = X';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%