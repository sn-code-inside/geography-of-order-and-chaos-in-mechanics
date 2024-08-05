%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sm_ax_o = 1.0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            Integrate a single orbit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if steps_2D == 0    
    omega_o = str2num(get(app.edit_2D_omega,'Value'));
    f_o =   0;
    Omega_o = 0;
    if get(app.CheckBoxPlane,'Value') == 1
        if G_oinit >= 0
            incl_o = 0;
        else
            incl_o = 180;
        end
    else 
        if get(app.NormG3,'Value') == 1;
            incl_o = 180/pi*acos(G3_o/G_oinit);
        elseif get(app.TrueG3,'Value') == 1;
            incl_o = 180/pi*acos(G3_o/G_oinit/sqrt(sm_ax_o));
        end
    end
    %-------------------------------------------------------------------------------
    E_tot = str2num(get(app.edit_EnergyPoincare,'Value'));
    lambda_tot = 1/sqrt(-2*E_tot);
    lambd = lambda_tot + 1;
    lambda = 1.0;
    sm_ax_o = lambda_tot^2;
    Ecc_o = sqrt(1-G_oinit^2);      %Normalized G
%   Ecc_o = sqrt(1-G_oinit^2/sm_ax_o);    
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
            if G_oinit >= 0
                incl_o = 0;
            else
                incl_o = 180;
            end
        else      
            if get(app.NormG3,'Value') == 1;
                incl_o = 180/pi*acos(G3_o/G_oinit);
            elseif get(app.TrueG3,'Value') == 1;
                incl_o = 180/pi*acos(G3_o/G_oinit/sqrt(sm_ax_o));
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
        warndlg(sprintf(['With the selected value of Total Energy it is impossible to find ',...
          'the initial conditions for a correct value of G and G3.']))
        return
    end
    q_vec_o = q_vec_o/a^2;
    p_vec_o = p_vec_o*a;    
    lambda = lambda_tot;   
    %---------------------------------------------------------------------
    Keplerian2Cartesian
    set(app.q1_value,'Value', num2str(q_vec_o(1)))
    set(app.q2_value,'Value', num2str(q_vec_o(2)))
    set(app.q3_value,'Value', num2str(q_vec_o(3)))
    set(app.p1_value,'Value', num2str(p_vec_o(1)))
    set(app.p2_value,'Value', num2str(p_vec_o(2)))
    set(app.p3_value,'Value', num2str(p_vec_o(3)))

    set(app.edit_smaxis,'Value', num2str(sm_ax_o,'%5.10f'))
    set(app.edit_Eccentricity,'Value', num2str(Ecc_o,'%5.10f'))
    set(app.edit_AscNode,'Value', num2str(Omega_o,'%5.10f'))
    set(app.edit_ArgPericenter,'Value', num2str(omega_o,'%5.10f'))
    set(app.edit_Inclination,'Value', num2str(incl_o,'%5.10f'))
    set(app.edit_TrueAnomaly,'Value', num2str(f_o,'%5.10f'))

    Disable_General

    set(app.radiobutton_Pauliprime, 'Enable', 'off')
    set(app.radiobutton_Delaunayprime, 'Enable', 'off')   
    set(app.uipanel_PoincFreq_2D, 'Visible', 'off')
    set(app.uipanelInit, 'Visible', 'on')
    set(app.uipanel_AA_FMFT, 'Visible', 'on')
    set(app.uipanel_RegMethod, 'Visible', 'on')
    set(app.uipanel_StandMethod, 'Visible', 'on')
    set(app.uipanel_from_to, 'Visible', 'on')
    set(app.uipanel_ClearMemory,'Visible', 'on')
%    set(app.SecondOorderCheckBox,'Value', 0)
    set(app.radiobutton_Delaunay,'Value', 1)
    set(app.radiobutton_Delaunayprime,'Value', 0)
    set(app.radiobutton_Pauli,'Value', 0)
    set(app.radiobutton_Pauliprime,'Value', 0)
    ValuePert = get(app.check_2D_pert,'Value');
    ValueNonPert = get(app.check_2D_nonpert,'Value');
    set(app.check_pert,'Value', ValuePert)
    set(app.check_nonpert,'Value', ValueNonPert)     
    set(app.edit_block,'Visible', 'on')
    set(app.text_block,'Visible', 'on')
    set(app.popupmenu_head,'Value', '1')
    
