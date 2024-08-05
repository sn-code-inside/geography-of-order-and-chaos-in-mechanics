%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sm_ax_o = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            Integrate a list of initial values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Avoid visualizing the wrong waitbar
if steps_2D ~= 0
    global pick            
    pick = tau_total;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isdeployed
    fid = fopen( 'Python/parameters.txt', 'wt');
    fprintf(fid, ['[', num2str(lambda, 16),', ', num2str(epsilon1),', ', num2str(epsilon2),', ', ...
                       num2str(epsilon3),', ', num2str(epsilon4),', ', num2str(epsilon5),', ', ...
                       num2str(deg1),', ', num2str(deg2),', ', num2str(deg3),', ', ...
                       num2str(deg4),', ', num2str(deg5),', ', ...
                       '"', Hp1,'"',', ', '"', Hp2,'"',', ', '"', Hp3,'"',', ', ...
                       '"', Hp4,'"',', ', '"', Hp5,'"',']']);                               
    fclose(fid);
    if get(app.check_2D_pert,'Value') == 1
        !python ./Python/Symbolic.py
%        eval(['!',app.pythonDir,'/python ',app.PythonDir,'/Symbolic.py'])
    elseif get(app.check_2D_nonpert,'Value') == 1
        !python ./Python/SymbolicNonPert.py
%        eval(['!',app.pythonDir,'/python ',app.PythonDir,'/SymbolicNonPert.py'])
    end
else
    if get(app.check_2D_pert,'Value') == 1
        Symbolic
        Write2file
        waitfor(exist('DiffEquation'))
    elseif get(app.check_2D_nonpert,'Value') == 1
        SymbolicNonPert
        Write2fileNonPert
        waitfor(exist('DiffEquation'))
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          Begin numerical computation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if steps_2D == 0
    step = 1;
    G_ofinal = G_oinit;

    if strcmp(get(app.Waitbars, 'Checked'),'on')
        global pick                                                                         %%%%% waitbar
%        h = waitbar(0,'Please wait...', 'Units', 'pixels', 'Position', [405 550 360 70]);   %%%%% waitbar
         h = waitbar(0,'Please wait...');
        pick = -tau_total/100;                                                              %%%%% waitbar
    end

else
    step = (G_ofinal - G_oinit)/steps_2D;
%    h = waitbar(0,'Please wait...', 'Units', 'pixels', 'Position', [405 550 360 70]);
     h = waitbar(0,'Please wait...');
end
list_number = 1;
j = 1;
for Gxxx = G_oinit : step : G_ofinal
    if get(app.CheckBoxPlane,'Value') == 1
        if G_ofinal >= 0
            incl_o = 0;
        else
            incl_o = 180;
        end
    else
        if get(app.NormG3,'Value') == 1;
            incl_o = 180/pi*acos(G3_o/Gxxx);
        elseif get(app.TrueG3,'Value') == 1;
            if sm_ax_o <= 0
	        warndlg('The semimajor axis must be positive')
	        return
            end
            incl_o = 180/pi*acos(G3_o/Gxxx/sqrt(sm_ax_o));
        end
    end
%-------------------------------------------------------------------------------
    E_tot = str2num(get(app.edit_EnergyPoincare,'Value'));
    lambda_tot = 1/sqrt(-2*E_tot);
    lambd = lambda_tot + 1;
    lambda = 1.0;
    sm_ax_o = lambda_tot^2;
    Ecc_o = sqrt(1-Gxxx^2);          %Normalized G
