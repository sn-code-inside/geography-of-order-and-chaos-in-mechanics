function Y = parfor_LGG3(X)

KeplerDir = cd;
cd ..
cd ..
cd ..
PhSpGeoDir = cd;
cd(KeplerDir)
ext = X{1,1}; stepG = X{1,2}; stepG3 = X{1,3}; RotS = X{1,4}; RotD = X{1,5};
Output_Step = X{1,6}; options = X{1,7};
S_vec_o = X{1,8}; D_vec_o = X{1,9}; InitData = X(1,10);
begin = X{1,11}; mainbar = X{1,12};

InitData = InitData{1,1};
sm_ax_o = 1;
f_o =   0;
omega_o = InitData.omega_o;
G_init  = InitData.G_init;
row_tot = InitData.row_tot_LGG3;
G3_init = InitData.G3_init;
col_tot = InitData.col_tot_LGG3;
E_tot   = InitData.E_tot_LGG3;
lambda_tot = 1/sqrt(-2*E_tot);

int_tot = min(row_tot, col_tot);
ext_tot = max(row_tot, col_tot);

epsilon1 = InitData.epsilon1;
epsilon2 = InitData.epsilon2;
epsilon3 = InitData.epsilon3;
epsilon4 = InitData.epsilon4;
epsilon5 = InitData.epsilon5;

degrees = [0.5,0.5,0.5,2,2,2,1,1,1,2,-1,-1,-1,3,-2,-3,-0.5,2,-1,-1];
               
            Hp1 = InitData.Hp1;
            deg1 = InitData.deg1;

            Hp2 = InitData.Hp2;
            deg2 = InitData.deg2;

            Hp3 = InitData.Hp3;
            deg3 = InitData.deg3;

            Hp4 = InitData.Hp4;
            deg4 = InitData.deg4;

            Hp5 = InitData.Hp5;
            deg5 = InitData.deg5;

ODE = InitData.ODE;           
if strcmp(ODE,'BulirschStoer')
    options = options.AbsTol;
end
tau_total = InitData.tau_total;
tau_i = InitData.tau_i;
tau_f = InitData.tau_f;

extstr = num2str(ext);
if row_tot <= col_tot   
    G3_step = G3_init + stepG3*(ext-1);
else
    G_step = G_init + stepG*(ext-1);    
end

ccount = 0;

for int = 1:int_tot
    if row_tot <= col_tot
        G_step = G_init + stepG*(int-1);        
    else
        G3_step = G3_init + stepG3*(int-1);
    end

    if abs(G3_step) > G_step
        freq_1(int) = NaN;
        freq_min_1(int) = NaN;
        freq_max_1(int) = NaN;
        freq_2(int) = NaN;
        freq_min_2(int) = NaN;
        freq_max_2(int) = NaN;        
        freq_3(int) = NaN;
        freq_min_3(int) = NaN;
        freq_max_3(int) = NaN;               
    else
        G_step_vec_prime = [0  -sqrt(G_step^2-G3_step^2)  G3_step];
        R_step_vec_prime = sqrt(sm_ax_o-G_step^2)*[cos(pi/180*omega_o)  sin(pi/180*omega_o)*G3_step/G_step  ...
            sin(pi/180*omega_o)*sqrt(1- G3_step^2/G_step^2)];
        S_step_vec_prime = 1/2*(G_step_vec_prime + R_step_vec_prime);
        D_step_vec_prime = 1/2*(G_step_vec_prime - R_step_vec_prime);
        S_vec = S_step_vec_prime*RotS';
        D_vec = D_step_vec_prime*RotD';
        [q_vec_o, p_vec_o] = SD2Cartesian(S_vec, D_vec, f_o);
        