%    pushbutton_Integrate_Callback(hObject, eventdata, app)
    Integrate
    return
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            Integrate a list of initial values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Avoid visualizing the wrong waitbar
global pick            
pick = tau_total;
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
step = (G_ofinal - G_oinit)/steps_2D;
list_number = 1;
j = 1;
h = waitbar(0,'Please wait...');
begin = datestr(now, 'dd mmm HH:MM');
for Gxxx = G_oinit : step : G_ofinal
    Go(j) = Gxxx;
    if get(app.CheckBoxPlane,'Value') == 1
        incl_o = 0;
    else
        if get(app.NormG3,'Value') == 1;
            incl_o = 180/pi*acos(G3_o/Gxxx);
        elseif get(app.TrueG3,'Value') == 1;             
            incl_o = 180/pi*acos(G3_o/Gxxx/sqrt(sm_ax_o));
        end      
    end
    %-------------------------------------------------------------------------------
    E_tot = str2num(get(app.edit_EnergyPoincare,'Value'));
    lambda_tot = 1/sqrt(-2*E_tot);
    lambd = lambda_tot + 1;
    lambda = 1.0;
    sm_ax_o = lambda_tot^2;
        Ecc_o = sqrt(1-Gxxx^2);           %Normalized G
%        Ecc_o = sqrt(1-Gxxx^2/sm_ax_o);    
    kk = 0;
    while abs(lambd - lambda_tot) > 1e-02
        if kk > 50
            break
        end        

        Keplerian2Cartesian
        lambd = 1/sqrt(-2*(1/2*p_vec_o*p_vec_o' - 1/sqrt(q_vec_o*q_vec_o')...
             + Hp(q_vec_o, p_vec_o, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5)));
         
        if ~isreal(lambd)
            break
        end
        sm_ax_o = lambda_tot^2*sm_ax_o/lambd^2;
        
        if get(app.CheckBoxPlane,'Value') == 1
            incl_o = 0;
        else
            if get(app.NormG3,'Value') == 1;
                incl_o = 180/pi*acos(G3_o/Gxxx);
            elseif get(app.TrueG3,'Value') == 1;             
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
        disp('The corresponding frequency values will be left blank.')
        disp('    ')            
        freq_L(j) = NaN;
        freq_G(j) = NaN;
        j = j + 1;
        frac = (Gxxx-G_oinit+step)/(G_ofinal-G_oinit+step);
        update = ['Please, wait: ', num2str(floor(frac*100)), '% completed. Starting time: ', begin];
        waitbar(frac, h, update)        
        continue
    end
    q_vec_o = q_vec_o/a^2;
    p_vec_o = p_vec_o*a;    
    lambda = lambda_tot;   
    %---------------------------------------------------------------------     