%   Ecc_o = sqrt(1-Gxxx^2./sm_ax_o);    
    kk = 0;
    while abs(lambd - lambda_tot) > 1e-02
        if kk > 50
            break
        end
        
        Keplerian2Cartesian
        lambd = 1/sqrt(-2*(1/2*p_vec_o*p_vec_o' - 1/sqrt(q_vec_o*q_vec_o')...
            + Hp(q_vec_o, p_vec_o, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5)));
        
        if (~isreal(lambd) | isnan(lambd))
            break
        end        
        sm_ax_o = lambda_tot^2*sm_ax_o/lambd^2;

        if get(app.CheckBoxPlane,'Value') == 1
            if G_ofinal >= 0
                incl_o = 0;
            else
                incl_o = 180;
            end
        else
            if get(app.NormG3,'Value') == 1;
                incl_o = 180/pi*acos(G3_o/Gxxx);
            elseif get(app.TrueG3,'Value') == 1;
                if sm_ax_o <= 0
	            warndlg('The semimajor axis must be positive')
	            return
                end
                incl_o = 180/pi*acos(G3_o/Gxxx/sqrt(sm_ax_o));
            end
        end                
        kk = kk + 1;
    end

    if (~isreal(lambd) | isnan(lambd))
        Keplerian2Cartesian
    end
    
    f = @(z)1/sqrt(-2*(1/2*z^2*p_vec_o*p_vec_o' - 1/sqrt(q_vec_o*q_vec_o')*z^2 ...
            + Hp(q_vec_o/z^2, p_vec_o*z, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5))) - lambda_tot;
    opts = optimset('Display','off');
    
    try
        a = fzero(f,1,opts);
    catch
        warndlg(sprintf(['With the selected value of Total Energy I am not able to find the initial conditions.']))
        return
    end    

    if isnan(a)
        disp('With the selected value of Total Energy it is impossible to find')
        disp('the initial conditions for a correct value of G and G3.')
        disp('The corresponding section will be left blank.')
        disp('    ')
        waitbar((Gxxx-G_oinit+step)/(G_ofinal-G_oinit+step))
        continue
    end
    
    q_vec_o = q_vec_o/a^2;
    p_vec_o = p_vec_o*a;
   
    lambda = lambda_tot;
    x_vec_o = 1/(lambda^2)*q_vec_o;
    y_vec_o = lambda*p_vec_o;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if get(app.check_2D_pert,'Value') == 1  
        [Uo, Vo] = xy2uv(x_vec_o, y_vec_o);
    elseif get(app.check_2D_nonpert,'Value') == 1   
        [z_vec_o,  w_vec_o] = xy2zw(x_vec_o,  y_vec_o);
        Uo = z_vec_o';
        Vo = w_vec_o';
    end
    block = str2num(get(app.edit_block,'Value'));

        Rel_Tol = get(app.RelTol,'Value');
        Abs_Tol = get(app.AbsTol,'Value');
        OutStepst = get(app.step_ODE,'Value');
        if isempty(OutStepst)
             if (strcmp(ODE,'BulirschStoer') | strcmp(ODE,'ABM8') | strcmp(ODE,'ShampineGordon'))
                 warndlg('The Output Step must be strictly positive');
             return
             end
            Output_Step = '';
        else
            Output_Step = [':',OutStepst,':'];
        end

        if strcmp(ODE,'BulirschStoer')
            options = Abs_Tol;
        else
            options = odeset('RelTol',[Rel_Tol], 'AbsTol',[Abs_Tol]);
        end
        
        if block
            n_cycle = floor(tau_total/block);
            k = 1; w = []; tau_ = [];
            for k = 1:n_cycle
            if isdeployed
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

                if get(app.check_2D_pert,'Value') == 1
                    [xo yo] = uv2xy(Uo, Vo);       
                    [Uo Vo] = xy2uv(xo, yo);        
                    [xo yo] = uv2xy(Uo, Vo);
                elseif get(app.check_2D_nonpert,'Value') == 1
                    [xo yo] = zw2xy(Uo, Vo);
                    [Uo Vo] = xy2zw(xo, yo);           
                    [xo yo] = zw2xy(Uo, Vo);
                end