%------------------------------------------------------------------------
        lambd = lambda_tot + 1;
        clear global lambda
        kk = 0;
        while abs(lambd - lambda_tot) > 1e-02
            if kk > 50
                break
            end
            lambd = 1/sqrt(-2*(1/2*p_vec_o*p_vec_o' - 1/sqrt(q_vec_o*q_vec_o')...
                + Hp(q_vec_o, p_vec_o, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5)));
            
            if ~isreal(lambd)
                break
            end
            
            q_vec_o = lambda_tot^2*q_vec_o/lambd^2;
            p_vec_o = p_vec_o*lambd/lambda_tot;
            kk = kk + 1;
        end
        
        if (~isreal(lambd) | isnan(lambd))
            [q_vec_o, p_vec_o] = SD2Cartesian(S_vec, D_vec, f_o);
        end
        
        f = @(z)1/sqrt(-2*(1/2*z^2*p_vec_o*p_vec_o' - 1/sqrt(q_vec_o*q_vec_o')*z^2 ...
                + Hp(q_vec_o/z^2, p_vec_o*z, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5))) - lambda_tot;
        opts = optimset('Display','off');
        
        try
            a = fzero(f,1,opts);
        catch
            disp('With the selected value of Total Energy it is impossible to find')
            disp('the initial conditions for a correct value of G and G3.')
            disp('Some error occurred: the corresponding frequency and FMI values will be left blank.')
            disp('    ')            
            freq_1(int) = NaN;
            freq_min_1(int) = NaN;
            freq_max_1(int) = NaN;
            freq_2(int) = NaN;
            freq_min_2(int) = NaN;
            freq_max_2(int) = NaN;        
            freq_3(int) = NaN;
            freq_min_3(int) = NaN;
            freq_max_3(int) = NaN;
            cd(KeplerDir)            
            continue
        end

        if isnan(a)
            disp('With the selected value of Total Energy it is impossible to find')
            disp('the initial conditions for a correct value of G and G3.')
            disp('Some error occurred: the corresponding frequency and FMI values will be left blank.')
            disp('    ')            
            freq_1(int) = NaN;
            freq_min_1(int) = NaN;
            freq_max_1(int) = NaN;
            freq_2(int) = NaN;
            freq_min_2(int) = NaN;
            freq_max_2(int) = NaN;        
            freq_3(int) = NaN;
            freq_min_3(int) = NaN;
            freq_max_3(int) = NaN;
            cd(KeplerDir)            
            continue
        end                  
        q_vec_o = q_vec_o/a^2;
        p_vec_o = p_vec_o*a;
        global lambda
        lambda = lambda_tot;
%--------------------------------------------------------------------------
        x_vec_o = 1/(lambda^2)*q_vec_o;
        y_vec_o = lambda*p_vec_o;     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if InitData.Pert_LGG3 == 1  
            [Uo, Vo] = xy2uv(x_vec_o, y_vec_o);
        elseif InitData.NonPert_LGG3 == 1   
            [z_vec_o,  w_vec_o] = xy2zw(x_vec_o,  y_vec_o);
            Uo = z_vec_o';
            Vo = w_vec_o';
        end       

        block = InitData.block;
        OutStep = InitData.OutStep;
       
            OutStepst = num2str(OutStep);
            if isempty(OutStep)
                InitData.OutStep = '0.01';
                OutStepst = '0.01';
                Output_Step = [':',OutStepst,':'];
            else
                Output_Step = [':',OutStepst,':'];
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

                    if InitData.Pert_LGG3 == 1
                        [xo yo] = uv2xy(Uo, Vo);       
                        [Uo Vo] = xy2uv(xo, yo);        
                        [xo yo] = uv2xy(Uo, Vo);
                    elseif InitData.NonPert_LGG3 == 1
                        [xo yo] = zw2xy(Uo, Vo);
                        [Uo Vo] = xy2zw(xo, yo);           
                        [xo yo] = zw2xy(Uo, Vo);
                    end

