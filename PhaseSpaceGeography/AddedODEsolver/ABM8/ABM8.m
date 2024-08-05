%--------------------------------------------------------------------------
% 
% Adams-Bashforth-Moulton 8th order
% 
% Inputs:
%        func   : function handle
%        n_eq   : equation number
%        f_hist : a matrix which includes 8 rows and n_eq+1 columns
%        including, in order, time and (n_eq)-dimensional state vector                
%        h      : step size of integration
% 
% Output:
%        Y      : state vector at t_0+h
% 
% Modified:   2018/01/27   M. Mahooti (author)
% Modified:   2023/03/25   B. Cordani
%--------------------------------------------------------------------------
function [tau_c,W] =  ABM8(func,time_span,y_init,options)
                n_eq = 8;
                y_0 = y_init;
                lgt = length(time_span);
                Steps = lgt-1;
                t_0 = time_span(1);
                t_end = time_span(lgt);
                h = (t_end-t_0)/(lgt-1);
                X = zeros(Steps + 1, n_eq + 1);

                f_hist = zeros(8,n_eq + 1);
                f_hist(1,1) = t_0;
                f_hist(1,2:n_eq + 1) = y_0;
                for i=2:8
                    y_0 = RK4(@DiffEquation,t_0,y_0,h);
                    t_0 = t_0+h;
                    f_hist(i,1) = t_0;
                    f_hist(i, 2 : n_eq + 1) = y_0;
                end

                X(1:8,:) = f_hist;

                for j=8:Steps
                    y = ABM8step(@DiffEquation,f_hist,h,n_eq);
                    t_0 = t_0+h;
                    f_hist(1:7,:) = f_hist(2:8,:);
                    f_hist(8,1) = t_0;
                    f_hist(8,2:n_eq + 1) = y;
                    X(j+1,1) = t_0;
                    X(j+1,2:n_eq + 1) = y;
                end

                tau_c = X(:,1);
                for i = 1:n_eq
                    X(:,i) = X(:,i+1);
                end
                X = X';
                W = X(1:8,:);
                W = W';

function Y = ABM8step(func, f_hist, h, n_eq)

bash = [434241.0, -1152169.0, 2183877.0, -2664477.0, 2102243.0, -1041723.0, 295767.0, -36799.0];
moul = [36799.0, 139849.0, -121797.0, 123133.0, -88547.0, 41499.0, -11351.0, 1375.0];
divisor = 1.0/120960.0;

% Calculate the predictor using the Adams-Bashforth formula 
Y = f_hist(8,2:n_eq+1)' + h*divisor* ...
    ( bash(1)*func(f_hist(8,1),f_hist(8,2:n_eq+1)') + bash(2)*func(f_hist(7,1),f_hist(7,2:n_eq+1)') + ...
      bash(3)*func(f_hist(6,1),f_hist(6,2:n_eq+1)') + bash(4)*func(f_hist(5,1),f_hist(5,2:n_eq+1)') + ...
      bash(5)*func(f_hist(4,1),f_hist(4,2:n_eq+1)') + bash(6)*func(f_hist(3,1),f_hist(3,2:n_eq+1)') + ...
      bash(7)*func(f_hist(2,1),f_hist(2,2:n_eq+1)') + bash(8)*func(f_hist(1,1),f_hist(1,2:n_eq+1)') );

% Calculate the corrector using the Adams-Moulton formula
Y = f_hist(8,2:n_eq+1)' + h*divisor* ...
    ( moul(1)*func(f_hist(8,1)+h,Y) + moul(2)*func(f_hist(8,1),f_hist(8,2:n_eq+1)') + ...
      moul(3)*func(f_hist(7,1),f_hist(7,2:n_eq+1)') + moul(4)*func(f_hist(6,1),f_hist(6,2:n_eq+1)') + ...
      moul(5)*func(f_hist(5,1),f_hist(5,2:n_eq+1)') + moul(6)*func(f_hist(4,1),f_hist(4,2:n_eq+1)') + ...
      moul(7)*func(f_hist(3,1),f_hist(3,2:n_eq+1)') + moul(8)*func(f_hist(2,1),f_hist(2,2:n_eq+1)') );