%     Keplerian = [sm_ax_o  Ecc_o  Omega_o  omega_o  incl_o  f_o];
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
        OutStep = str2num(get(app.step_ODE,'Value'));
        OutStepst = num2str(OutStep);
        if isempty(OutStepst)
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Dir%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    data_sep = num2str(2*pi*100000*OutStep);
    flag_FMFT = num2str(get(app.popupmenu_FMFT_flag,'Value'));
    d = size(q_vec(:,1),1);    
    ndata = num2str(2^(floor(log2(d))));
    DelaunayforFMFT
    KeplerDir = cd;
    cd ..
    cd ..
    cd ..
    PhSpGeoDir = cd;
    cd([KeplerDir, '/FMFT'])     
    min_f = str2num(get(app.minLfreq_2D,'Value'));
    max_f = str2num(get(app.maxLfreq_2D,'Value'));
    if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = num2str(1000*max_f,'%6.12f');
        nfreq = num2str(2);
        cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
              data_sep,' ',ndata,' ','<inputL.txt',' ','>FMFT_of_L.txt'];  
        eval(cmd_Value)
        [frq_L] = textread('FMFT_of_L.txt', '%f %*f %*f', 'headerlines', 4);
        if numel(frq_L)== 0
            disp('Some error occurred: the corresponding frequency values will be left blank.')
            disp('    ')        
            freq_L(j) = NaN;
            freq_G(j) = NaN;
            j = j + 1;
            frac = (Gxxx-G_oinit+step)/(G_ofinal-G_oinit+step);
            update = ['Please, wait: ', num2str(floor(frac*100)), '% completed. Starting time: ', begin];
            waitbar(frac, h, update)
            cd(KeplerDir)
            continue
        end             
             
        if abs(frq_L(1)) > 1
            freq_L(j) = frq_L(1);
        else
            freq_L(j) = frq_L(2);
        end
    else
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = num2str(1000*max_f,'%6.12f');         
        nfreq = num2str(1);
        cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
               data_sep,' ',ndata,' ','<inputL.txt',' ','>FMFT_of_L.txt'];  
        eval(cmd_Value)     
        frq_L = textread('FMFT_of_L.txt', '%f %*f %*f', 'headerlines', 4);
        if numel(frq_L)== 0
            disp('Some error occurred: the corresponding frequency values will be left blank.')
            disp('    ')        
            freq_L(j) = NaN;
            freq_G(j) = NaN;
            j = j + 1;
            frac = (Gxxx-G_oinit+step)/(G_ofinal-G_oinit+step);
            update = ['Please, wait: ', num2str(floor(frac*100)), '% completed. Starting time: ', begin];
            waitbar(frac, h, update)
            cd(KeplerDir)
            continue
        end         
        freq_L(j) = frq_L;
    end

    min_f = str2num(get(app.minGfreq_2D,'Value'));
    max_f = str2num(get(app.maxGfreq_2D,'Value'));
    if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = num2str(1000*max_f,'%6.12f');
        nfreq = num2str(2);
        cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
              data_sep,' ',ndata,' ','<inputG.txt',' ','>FMFT_of_G.txt'];  
        eval(cmd_Value)
        [frq_G] = textread('FMFT_of_G.txt', '%f %*f %*f', 'headerlines', 4);
        if numel(frq_G)== 0
            disp('Some error occurred: the corresponding frequency values will be left blank.')
            disp('    ')        
            freq_L(j) = NaN;
            freq_G(j) = NaN;
            j = j + 1;
            frac = (Gxxx-G_oinit+step)/(G_ofinal-G_oinit+step);
            update = ['Please, wait: ', num2str(floor(frac*100)), '% completed. Starting time: ', begin];
            waitbar(frac, h, update)
            cd(appKeplerDir)
            continue
        end         
        if abs(frq_G(1)) > 1
            freq_G(j) = frq_G(1);
        else
            freq_G(j) = frq_G(2);
        end
    else
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = num2str(1000*max_f,'%6.12f');         
        nfreq = num2str(1);
        cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
               data_sep,' ',ndata,' ','<inputG.txt',' ','>FMFT_of_G.txt'];  
        eval(cmd_Value)     
        frq_G = textread('FMFT_of_G.txt', '%f %*f %*f', 'headerlines', 4);
        if numel(frq_L)== 0
            disp('Some error occurred: the corresponding frequency values will be left blank.')
            disp('    ')        
            freq_L(j) = NaN;
            freq_G(j) = NaN;
            j = j + 1;
            frac = (Gxxx-G_oinit+step)/(G_ofinal-G_oinit+step);
            update = ['Please, wait: ', num2str(floor(frac*100)), '% completed. Starting time: ', begin];
            waitbar(frac, h, update)
            cd(KeplerDir)
            continue
        end         
        freq_G(j) = frq_G;
    end
     
    freq_ratio = abs(freq_L(:)./freq_G(:));
     
    cd(KeplerDir)
     
    frac = (Gxxx-G_oinit+step)/(G_ofinal-G_oinit+step);
    update = ['Please, wait: ', num2str(floor(frac*100)), '% completed. Starting time: ', begin];
    waitbar(frac, h, update) 
     
    clear DiffEquation     

    list_number = list_number + 1;
    j = j+1;
end

G3_Value = num2str(G3_o);
figure
plot(Go, freq_ratio)

if get(app.CheckBoxPlane,'Value') == 1
    title('Frequency ratio |\omega_{\itL} / \omega_{\itG}|', 'FontSize',14)
else
    if get(app.NormG3,'Value') == 1;
        title(['Frequency ratio |\omega_{\itL} / \omega_{\itG}| \rmwith Normalized \itG_3 = \rm', G3_Value], 'FontSize',14)
    elseif get(app.TrueG3,'Value') == 1;             
        title(['Frequency ratio |\omega_{\itL} / \omega_{\itG}| \rmwith True \itG_3 = \rm', G3_Value], 'FontSize',14)
    end        
end
ylabel('Frequency ratio', 'FontSize',14), xlabel('Angular momentum \itG', 'FontSize',14)

figure
hold on
plot(Go, freq_L, 'r')
plot(Go, freq_G, 'k')
legend('\it\omega_L','\it\omega_G')
hold off
if get(app.CheckBoxPlane,'Value') == 1
    title('Frequencies \times1000', 'FontSize',14)
else    
    if get(app.NormG3,'Value') == 1;
        title(['Frequencies \times1000 \rmwith Normalized \itG_3 = \rm', G3_Value], 'FontSize',14)
    elseif get(app.TrueG3,'Value') == 1;             
        title(['Frequencies \times1000 \rmwith True \itG_3 = \rm', G3_Value], 'FontSize',14)
    end         
end
ylabel('Frequencies', 'FontSize',14), xlabel('Angular momentum \itG', 'FontSize',14)

close(h)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