%--------------------------------------------------------------------------------------                
                f = @(z)1/2*sqrt(z^2*xo*xo')*(yo*yo'+1) + sqrt(z^2*xo*xo')*...
                    Kp(z*xo,yo, lambda, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5,...
                        deg1, deg2, deg3, deg4, deg5, Hp1, Hp2, Hp3, Hp4, Hp5) - 1;
                a = fzero(f,1);
                xo =a*xo;
%---------------------------------------------------------------------------------------------           

                    if InitData.Pert_LGG3 == 1
                        [Uo Vo] = xy2uv(xo, yo);
                    elseif InitData.NonPert_LGG3 == 1
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if InitData.Pert_LGG3 == 1
            Calculate_Trajectories
        elseif InitData.NonPert_LGG3 == 1
            Calculate_TrajectoriesNonPert
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        norma_q = sqrt((sum((q_vec.^2)'))');
        sm_ax = norma_q./(2-((sum((p_vec.^2)'))').*norma_q);
        if all(sm_ax > zeros(size(sm_ax)))
            % do nothing
        else
            if strcmp(InitData.warningbox,'on')
                warndlg('Some values of the semimajor axis are negative or null. It may be that the point is escaping to infinity or is falling into the singularity, so that the semimajor axis is ill defined.')
            end
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        data_sep = num2str(2*pi*100000*OutStep);
        flag_FMFT = num2str(1);
        d = size(q_vec(:,1),1);    
        ndata = num2str(2^(floor(log2(d))));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        qp2SD
        Sprime_vec = S_vec*RotS;
        Dprime_vec = D_vec*RotD;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        qp2uv  
%%%%%%%%%%%%%%%%%%%%%  
        SoDo2uRvR
%%%%%%%%%%%%%%%%%%%%%
        DelaunayprimeforFMFT
        WriteInputLGG3
%%%%%%%%%%%%%%%%%%%%%
        cd([KeplerDir, '/FMFT'])

        min_f = InitData.min_f1_LGG3;
        max_f = InitData.max_f1_LGG3;
        if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)
            min_f = num2str(1000*min_f,'%6.12f');
            max_f = num2str(1000*max_f,'%6.12f');
            nfreq = num2str(2);
            cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                data_sep,' ',ndata,' ',['<inputAct1_',extstr,'.txt'],' ',['>FMFT_of_Act1_',extstr,'.txt']];  
            eval(cmd_Value)
            [frq_1] = textread(['FMFT_of_Act1_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
            if numel(frq_1)== 0
                freq_1(int) = NaN;
                freq_min_1(int) = NaN;
                freq_max_1(int) = NaN;
                freq_2(int) = NaN;
                freq_min_2(int) = NaN;
                freq_max_2(int) = NaN;        
                freq_3(int) = NaN;
                freq_min_3(int) = NaN;
                freq_max_3(int) = NaN;
                cd(KeplerDir)
                continue
            end
            if abs(frq_1(1)) > 1
                freq_1(int) = frq_1(1);
            else
                freq_1(int) = frq_1(2);
            end
        else
            min_f = num2str(1000*min_f,'%6.12f');
            max_f = num2str(1000*max_f,'%6.12f');         
            nfreq = num2str(1);
            cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                data_sep,' ',ndata,' ',['<inputAct1_',extstr,'.txt'],' ',['>FMFT_of_Act1_',extstr,'.txt']];  
            eval(cmd_Value)
            [frq_1] = textread(['FMFT_of_Act1_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
            if numel(frq_1)== 0
                freq_1(int) = NaN;
                freq_min_1(int) = NaN;
                freq_max_1(int) = NaN;
                freq_2(int) = NaN;
                freq_min_2(int) = NaN;
                freq_max_2(int) = NaN;        
                freq_3(int) = NaN;
                freq_min_3(int) = NaN;
                freq_max_3(int) = NaN;
                cd(KeplerDir)
                continue
            end
            freq_1(int) = frq_1;
        end

        min_f = InitData.min_f2_LGG3;
        max_f = InitData.max_f2_LGG3;
        if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)
            min_f = num2str(1000*min_f,'%6.12f');
            max_f = num2str(1000*max_f,'%6.12f');
            nfreq = num2str(2);
            cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                data_sep,' ',ndata,' ',['<inputAct2_',extstr,'.txt'],' ',['>FMFT_of_Act2_',extstr,'.txt']];  
            eval(cmd_Value)
            [frq_2] = textread(['FMFT_of_Act2_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
            if numel(frq_2)== 0
                freq_1(int) = NaN;
                freq_min_1(int) = NaN;
                freq_max_1(int) = NaN;
                freq_2(int) = NaN;
                freq_min_2(int) = NaN;
                freq_max_2(int) = NaN;        
                freq_3(int) = NaN;
                freq_min_3(int) = NaN;
                freq_max_3(int) = NaN;
                cd(KeplerDir)
                continue
            end            
            if abs(frq_2(1)) > 1
                freq_2(int) = frq_2(1);
            else
                freq_2(int) = frq_2(2);
            end
        else
            min_f = num2str(1000*min_f,'%6.12f');
            max_f = num2str(1000*max_f,'%6.12f');         
            nfreq = num2str(1);
            cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                data_sep,' ',ndata,' ',['<inputAct2_',extstr,'.txt'],' ',['>FMFT_of_Act2_',extstr,'.txt']];  
            eval(cmd_Value)
            [frq_2] = textread(['FMFT_of_Act2_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
            if numel(frq_2)== 0
                freq_1(int) = NaN;
                freq_min_1(int) = NaN;
                freq_max_1(int) = NaN;
                freq_2(int) = NaN;
                freq_min_2(int) = NaN;
                freq_max_2(int) = NaN;        
                freq_3(int) = NaN;
                freq_min_3(int) = NaN;
                freq_max_3(int) = NaN;
                cd(KeplerDir)
                continue
            end            
            freq_2(int) = frq_2;
        end

        min_f = InitData.min_f3_LGG3;
        max_f = InitData.max_f3_LGG3;
        if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)
            min_f = num2str(1000*min_f,'%6.12f');
            max_f = num2str(1000*max_f,'%6.12f');
            nfreq = num2str(2);
            cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                data_sep,' ',ndata,' ',['<inputAct3_',extstr,'.txt'],' ',['>FMFT_of_Act3_',extstr,'.txt']];  
            eval(cmd_Value)
            [frq_3] = textread(['FMFT_of_Act3_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
            if numel(frq_3)== 0
                freq_1(int) = NaN;
                freq_min_1(int) = NaN;
                freq_max_1(int) = NaN;
                freq_2(int) = NaN;
                freq_min_2(int) = NaN;
                freq_max_2(int) = NaN;        
                freq_3(int) = NaN;
                freq_min_3(int) = NaN;
                freq_max_3(int) = NaN;
                cd(KeplerDir)
                continue
            end       
            if abs(frq_3(1)) > 1
                freq_3(int) = frq_3(1);
            else
                freq_3(int) = frq_3(2);
            end
        else
            min_f = num2str(1000*min_f,'%6.12f');
            max_f = num2str(1000*max_f,'%6.12f');         
            nfreq = num2str(1);
            cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                data_sep,' ',ndata,' ',['<inputAct3_',extstr,'.txt'],' ',['>FMFT_of_Act3_',extstr,'.txt']];  
            eval(cmd_Value)
            [frq_3] = textread(['FMFT_of_Act3_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);      
            if numel(frq_3)== 0
                freq_1(int) = NaN;
                freq_min_1(int) = NaN;
                freq_max_1(int) = NaN;
                freq_2(int) = NaN;
                freq_min_2(int) = NaN;
                freq_max_2(int) = NaN;        
                freq_3(int) = NaN;
                freq_min_3(int) = NaN;
                freq_max_3(int) = NaN;
                cd(KeplerDir)
                continue
            end        
            freq_3(int) = frq_3;              
        end
        %-------------- Frequency Modulation Indicator (FMI)---------------
        str_FMFT_pick = num2str(FMFT_pick);
        %----------------------- Freq1 ------------------------------------
        n_step = InitData.step1LGG3;
        if n_step >= 1
        min_f = InitData.min_f1_LGG3;
        max_f = InitData.max_f1_LGG3;
            if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)
                min_f = num2str(1000*min_f,'%6.12f');
                max_f = num2str(1000*max_f,'%6.12f');
                nfreq = num2str(2);
                for rr = 1:n_step + 1
                    cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                        data_sep,' ',str_FMFT_pick,' ','<inputAct1_',num2str(rr),'_',extstr,'.txt',' ','>FMFT_of_Act1_',num2str(rr),'_',extstr,'.txt'];
                    eval(cmd_Value)
                    try
                        [frq] = textread(['FMFT_of_Act1_',num2str(rr),'_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
                    catch
                        warndlg('Some error occurred: the corresponding FMI 1 value will be left blank.')
                        freq = NaN*ones(1,n_step + 1);
                        break
                    end
                    if numel(frq) < 2
                        warndlg('Some error occurred: the corresponding FMI 1 value will be left blank.')
                        freq = NaN*ones(1,n_step + 1);
                        break
                    end                        
                    if abs(frq(1)) > 1
                        freq(rr) = frq(1);
                    else
                        freq(rr) = frq(2);
                    end
                end
            else
                min_f = num2str(1000*min_f,'%6.12f');
                max_f = num2str(1000*max_f,'%6.12f');
                nfreq = num2str(1);
                for rr = 1:n_step + 1
                    cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                        data_sep,' ',str_FMFT_pick,' ','<inputAct1_',num2str(rr),'_',extstr,'.txt',' ','>FMFT_of_Act1_',num2str(rr),'_',extstr,'.txt'];
                    eval(cmd_Value)
                    try
                        frq = textread(['FMFT_of_Act1_',num2str(rr),'_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
                    catch
                        warndlg('Some error occurred: the corresponding FMI 1 value will be left blank.')
                        freq = NaN*ones(1,n_step + 1);
                        break
                    end
                    if numel(frq) == 0
                        warndlg('Some error occurred: the corresponding FMI 1 value will be left blank.')
                        freq = NaN*ones(1,n_step + 1);
                        break
                    end                    
                    freq(rr) = frq;
                end
            end

            freq_min_1(int) = min(freq);
            freq_max_1(int) = max(freq);

            %           Set min FMI1 = -12
            if abs((freq_max_1(int)-freq_min_1(int))/(freq_max_1(int)+freq_min_1(int))) < 1e-12
                freq_min_1(int) = 1;
                freq_max_1(int) = (1+1e-12)/(1-1e-12);
            end
        end
%--------------------- Freq2 -- -------------------------------
        n_step = InitData.step2LGG3;
        if n_step >= 1
        min_f = InitData.min_f2_LGG3;
        max_f = InitData.max_f2_LGG3;     
            if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)
                min_f = num2str(1000*min_f,'%6.12f');
                max_f = num2str(1000*max_f,'%6.12f');
                nfreq = num2str(2);
                for rr = 1:n_step + 1
                    cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                        data_sep,' ',str_FMFT_pick,' ','<inputAct2_',num2str(rr),'_',extstr,'.txt',' ','>FMFT_of_Act2_',num2str(rr),'_',extstr,'.txt'];  
                    eval(cmd_Value)
                    try
                        [frq] = textread(['FMFT_of_Act2_',num2str(rr),'_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
                    catch
                        warndlg('Some error occurred: the corresponding FMI 2 value will be left blank.')
                        freq = NaN*ones(1,n_step + 1);
                        break
                    end
                     if numel(frq) < 2
                        warndlg('Some error occurred: the corresponding FMI 2 value will be left blank.')
                        freq = NaN*ones(1,n_step + 1);
                        break
                    end                                       
                    if abs(frq(1)) > 1
                        freq(rr) = frq(1);
                    else
                        freq(rr) = frq(2);
                    end
                end
            else
                min_f = num2str(1000*min_f,'%6.12f');
                max_f = num2str(1000*max_f,'%6.12f');         
                nfreq = num2str(1);
                for rr = 1:n_step + 1
                    cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                        data_sep,' ',str_FMFT_pick,' ','<inputAct2_',num2str(rr),'_',extstr,'.txt',' ','>FMFT_of_Act2_',num2str(rr),'_',extstr,'.txt'];  
                    eval(cmd_Value) 
                    try
                        frq = textread(['FMFT_of_Act2_',num2str(rr),'_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
                    catch
                        warndlg('Some error occurred: the corresponding FMI 2 value will be left blank.')
                        freq = NaN*ones(1,n_step + 1);
                        break
                    end
                    if numel(frq) == 0
                        warndlg('Some error occurred: the corresponding FMI 2 value will be left blank.')
                        freq = NaN*ones(1,n_step + 1);
                        break
                    end                       
                    freq(rr) = frq;
                end
            end

            freq_min_2(int) = min(freq);
            freq_max_2(int) = max(freq);

%           Set min FMI2 = -12        
            if abs((freq_max_2(int)-freq_min_2(int))/(freq_max_2(int)+freq_min_2(int))) < 1e-12
                freq_min_2(int) = 1;
                freq_max_2(int) = (1+1e-12)/(1-1e-12);
            end          
        end
%--------------------- Freq3 ----------------------------------
        n_step = InitData.step3LGG3;
        if n_step >= 1
        min_f = InitData.min_f3_LGG3;
        max_f = InitData.max_f3_LGG3;       
            if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)
                min_f = num2str(1000*min_f,'%6.12f');
                max_f = num2str(1000*max_f,'%6.12f');
                nfreq = num2str(2);              
                for rr = 1:n_step + 1
                    cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                        data_sep,' ',str_FMFT_pick,' ','<inputAct3_',num2str(rr),'_',extstr,'.txt',' ','>FMFT_of_Act3_',num2str(rr),'_',extstr,'.txt'];  
                    eval(cmd_Value)
                    try
                        [frq] = textread(['FMFT_of_Act3_',num2str(rr),'_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
                    catch
                        warndlg('Some error occurred: the corresponding FMI 3 value will be left blank.')
                        freq = NaN*ones(1,n_step + 1);
                        break
                    end
                    
                    if numel(frq) < 2
                        warndlg('Some error occurred: the corresponding FMI 3 value will be left blank.')
                        freq = NaN*ones(1,n_step + 1);
                        break
                    end                       
                    
                    if abs(frq(1)) > 1
                        freq(rr) = frq(1);
                    else
                        freq(rr) = frq(2);
                    end
                end
            else
                min_f = num2str(1000*min_f,'%6.12f');
                max_f = num2str(1000*max_f,'%6.12f');         
                nfreq = num2str(1);
                for rr = 1:n_step + 1
                    cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                        data_sep,' ',str_FMFT_pick,' ','<inputAct3_',num2str(rr),'_',extstr,'.txt',' ','>FMFT_of_Act3_',num2str(rr),'_',extstr,'.txt'];  
                    eval(cmd_Value) 
                    try
                        frq = textread(['FMFT_of_Act3_',num2str(rr),'_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
                    catch
                        warndlg('Some error occurred: the corresponding FMI 3 value will be left blank.')
                        freq = NaN*ones(1,n_step + 1);
                        break
                    end   
                    if numel(frq) == 0
                        warndlg('Some error occurred: the corresponding FMI 3 value will be left blank.')
                        freq = NaN*ones(1,n_step + 1);
                        break
                    end   
                    freq(rr) = frq;
                end
            end

            freq_min_3(int) = min(freq);
            freq_max_3(int) = max(freq);

%           Set min FMI3 = -12        
            if abs((freq_max_3(int)-freq_min_3(int))/(freq_max_3(int)+freq_min_3(int))) < 1e-12
                freq_min_3(int) = 1;
                freq_max_3(int) = (1+1e-12)/(1-1e-12);
            end
        end
%--------------------- End FMI --------------------------------------------
        cd(KeplerDir)
        clear DiffEquation
    end       
%%%%%%%%%%%%%%%%%%%%%%% Display percentage of row/column %%%%%%%%%%%%%%%%%%
    ccount = ccount + 1;
    View1 = InitData.View1;
    if strcmp(View1, 'on')
        perc = ccount/int_tot*100;
        fprintf('\n\n')
        if row_tot <= col_tot
            if ccount == 1
                lgt = fprintf(['\b\bColumn ',extstr,' computed at %4.2f%%'],perc);
            else
                fprintf(repmat('\b', 1, lgt));
                lgt = fprintf(['Column ',extstr,' computed at %4.2f%%'],perc) + 2;
            end
        else
            if ccount == 1
                lgt = fprintf(['\b\bRow',extstr,' computed at %4.2f%%'],perc);
            else
                fprintf(repmat('\b', 1, lgt));
                lgt = fprintf(['Row ',extstr,' computed at %4.2f%%'],perc) + 2;
            end
        end
    end
end
disp('                                             ')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd ..
fid = fopen('WaitBar.txt','a');
fwrite(fid,'1');
fclose(fid);
fid = fopen('WaitBar.txt','r');
B = fread(fid,'*char');
num = str2num(B);
perc = num2str(sum(num)/ext_tot*100,'%4.2f');
cd(KeplerDir)
list = strread(cd, '%s','delimiter',strrep(filesep,'\','\\'));
dim = size(list);
curdir = list{dim(1,1), dim(1,2)};
%%%%%%%%%%%%%%%%% Display completed row/column %%%%%%%%%%%%%%%%%%%%%%%%%%%%
View2 = InitData.View2;
if strcmp(View2, 'on')
    disp([curdir,': computation completed at ', datestr(now)])
    disp(['|===================== Total progress: ',perc,'% ========================|']);
end

View3 = InitData.View3;
if strcmp(View3, 'on')
    bar = '@';
    while strlength(bar) < floor(0.7*str2num(perc))
        bar = [bar,'@'];
    end
    bar = ['|',bar,'|'];
    fprintf(bar);
    disp('    ')
    disp('------------------------------------------------------------------------')
end

View4 = InitData.View4;
if strcmp(View4, 'on')
    close all
    InitPos = [10 60 380 70];
    Shift_x = [380 0 0 0];
    Shift_y = [0 100 0 0];
    if strcmp('Master', curdir)
        Pos = InitPos + 9*Shift_y;
    elseif strcmp('Slave1', curdir)
        Pos = InitPos + 9*Shift_y + Shift_x;
    elseif strcmp('Slave2', curdir)
        Pos = InitPos + 8*Shift_y;
    elseif strcmp('Slave3', curdir)
        Pos = InitPos + 8*Shift_y + Shift_x;
    elseif strcmp('Slave4', curdir)
        Pos = InitPos + 7*Shift_y;
    elseif strcmp('Slave5', curdir)
        Pos = InitPos + 7*Shift_y + Shift_x;
    elseif strcmp('Slave6', curdir)
        Pos = InitPos + 6*Shift_y;
    elseif strcmp('Slave7', curdir)
        Pos = InitPos + 6*Shift_y + Shift_x;
    elseif strcmp('Slave8', curdir)
        Pos = InitPos + 5*Shift_y;
    elseif strcmp('Slave9', curdir)
        Pos = InitPos + 5*Shift_y + Shift_x;
    elseif strcmp('Slave10', curdir)
        Pos = InitPos + 4*Shift_y;
    elseif strcmp('Slave11', curdir)
        Pos = InitPos + 4*Shift_y + Shift_x;
    elseif strcmp('Slave12', curdir)
        Pos = InitPos + 3*Shift_y;
    elseif strcmp('Slave13', curdir)
        Pos = InitPos + 3*Shift_y + Shift_x;
    elseif strcmp('Slave14', curdir)
        Pos = InitPos + 2*Shift_y;
    elseif strcmp('Slave15', curdir)
        Pos = InitPos + 2*Shift_y + Shift_x;       
    end

    update = [' ',curdir,' - Total progress: ', perc, '% - ','Start: ', begin];
    Progressbar = waitbar(0,'Please wait..., HAMILTON is calculating.',...
        'Units', 'pixel', 'Position', Pos);
    waitbar(sum(num)/ext_tot, Progressbar, update);
end
disp('                                             ')
%%%%%%%%%%%%%%%%%%%%%%%%% Compute FMI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_step = InitData.step1LGG3;
if n_step >= 1
    FMI_1 = log10(abs((freq_max_1 - freq_min_1)./(freq_max_1 + freq_min_1)));
else
    FMI_1 = zeros(1, int_tot);
end

n_step = InitData.step2LGG3;
if n_step >= 1    
    FMI_2 = log10(abs((freq_max_2 - freq_min_2)./(freq_max_2 + freq_min_2)));
else
    FMI_2 = zeros(1, int_tot);
end

n_step = InitData.step3LGG3;
if n_step >= 1     
    FMI_3 = log10(abs((freq_max_3 - freq_min_3)./(freq_max_3 + freq_min_3)));
else
    FMI_3 = zeros(1, int_tot);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------- Generate output of the function ------------------------
Y = [freq_1; freq_2; freq_3; FMI_1; FMI_2; FMI_3];
delete *.txt
%%%%%%%%%%%%%%%%%%%%%%%%% End of the function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    