if isdeployed
    fid = fopen( './Python/parameters.txt', 'wt');
    fprintf(fid, ['[1',', ', num2str(epsilon1),', ', num2str(epsilon2),', ', ...
                       num2str(epsilon3),', ', num2str(epsilon4),', ', num2str(epsilon5),', ', ...
                       num2str(deg1),', ', num2str(deg2),', ', num2str(deg3),', ', ...
                       num2str(deg4),', ', num2str(deg5),', ', ...
                       '"', Hp1,'"',', ', '"', Hp2,'"',', ', '"', Hp3,'"',', ', ...
                       '"', Hp4,'"',', ', '"', Hp5,'"',']']);                               
    fclose(fid);
    !python ./Python/SymbolicStandard.py
%    eval(['!/home/bruno/anaconda3/bin/python ',app.PythonDir,'/SymbolicStandard.py'])
%     eval(['!',app.pythonDir,'/python ',app.PythonDir,'/SymbolicStandard.py'])
else
    clear maplemex
    syms tau q q1 q2 q3 p1 p2 p3 real
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Symbolic manipulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Hper = Hp([q1 q2 q3], [p1 p2 p3], epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5);
    dHp_q1 = diff(Hper,q1);
    dHp_q2 = diff(Hper,q2);
    dHp_q3 = diff(Hper,q3);
    dHp_p1 = diff(Hper,p1);
    dHp_p2 = diff(Hper,p2);
    dHp_p3 = diff(Hper,p3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Write to file and integrate the differential equations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fid = fopen( 'StandardMethod/StandDiffEq.m', 'wt');
    fprintf(fid, 'function dotW = StandDiffEq(tau,W)\n');
    if strcmp(get(app.Waitbars, 'Checked'),'on')
        fprintf(fid, 'global pick tau_total\n');              %%%%%%%%      waitbar
        fprintf(fid, 'if tau > pick + tau_total/100;\n');     %%%%%%%%      waitbar
        fprintf(fid, '    waitbar(tau/tau_total);\n');        %%%%%%%%      waitbar
        fprintf(fid, '    pick = tau;\n');                    %%%%%%%%      waitbar
        fprintf(fid, 'end\n');                                %%%%%%%%      waitbar
    end
    fprintf(fid, 'dotW = zeros(8,1);\n');
    fprintf(fid, '%%\n%% SUBSTITUTIONS\n%%\n');
    fprintf(fid, ' q1 = W(1);\n q2 = W(2);\n q3 = W(3);\n p1 = W(4);\n p2 = W(5);\n p3 = W(6);\n');
    fprintf(fid, ' q = sqrt(q1^2+q2^2+q3^2);\n');
    fprintf(fid, '%%\n%% EQUATIONS\n%%\n');
    fprintf(fid, ' dotW(1) = %s;\n dotW(2) = %s;\n dotW(3) = %s;\n dotW(4) = %s;\n dotW(5) = %s;\n dotW(6) = %s;\n dotW(7) = 0;\n dotW(8) = 0;\n',...
        char(p1+dHp_p1), char(p2+dHp_p2), char(p3+dHp_p3), char(-q1/q^3-dHp_q1), char(-q2/q^3-dHp_q2), char(-q3/q^3-dHp_q3));
    fclose(fid);
end
%%%%%%%%%%%%%%%%%%%%%%%% Runge-Kutta %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (strcmp(ODE, 'RungeKutta4') == 1) | (strcmp(ODE, 'RungeKutta5') == 1)
    if strcmp(get(app.warningbox, 'Checked'),'on')
        warndlg(sprintf(['You have selected a fixed-step integrator.\n',...
            'Please, keep in mind that its use is not advisable in the Standard\n',...
            ' Integration method, which in general requires an adaptative step.\n',...
            'Be sure that the problem is very regular and the eccentricity small..']),...
            'Fixed-step integrator');
    end

    OutStep = str2num(get(app.step_ODE,'Value'));
    if strcmp(get(app.Waitbars, 'Checked'),'on')
        if isdeployed
            % Do nothing
        else
            global pick                                                 %%%%%     waitbar
            h = waitbar(0,'Please wait..., KEPLER is calculating.');    %%%%%     waitbar
            pick = -tau_total/100;                                      %%%%%     waitbar
        end
    end
    tic             
    Output_Step = [':',num2str(2*pi*OutStep),':'];

    if isdeployed
        fig = app.KEPLERUIFigure;
        d = uiprogressdlg(fig,'Title','Please wait, KEPLER is computing ...',...
            'Indeterminate','on');
        drawnow
        testoF = fileread('Python/F_str.txt');
        W = eval([ODE,'(@(tau, W) ', testoF, ', [0 ',Output_Step,' 2*pi*tau_total],[q_vec_o''; p_vec_o''])']);
        close(d)
    else
        W = eval([ODE, '(@StandDiffEq, [0 ',Output_Step,' 2*pi*tau_total],[q_vec_o''; p_vec_o''; 0; 0])']);
    end

    t_elaps = toc;
    t_elaps = num2str(t_elaps);    
    if strcmp(get(app.Waitbars, 'Checked'),'on') & ~isdeployed
        close(h)                                                 %%%%%     waitbar
    end

    if strcmp(get(app.perform, 'Checked'),'on')
        if strcmp(num2str(perfid), '')
            perfid = fopen( 'Perform/Perform.txt', 'wt');
            fprintf(perfid, '*************************************************************************************************\n');
        end
        fprintf(perfid, '                             Standard method          \n\n');
        fprintf(perfid, ['ODE solver: ',ODE,', Cycle number: ',num2str(tau_total),...
            ', Step size ',num2str(OutStep),...
            ', Integration time: ',t_elaps,' sec.\n']);
        fprintf(perfid, '*************************************************************************************************\n');
    end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate Trajectories
    step_total = size(W,1);
    step_i = floor(tau_i/tau_total*step_total)+1;
    step_f = floor(tau_f/tau_total*step_total);
    t_c = 2*pi*(0 : OutStep : tau_total)';
    t = t_c(step_i:step_f);
    q_vec = W(step_i:step_f,1:3);
    p_vec = W(step_i:step_f,4:6);  
%%%%%%%%%%%%%%%%%%%%%%%%% Other ODE solvers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    Rel_Tol = get(app.RelTol,'Value');
    Abs_Tol = get(app.AbsTol,'Value');
    OutStep = str2num(get(app.step_ODE,'Value'));

    if isempty(OutStep)
        Output_Step = '';
    else
        Output_Step = [':',num2str(2*pi*OutStep),':'];
    end

    if strcmp(get(app.Waitbars, 'Checked'),'on')
        if isdeployed
            % Do nothing
        else
            global pick                                                   %%%%%     waitbar
            hh = waitbar(0,'Please wait..., KEPLER is calculating.');     %%%%%     waitbar
            pick = -tau_total/100;                                        %%%%%     waitbar
        end
    end

    if strcmp(ODE,'BulirschStoer')
        options = Rel_Tol;
    else
        options = odeset('RelTol',[Rel_Tol], 'AbsTol',[Abs_Tol]);
    end

    tic
    if isdeployed
        fig = app.KEPLERUIFigure;
        d = uiprogressdlg(fig,'Title','Please wait, KEPLER is computing ...',...
            'Indeterminate','on');
        drawnow               
        testoF = fileread('Python/F_str.txt');
        [t_c,W] = eval([ODE,'(@(tau, W) ', testoF, ', [0 ',Output_Step,' 2*pi*tau_total],[q_vec_o''; p_vec_o''], options)']);
        close(d)
    else            
        [t_c,W] = eval([ODE, '(@StandDiffEq, [0 ',Output_Step,' 2*pi*tau_total],[q_vec_o''; p_vec_o''; 0; 0], options)']);
    end           
    t_elaps = toc;
    t_elaps = num2str(t_elaps); 
    if strcmp(get(app.Waitbars, 'Checked'),'on')  & ~isdeployed
        close(hh)                                                 %%%%%     waitbar
    end

    if strcmp(get(app.perform, 'Checked'),'on')
        if strcmp(num2str(perfid), '')
            perfid = fopen( 'Perform/Perform.txt', 'wt');
            fprintf(perfid, '*************************************************************************************************\n');
        end
        fprintf(perfid, '                               Standard method          \n\n');
        fprintf(perfid, ['ODE solver ',ODE,', Cycle number ',num2str(tau_total),...
            ', Relative tolerance ',num2str(Rel_Tol),...
            ', Integration time ',t_elaps,' sec.\n']);
        fprintf(perfid, '*************************************************************************************************\n');
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate Trajectories
    step_total = size(W,1);
    step_i = floor(tau_i/tau_total*step_total)+1;
    step_f = floor(tau_f/tau_total*step_total);
    t = 1/(2*pi)*t_c(step_i:step_f);
    q_vec = W(step_i:step_f,1:3);
    p_vec = W(step_i:step_f,4:6);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