%---------------------- SOSTITUZIONE ---------------------------------------------------------                
%{
                Ktot = 1.001;
                while abs(Ktot-1) > 5*eps
                    Ktot = 1/2*sqrt(xo*xo')*(yo*yo'+1) + sqrt(xo*xo')*...
                    Kp(xo,yo, lambda, epsilon1, epsilon2, epsilon3, epsilon4,...
                        deg1, deg2, deg3, deg4, Hp1, Hp2, Hp3, Hp4);
                    xo = xo/Ktot;
                end           
%}
                f = @(z)1/2*sqrt(z^2*xo*xo')*(yo*yo'+1) + sqrt(z^2*xo*xo')*...
                    Kp(z*xo,yo, lambda, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5,...
                        deg1, deg2, deg3, deg4, deg5, Hp1, Hp2, Hp3, Hp4, Hp5) - 1;
                a = fzero(f,1);
                xo =a*xo;
%---------------------------------------------------------------------------------------------        

                if get(app.check_2D_pert,'Value') == 1
                    [Uo Vo] = xy2uv(xo, yo);
                elseif get(app.check_2D_nonpert,'Value') == 1
                    [Uo Vo] = xy2zw(xo, yo);
                    Uo = Uo'; Vo = Vo';
                end        

            end
            if (n_cycle*block ~= tau_total)
                if isdeployed
                    testoF = fileread('Python/F_str.txt');
                    [tau_c,W] = eval([ODE,'(@(tau, W) ', testoF, ', [n_cycle*block ',Output_Step,' tau_total], [Uo; Vo], options)']);
                else                   
                    [tau_c,W] = eval([ODE, '(@DiffEquation, [n_cycle*block ',Output_Step,' tau_total], [Uo; Vo], options)']);
                end
                W = [w; W];
                tau_c = [tau_; tau_c];
            else
                W = w;
                tau_c = tau_;
            end
        else
            if isdeployed
                testoF = fileread('Python/F_str.txt');
                [tau_c,W] = eval([ODE,'(@(tau, W) ', testoF, ', [0 ',Output_Step,' tau_total], [Uo; Vo], options)']);
            else              
                [tau_c,W] = eval([ODE, '(@DiffEquation, [0 ',Output_Step,' tau_total], [Uo; Vo], options)']);
            end
        end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if get(app.check_2D_pert,'Value') == 1
        Calculate_Trajectories
    elseif get(app.check_2D_nonpert,'Value') == 1
        Calculate_TrajectoriesNonPert
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    norma_q = sqrt((sum((q_vec.^2)'))');
    sm_ax = norma_q./(2-((sum((p_vec.^2)'))').*norma_q);
    if all(sm_ax > zeros(size(sm_ax)))
% do nothing
    else
        if strcmp(get(app.warningbox, 'Checked'),'on')
            warndlg('Some values of the semimajor axis are negative or null. It may be that the point is escaping to infinity or is falling into a singularity, so that the semimajor axis is ill defined.')
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Poincaré section
    norma_q = sqrt((sum((q_vec.^2)'))');
    sm_ax = norma_q./(2-((sum((p_vec.^2)'))').*norma_q);
    Delta = scalarp(q_vec,p_vec)./sqrt(sm_ax);
    delta = (sm_ax-norma(q_vec))./sm_ax;
    l = 180/pi*atan2(-delta.*sin(Delta)+Delta.*cos(Delta), delta.*cos(Delta)+Delta.*sin(Delta));
    G_vec = vectorp(q_vec, p_vec);
    G = norma(G_vec);
    Ecc_vec = vectorp(p_vec, G_vec)-q_vec./[norma(q_vec)  norma(q_vec)  norma(q_vec)];
    Ecc = norma(Ecc_vec);
%     if sqrt(G_vec(1:4,1).^2+G_vec(1:4,2).^2) == zeros(4,1);
    if get(app.CheckBoxPlane,'Value') == 1
        node = [ones(size(q_vec(:,1)))  zeros(size(q_vec(:,1)))  zeros(size(q_vec(:,1)))];
    else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        G_prj = sqrt(G_vec(:,1).^2+G_vec(:,2).^2);
        sz = size(G_prj);
        if all(G_prj)
            node = [-G_vec(:,2)./G_prj  G_vec(:,1)./G_prj  zeros(sz)];           
        else
            if any(G_prj)
                node = zeros(sz(1),3);
                node(1,:) = [1  0  0];
                for jsz = 1 : sz(1)
                    if G_prj(jsz) == 0
                        if jsz == 1
                        else
                            node(jsz,:) = node(jsz-1,:);
                        end
                    else
                        node(jsz,:) = [-G_vec(jsz,2)/G_prj(jsz)  G_vec(jsz,1)/G_prj(jsz)  0 ];
                    end
                end
            else
                node = [ones(sz)  zeros(sz)  zeros(sz)];
            end
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    omega = 180/pi*atan2(scalarp(vectorp(node, Ecc_vec), G_vec)./G,...
        scalarp(node, Ecc_vec));
    if get(app.CheckBoxPlane,'Value') == 1
        Action= G_vec(:,3)./sqrt(sm_ax);       % = normalized G_3
    elseif get(app.CheckBox3D,'Value') == 1
        Action = G./sqrt(sm_ax);               % = normalized G
    end
    Angl = omega;

    d = size(Angl, 1);
    k = 1;
    while k < d       
        if sign(l(k)) == sign(l(k+1))           
            k = k+1;         
        else    
            if l(k) < l(k+1)    
                Delta = -l(k)/(l(k+1)-l(k));    
                Ang(j) = Angl(k) + (Angl(k+1)-Angl(k))*Delta;    
                Act(j) = Action(k) + (Action(k+1)-Action(k))*Delta;        
                k = k+1;
                j = j+1;
            else    
                k = k+1;     
            end           
        end    
    end
    if steps_2D ~= 0
        waitbar((Gxxx-G_oinit+step)/(G_ofinal-G_oinit+step))
    end
    clear DiffEquation
    list_number = list_number + 1;
end

G3_Value = num2str(G3_o,16);
figure
if strcmp(get(app.LargeMS, 'Checked'),'on')
    MarkSize = 6;
else
    MarkSize = 4;
end
plot(Ang(:), Act(:), '.k','MarkerSize',MarkSize)
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_x
end
if get(app.CheckBoxPlane,'Value') == 1
    title('Poincaré map', 'FontSize',14)
    ylabel('\itG/L', 'FontSize',14), xlabel('\omega   (deg)', 'FontSize',12)
else
    if get(app.NormG3,'Value') == 1;
        title(['Poincaré map \rmwith Normalized \itG_3 = \rm',G3_Value], 'FontSize',14)
    elseif get(app.TrueG3,'Value') == 1;             
        title(['Poincaré map \rmwith True \itG_3 = \rm',G3_Value], 'FontSize',14)
    end
    ylabel('\itG/L', 'FontSize',14), xlabel('\omega   (deg)', 'FontSize',12)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if get(app.checkbox_append, 'Value') == 1
    global Ang_tot Act_tot
    Ang_tot = [Ang_tot  Ang];
    Act_tot = [Act_tot  Act];
    set(app.pushbutton_clear2D, 'Enable', 'on')
    figure
    if strcmp(get(app.LargeMS, 'Checked'),'on')
        MarkSize = 6;
    else
        MarkSize = 4;
    end
    plot(Ang_tot(:), Act_tot(:), '.k','MarkerSize',MarkSize)
    if strcmp(get(app.no_degree, 'Checked'),'off')
        Degree_x
    end
    if get(app.CheckBoxPlane,'Value') == 1
        title('Total Poincaré map', 'FontSize',14)
        ylabel('\itG/L', 'FontSize',14), xlabel('\omega   (deg)', 'FontSize',12)
    else        
        if get(app.NormG3,'Value') == 1;
            title(['Total Poincaré map \rmwith Normalized \itG_3 = \rm',G3_Value], 'FontSize',14)
        elseif get(app.TrueG3,'Value') == 1;             
            title(['Poincaré map with True \itG_3 = \rm',G3_Value,'   (Append)'], 'FontSize',14)
        end
        ylabel('\itG/L', 'FontSize',14), xlabel('\omega   (deg)', 'FontSize',12)
    end    
end

close(h)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%