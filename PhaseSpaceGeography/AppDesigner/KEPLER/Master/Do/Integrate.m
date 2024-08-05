%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Integrate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lambda = 1;

if (1/2*p_vec_o*p_vec_o' - 1/sqrt(q_vec_o*q_vec_o') + ...
        Hp(q_vec_o, p_vec_o, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5)) >= 0
    q_str = num2str(q_vec_o);
    p_str = num2str(p_vec_o);
    warndlg(sprintf(['With these initial conditions\n',...
        '       q =  ', q_str,'\n',...
        '       p =  ', p_str,'\n',...
        'the total energy is positive or null. ',...
        'The Regularization method is not able to handle this case. ',...
        'Try with ''Integrate'' of the Standard method to compute the orbit.']))
    return
end

lambda = 1/sqrt(-2*(1/2*p_vec_o*p_vec_o' - 1/sqrt(q_vec_o*q_vec_o')...
    + Hp(q_vec_o, p_vec_o, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5)));
%--------------------------------------------------------------------------
er1 = abs(epsilon1*lambda^(2*deg1+2));
er2 = abs(epsilon2*lambda^(2*deg2+2));
er3 = abs(epsilon3*lambda^(2*deg3+2));
er4 = abs(epsilon4*lambda^(2*deg4+2));
er5 = abs(epsilon5*lambda^(2*deg5+2));
if (er1 > 0.2 | er2 > 0.2 | er3 > 0.2 | er4 > 0.2 | er5 > 0.2) &...
        strcmp(get(app.warningbox, 'Checked'),'on') &...
        (get(app.check_pert,'Value') == true)
    if strcmp(Hp1,'Zero')
        er1 = '---';
    else
        er1 = num2str(er1);
    end
    if strcmp(Hp2,'Zero')
        er2 = '---';
    else
        er2 = num2str(er2);
    end
    if strcmp(Hp3,'Zero')
        er3 = '---';
    else
        er3 = num2str(er3);
    end
    if strcmp(Hp4,'Zero')
        er4 = '---';
    else
        er4 = num2str(er4);
    end
    if strcmp(Hp5,'Zero')
        er5 = '---';
    else
        er5 = num2str(er5);
    end
    button = questdlg(sprintf(['The absolute values of the rescaled perturbative parameters are, respectively\n',...
        '                    ',er1,'   ',er2,'   ',er3,'    ',er4,'    ',er5,'.\n',...
        'One (or more) of these values is greater than 0.2, so the hypothesis of\n',...
        'small perturbation is not satisfied and the numerical result may be not reliable.\n',...
        'Look at ''Integration Errors'' and compare with the similar outputs of the \n',...
        '''Non perturbative method'' and of the ''Standard method''.\n',...
        'Do you continue anyway?']),...
        'Too large perturbation', 'No');
    if strcmp(button,'Yes')
    else
        return
    end
end
%--------------------------------------------------------------------------
x_vec_o = 1/(lambda^2)*q_vec_o;
y_vec_o = lambda*p_vec_o;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isdeployed
    fid = fopen( './Python/parameters.txt', 'wt');
    fprintf(fid, ['[', num2str(lambda, 16),', ', num2str(epsilon1),', ', num2str(epsilon2),', ', ...
                       num2str(epsilon3),', ', num2str(epsilon4),', ', num2str(epsilon5),', ', ...
                       num2str(deg1),', ', num2str(deg2),', ', num2str(deg3),', ', ...
                       num2str(deg4),', ', num2str(deg5),', ', ...
                       '"', Hp1,'"',', ', '"', Hp2,'"',', ', '"', Hp3,'"',', ', ...
                       '"', Hp4,'"',', ', '"', Hp5,'"',']']);                               
    fclose(fid);
    
    if get(app.check_pert,'Value') == 1
        !python ./Python/Symbolic.py
%        !/home/bruno/anaconda3/bin/python /home/bruno/PhaseSpaceGeography/AppDesigner/KEPLER/Master/Python/Symbolic.py
%        eval(['!/home/bruno/anaconda3/bin/python ',app.PythonDir,'/Symbolic.py'])
%        eval(['!',app.pythonDir,'/python ',app.PythonDir,'/Symbolic.py'])
        [Uo, Vo] = xy2uv(x_vec_o, y_vec_o);
    elseif get(app.check_nonpert,'Value') == 1
        !python ./Python/SymbolicNonPert.py
%        eval(['!/home/bruno/anaconda3/bin/python ',app.PythonDir,'/SymbolicNonPert.py'])
%        eval(['!',app.pythonDir,'/python ',app.PythonDir,'/SymbolicNonPert.py'])
        [z_vec_o,  w_vec_o] = xy2zw(x_vec_o,  y_vec_o);
        Uo = z_vec_o';
        Vo = w_vec_o';
    end
else
    if get(app.check_pert,'Value') == true
        Symbolic
        Write2file
        [Uo, Vo] = xy2uv(x_vec_o, y_vec_o);
    elseif get(app.check_nonpert,'Value') == true
        SymbolicNonPert
        Write2fileNonPert
        [z_vec_o,  w_vec_o] = xy2zw(x_vec_o,  y_vec_o);
        Uo = z_vec_o';
        Vo = w_vec_o';
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
block = str2num(get(app.edit_block,'Value'));

Rel_Tol = get(app.RelTol,'Value');
Abs_Tol = get(app.AbsTol,'Value');
OutStep = str2num(get(app.step_ODE,'Value'));

if strcmp(ODE,'BulirschStoer')
    options = Rel_Tol;
else
    options = odeset('RelTol',[Rel_Tol], 'AbsTol',[Abs_Tol]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Runge-Kutta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (strcmp(ODE, 'RungeKutta4') == 1) | (strcmp(ODE, 'RungeKutta5') == 1)
    StepSize = str2num(get(app.step_ODE,'Value'));  
    if strcmp(get(app.Waitbars, 'Checked'),'on')
        if isdeployed
            % Do nothing
        else
            global pick                                                 %%%%%     waitbar
            h = waitbar(0,'Please wait..., KEPLER is calculating.');    %%%%%     waitbar
            pick = -tau_total/100;                                      %%%%%     waitbar
        end
    end
    tau_c = (0 : StepSize : tau_total)';
    tic
    if isdeployed
        fig = app.KEPLERUIFigure;
        d = uiprogressdlg(fig,'Title','Please wait, KEPLER is computing ...',...
            'Indeterminate','on');
        drawnow
        testoF = fileread('Python/F_str.txt');
        W = eval([ODE,'(@(tau, W) ', testoF, ', tau_c, [Uo; Vo])']);
        close(d)
    else
        W = eval([ODE, '(@DiffEquation, tau_c, [Uo; Vo])']);
    end
    t_elaps = toc;
    t_elaps = num2str(t_elaps);    
    if strcmp(get(app.Waitbars, 'Checked'),'on') & ~isdeployed
        close(h)                                                        %%%%%     waitbar
    end

    if strcmp(get(app.perform, 'Checked'),'on')
        if strcmp(num2str(perfid), '')
            perfid = fopen( 'Perform/Perform.txt', 'wt');
            fprintf(perfid, '*************************************************************************************************\n');
        end
        fprintf(perfid, '                             Regularization method          \n\n');
        fprintf(perfid, ['ODE solver: ',ODE,', Cycle number: ',num2str(tau_total),...
            ', Step size: ',num2str(StepSize),', Integration time: ',t_elaps,' sec.\n']);
        fprintf(perfid, '*************************************************************************************************\n');
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Other ODE solvers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    if isdeployed & (strcmp(ODE,'ABM8') | strcmp(ODE,'ShampineGordon'))
        warndlg('This ODE solver in not implemented in the compiled version of KEPLER.');
        return
    end
    
    if isempty(OutStep);
        if (strcmp(ODE,'BulirschStoer') | (strcmp(ODE,'ABM8') | strcmp(ODE,'ShampineGordon')))
            warndlg('The Output Step must be strictly positive');
            return
        end

        if (strcmp(get(app.LGG3_long_FMFT, 'Checked'),'on')) |...
                (strcmp(get(app.LSD_long_FMFT, 'Checked'),'on'))  
            warndlg(['You have checked Demodulation analysis.  ',...
                    'For a correct Frequency analysis the integration MUST be performed ',...
                    'with a constant Output Step (default value: 0.01).  Please, redo ''Integrate''.'])
            set(app.step_ODE,'Value', num2str(0.01));
            set(app.edit_block,'Visible', 'on')
            set(app.text_block,'Visible', 'on')
            return
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

        tic
        if isdeployed
            fig = app.KEPLERUIFigure;
            d = uiprogressdlg(fig,'Title','Please wait, KEPLER is computing ...',...
                'Indeterminate','on');
            drawnow               
            testoF = fileread('Python/F_str.txt');
            [tau_c,W] = eval([ODE,'(@(tau, W) ', testoF, ', [0  tau_total], [Uo; Vo], options)']);
            close(d)
        else            
            [tau_c,W] = eval([ODE, '(@DiffEquation, [0  tau_total], [Uo; Vo], options)']);
        end            
        t_elaps = toc;

        t_elaps = num2str(t_elaps);
        if strcmp(get(app.Waitbars, 'Checked'),'on') & ~isdeployed
            close(hh)                                                   %%%%%     waitbar
        end
    else
        if (strcmp(ODE,'ShampineGordon') & Abs_Tol < 1e-7)
            warndlg('The Absolute Tolerance for ShampineGordon method must be greater than or equal to 1e-7')
            return
        end

                Output_Step = [':',num2str(OutStep),':'];

                if strcmp(get(app.Waitbars, 'Checked'),'on')
                    if isdeployed
                        if strcmp(ODE,'ode78') | strcmp(ODE,'ode89')
                            global pick                                               %%%%%     waitbar
                            hh = waitbar(0,'Please wait..., KEPLER is calculating.'); %%%%%     waitbar
                            pick = -tau_total/100;                                    %%%%%     waitbar 
                        else                          
                            % Do nothing
                        end
                    else
                        global pick                                               %%%%%     waitbar
                        hh = waitbar(0,'Please wait..., KEPLER is calculating.'); %%%%%     waitbar
                        pick = -tau_total/100;                                    %%%%%     waitbar
                    end
                end

                if strcmp(get(app.SlowWaitbars, 'Checked'),'on')
                    begin = datestr(now, 'dd mmm HH:MM');
                    slow = waitbar(0,'Please wait..., KEPLER is calculating.'); %%%%%     slow waitbar
                end

                if strcmp(ODE,'BulirschStoer')
                    options = Rel_Tol;
                else
                    options = odeset('RelTol',[Rel_Tol], 'AbsTol',[Abs_Tol]);
                end

                tic

                if block
%--------------------------------------------------------------------------
                    longblock = str2double(get(app.edit_ClearMemory,'Value'));

                    if isnan(longblock)
                        set(app.edit_ClearMemory, 'Value', 20000);
                    end

                    deltaFMFT = 2^(floor(log2(str2num(get(app.ComputeLFA,'Value'))/OutStep)));
                    n_cycle = floor(tau_total/block); totslow = floor(tau_total/longblock);
                    k = 1; slowcount = 1; w = []; tau_ = [];

                    if isdeployed
                        if strcmp(ODE,'ode78') | strcmp(ODE,'ode89')
                            % Do nothing
                        else
                            fig = app.KEPLERUIFigure;
                            d = uiprogressdlg(fig,'Title','Please wait, KEPLER is computing ...',...
                                'Indeterminate','on');
                            drawnow
                        end
                    end

                    for k = 1:n_cycle
                        if length(w) >= longblock/OutStep - 1;
                            if (strcmp(get(app.LGG3_long_FMFT, 'Checked'),'on')) |...
                                    (strcmp(get(app.LSD_long_FMFT, 'Checked'),'on'))  
                                Long_Freq_Analysis                
                                clear w tau_
                                w = []; tau_ = [];
                                if strcmp(get(app.SlowWaitbars, 'Checked'),'on')
                                    update = ['Please, wait: ', num2str(floor(slowcount/totslow*100)), '% completed. Starting time: ', begin];
                                    waitbar(slowcount/totslow, slow, update);
                                end
                                slowcount = slowcount + 1;
                            end
                        end

                        if isdeployed
                            if strcmp(ODE,'ode78') | strcmp(ODE,'ode89')
                                options = odeset('RelTol',[Rel_Tol], 'AbsTol',[Abs_Tol], 'OutputFcn',@odebar);
                            end
                            testoF = fileread('Python/F_str.txt');
                            [tau_c,W] = eval([ODE,'(@(tau, W) ', testoF, ', [(k-1)*block ',Output_Step,' k*block], [Uo; Vo], options)']);
                        else                       
                            [tau_c,W] = eval([ODE, '(@DiffEquation, [(k-1)*block ',Output_Step,' k*block], [Uo; Vo], options)']);
                        end

                        w = [w; W(1:length(W)-1, :)];
                        tau_ = [tau_; tau_c(1:length(W)-1)];
                        W_o = W(length(W), :);
                        Uo = W_o(1:4)';
                        Vo = W_o(5:8)';

                        if get(app.check_pert,'Value') == true
                            [xo yo] = uv2xy(Uo, Vo);
                            [Uo Vo] = xy2uv(xo, yo);
                            [xo yo] = uv2xy(Uo, Vo);
                        elseif get(app.check_nonpert,'Value') == true
                            [xo yo] = zw2xy(Uo, Vo);
                            [Uo Vo] = xy2zw(xo, yo);
                            [xo yo] = zw2xy(Uo, Vo);
                        end
%---------------------- SOSTITUZIONE ---------------------------------------------------------
                        f = @(z)1/2*sqrt(z^2*xo*xo')*(yo*yo'+1) + sqrt(z^2*xo*xo')*...
                        Kp(z*xo,yo, lambda, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5,...
                            deg1, deg2, deg3, deg4, deg5, Hp1, Hp2, Hp3, Hp4, Hp5) - 1;
                        a = fzero(f,1);
                        xo =a*xo;
%---------------------------------------------------------------------------------------------
                        if get(app.check_pert,'Value') == true
                            [Uo Vo] = xy2uv(xo, yo);
                        elseif get(app.check_nonpert,'Value') == true
                            [Uo Vo] = xy2zw(xo, yo);
                            Uo = Uo'; Vo = Vo';
                        end

                    end
                    if (n_cycle*block ~= tau_total)
                        if isdeployed
                            if strcmp(ODE,'ode78') | strcmp(ODE,'ode89')
                                options = odeset('RelTol',[Rel_Tol], 'AbsTol',[Abs_Tol], 'OutputFcn',@odebar);
                            end
                            testoF = fileread('Python/F_str.txt');
                            [tau_c,W] = eval([ODE,'(@(tau, W) ', testoF, ', [n_cycle*block ',Output_Step,' tau_total], [Uo; Vo], options)']);
                            if ~strcmp(ODE,'ode78') & ~strcmp(ODE,'ode89')
                                close(d)
                            end
                        else
                            [tau_c,W] = eval([ODE, '(@DiffEquation, [n_cycle*block ',Output_Step,' tau_total], [Uo; Vo], options)']);
                        end
                        W = [w; W];
                        tau_c = [tau_; tau_c];
                    else
                        W = w;
                        tau_c = tau_;
                    end
%--------------------------------------------------------------------------
                else
                    longblock = str2num(get(app.edit_ClearMemory,'Value'));
                    deltaFMFT = 2^(floor(log2(str2num(get(app.ComputeLFA,'Value'))/OutStep)));
                    n_cycle = floor(tau_total/longblock); totslow = floor(tau_total/longblock);
                    k = 1; slowcount = 1; w = []; tau_ = [];
                    for k = 1:n_cycle
                        if length(w) >= longblock/OutStep - 1;
                            if (strcmp(get(app.LGG3_long_FMFT, 'Checked'),'on')) |...
                                    (strcmp(get(app.LSD_long_FMFT, 'Checked'),'on'))  
                                Long_Freq_Analysis                
                                clear w tau_
                                w = []; tau_ = [];
                                if strcmp(get(app.SlowWaitbars, 'Checked'),'on')
                                    update = ['Please, wait: ', num2str(floor(slowcount/totslow*100)), '% completed. Starting time: ', begin];
                                    waitbar(slowcount/totslow, slow, update);
                                end
                                slowcount = slowcount + 1;
                            end
                        end
                        if isdeployed
                            if strcmp(ODE,'ode78') | strcmp(ODE,'ode89')
                                options = odeset('RelTol',[Rel_Tol], 'AbsTol',[Abs_Tol], 'OutputFcn',@odebar);
                            else
                                fig = app.KEPLERUIFigure; 
                                d = uiprogressdlg(fig,'Title','Please wait, KEPLER is computing ...',...
                                    'Indeterminate','on');
                                drawnow
                            end
                            testoF = fileread('Python/F_str.txt');
                            [tau_c,W] = eval([ODE,'(@(tau, W) ', testoF, ', [(k-1)*longblock ',Output_Step,' k*longblock], [Uo; Vo], options)']);
                            if ~strcmp(ODE,'ode78') & ~strcmp(ODE,'ode89')
                                close(d)
                            end
                        else                        
                            [tau_c,W] = eval([ODE, '(@DiffEquation, [(k-1)*longblock ',Output_Step,' k*longblock], [Uo; Vo], options)']);
                        end
                        w = [w; W(1:length(W)-1, :)];
                        tau_ = [tau_; tau_c(1:length(W)-1)];
                        W_o = W(length(W), :);
                        Uo = W_o(1:4)';
                        Vo = W_o(5:8)';
                    end
                    if (n_cycle*longblock ~= tau_total)
                        if isdeployed
                            if strcmp(ODE,'ode78') | strcmp(ODE,'ode89')
                                options = odeset('RelTol',[Rel_Tol], 'AbsTol',[Abs_Tol], 'OutputFcn',@odebar);
                            else
                                fig = app.KEPLERUIFigure; 
                                d = uiprogressdlg(fig,'Title','Please wait, KEPLER is computing ...',...
                                    'Indeterminate','on');
                                drawnow
                            end
                            testoF = fileread('Python/F_str.txt');
                            [tau_c,W] = eval([ODE,'(@(tau, W) ', testoF, ', [n_cycle*longblock ',Output_Step,' tau_total], [Uo; Vo], options)']);
                            if ~strcmp(ODE,'ode78') & ~strcmp(ODE,'ode89')
                                close(d)
                            end
                        else                        
                            [tau_c,W] = eval([ODE, '(@DiffEquation, [n_cycle*longblock ',Output_Step,' tau_total], [Uo; Vo], options)']);
                        end
                        W = [w; W];
                        tau_c = [tau_; tau_c];
                    else
                        W = w;
                        tau_c = tau_;
                    end
                end

                t_elaps = toc;
                t_elaps = num2str(t_elaps);
                if strcmp(get(app.Waitbars, 'Checked'),'on') & ~isdeployed
                    close(hh)                                                %%%%%     waitbar
                end
    end
            if strcmp(get(app.SlowWaitbars, 'Checked'),'on')
                waitbar(1, slow, 'Finish!!!')
            end

            if strcmp(get(app.perform, 'Checked'),'on')
                if strcmp(num2str(perfid), '')
                    perfid = fopen( 'Perform/Perform.txt', 'wt');
                    fprintf(perfid, '*************************************************************************************************\n');
                end
                fprintf(perfid, '                             Regularization method          \n\n');
                fprintf(perfid, ['ODE solver: ',ODE,', Cycle number: ',num2str(tau_total),...
                    ', Relative tolerance: ',num2str(Rel_Tol),...
                    ', Integration time: ',t_elaps,' sec.\n']);
                fprintf(perfid, '*************************************************************************************************\n');
            end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if get(app.check_pert,'Value') == true
            Calculate_Trajectories
        elseif get(app.check_nonpert,'Value') == true
            Calculate_TrajectoriesNonPert
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        norma_q = sqrt((sum((q_vec.^2)'))');
        sm_ax = norma_q./(2-((sum((p_vec.^2)'))').*norma_q);
        if all(sm_ax > zeros(size(sm_ax)))
% do nothing
        else
            if strcmp(get(app.warningbox, 'Checked'),'on')
                warndlg('Some values of the semimajor axis are negative or null. It may be that the point is escaping to infinity. Some values of the enlightened buttons may not be reliable.')
            end
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        set(app.pushbutton_Integrate, 'Enable', 'on')
        set(app.pushbutton_StandIntegrate, 'Enable', 'on')
        set(app.pushbutton_Trajectories, 'Enable', 'on')
        set(app.pushbutton_Errors, 'Enable', 'on')
        set(app.pushbutton_tauKepler, 'Enable', 'on')
        set(app.pushbutton_tKepler, 'Enable', 'on')
        set(app.pushbutton_Time, 'Enable', 'on')
        set(app.pushbutton_AA_Delaunay, 'Enable', 'on')
        set(app.pushbutton_AA_Delaunayprime, 'Enable', 'on')
        set(app.pushbutton_AA_Pauli, 'Enable', 'on')
        set(app.pushbutton_AA_Pauliprime, 'Enable', 'on')
        set(app.pushbutton_AA_User, 'Enable', 'on')
        set(app.pushbutton_UserFunction, 'Enable', 'on')
        set(app.pushbutton_tau_Step, 'Enable', 'on')
        set(app.pushbutton_Pauli, 'Enable', 'on')
        if strcmp(get(app.uipanel_Pauli,'Visible') , 'on') == 1
            set(app.pushbutton_Pauliprime, 'Enable', 'on')
            set(app.pushbutton_AA_Delaunayprime, 'Enable', 'on')
            set(app.pushbutton_AA_Pauliprime, 'Enable', 'on')
        else
            set(app.pushbutton_Pauliprime, 'Enable', 'off')
            set(app.pushbutton_AA_Delaunayprime, 'Enable', 'off')
            set(app.pushbutton_AA_Pauliprime, 'Enable', 'off')
        end

        set(app.uipanel_User, 'Visible', 'on')
        set(app.radiobutton_Pauliprime, 'Visible', 'on')
        set(app.radiobutton_Delaunay, 'Visible', 'on')
        set(app.radiobutton_Pauli, 'Visible', 'on')
        set(app.radiobutton_User, 'Visible', 'on')
        if get(app.step_ODE,'Value');
            set(app.pushbutton_FFT, 'Enable', 'on')
            set(app.pushbutton_FMFT, 'Enable', 'on')
            set(app.pushbutton_wavelet, 'Enable', 'on')
        end

        if strcmp(get(app.uipanel_Pauli,'Visible') , 'on') == 1
            set(app.radiobutton_Delaunayprime, 'Enable', 'on')
            set(app.radiobutton_Pauliprime, 'Enable', 'on')
        else
            set(app.radiobutton_Delaunayprime, 'Enable', 'off')
            set(app.radiobutton_Pauliprime, 'Enable', 'off')
        end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
