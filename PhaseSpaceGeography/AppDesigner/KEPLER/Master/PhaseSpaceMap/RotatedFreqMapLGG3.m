%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Avoid visualizing the wrong waitbar
global pick
pick = tau_total;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Begin numerical computation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S_vec_o(1) = str2num(get(app.edit_S01,'Value'));  
S_vec_o(2) = str2num(get(app.edit_S02,'Value'));
S_vec_o(3) = str2num(get(app.edit_S03,'Value'));  % Relative equilibrium
D_vec_o(1) = str2num(get(app.edit_D01,'Value'));  %      position
D_vec_o(2) = str2num(get(app.edit_D02,'Value'));
D_vec_o(3) = str2num(get(app.edit_D03,'Value'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RotS3 = S_vec_o/norma(S_vec_o);
if (S_vec_o(2)^2+S_vec_o(3)^2) == 0
    RotS2 = [0  1  0];
    RotS1 = [0  0 -1];
else
    RotS2 = [0  S_vec_o(3)/sqrt(S_vec_o(2)^2+S_vec_o(3)^2)...
        -S_vec_o(2)/sqrt(S_vec_o(2)^2+S_vec_o(3)^2)];
    RotS1 = vectorp(RotS2, RotS3);
end
RotS = [RotS1' RotS2' RotS3'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RotD3 = D_vec_o/norma(D_vec_o);
if (D_vec_o(2)^2+D_vec_o(3)^2) == 0
    RotD2 = [0  1  0];
    RotD1 = [0  0 -1];
else
    RotD2 = [0  D_vec_o(3)/sqrt(D_vec_o(2)^2+D_vec_o(3)^2)...
        -D_vec_o(2)/sqrt(D_vec_o(2)^2+D_vec_o(3)^2)];
    RotD1 = vectorp(RotD2, RotD3);
end
RotD = [RotD1' RotD2' RotD3'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sm_ax_o = 1;
f_o =   0;
omega_o = str2num(get(app.edit_LGG3_perprime,'Value'));
G_init = str2num(get(app.edit_Init_Gprime,'Value'));
G_final = str2num(get(app.edit_Final_Gprime,'Value'));
row_tot = str2num(get(app.edit_Step_Gprime,'Value')) + 1;
G3_init = str2num(get(app.edit_Init_G3prime,'Value'));
G3_final = str2num(get(app.edit_Final_G3prime,'Value'));
col_tot = str2num(get(app.edit_Step_G3prime,'Value')) + 1;

int_tot = min(row_tot, col_tot);
ext_tot = max(row_tot, col_tot);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            Integrate a single orbit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (row_tot == 1) & (col_tot == 1)

    if (abs(G3_init) > G_init) &...
            (strcmp(get(app.warningbox, 'Checked'),'on'))
        errordlg(['The vertical projection | G3 | cannot be greater than G.  ']);
        return
    end

    sm_ax_o = 1;
    omega_o = str2num(get(app.edit_LGG3_perprime,'Value'));
    f_o =   0;
    G_vec_prime = [0  -sqrt(G_init^2-G3_init^2)  G3_init];
    if G_init == 0
        warndlg(sprintf(['Null angular momentum => inclination undefined.']))
        return
    else
        R_vec_prime = sqrt(sm_ax_o-G_init^2)*[cos(pi/180*omega_o)  sin(pi/180*omega_o)*G3_init/G_init  ...
            sin(pi/180*omega_o)*sqrt(1- G3_init^2/G_init^2)];
    end
    S_vec_prime = 1/2*(G_vec_prime + R_vec_prime);
    D_vec_prime = 1/2*(G_vec_prime - R_vec_prime);
    S_vec = S_vec_prime*RotS';
    D_vec = D_vec_prime*RotD';
    [q_vec_o, p_vec_o] = SD2Cartesian(S_vec, D_vec, f_o);

%-------------------------------------------------------------------------------
    lambd = lambda_tot + 1;
%    clear global lambda
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
 %{       
    if (~isreal(lambd) | isnan(lambd))
        [q_vec_o, p_vec_o] = SD2Cartesian(S_vec_o/2, D_vec_o/2, f_o);
    end
 %}      
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
%    clear global lambda
%---------------------------------------------------------------------
    set(app.q1_value,'Value', num2str(q_vec_o(1),16))
    set(app.q2_value,'Value', num2str(q_vec_o(2),16))
    set(app.q3_value,'Value', num2str(q_vec_o(3),16))
    set(app.p1_value,'Value', num2str(p_vec_o(1),16))
    set(app.p2_value,'Value', num2str(p_vec_o(2),16))
    set(app.p3_value,'Value', num2str(p_vec_o(3),16))
    Cartesian2Keplerian

    set(app.edit_smaxis,'Value', num2str(sm_ax_o,'%5.10f'))
    set(app.edit_Eccentricity,'Value', num2str(Ecc_o,'%5.10f'))
    set(app.edit_AscNode,'Value', num2str(Omega_o,'%5.10f'))
    set(app.edit_ArgPericenter,'Value', num2str(omega_o,'%5.10f'))
    set(app.edit_Inclination,'Value', num2str(incl_o,'%5.10f'))
    set(app.edit_TrueAnomaly,'Value', num2str(f_o,'%5.10f'))

    Disable_General

    set(app.uipanel_Freq3D_LGG3, 'Visible', 'off')
    set(app.uipanelInit, 'Visible', 'on')
    set(app.uipanel_AA_FMFT, 'Visible', 'on')
    set(app.uipanel_RegMethod, 'Visible', 'on')
    set(app.uipanel_StandMethod, 'Visible', 'on')    
    set(app.uipanel_ClearMemory,'Visible', 'on')    
%    set(app.SecondOorderCheckBox,'Value', 0)
    set(app.radiobutton_Delaunay,'Value', 0)
    set(app.radiobutton_Delaunayprime,'Value', 1)
    set(app.radiobutton_Pauli,'Value', 0)
    set(app.radiobutton_Pauliprime,'Value', 0)
    ValuePert = get(app.check_pert_LGG3,'Value');
    ValueNonPert = get(app.check_nonpert_LGG3,'Value');
    set(app.check_pert,'Value', ValuePert)
    set(app.check_nonpert,'Value', ValueNonPert)
    set(app.edit_block,'Visible', 'on')
    set(app.text_block,'Visible', 'on')
    set(app.popupmenu_head,'Value', '1')
%{      
    if strcmp(get(app.LGG3_long_FMFT, 'Checked'),'on') |...
                strcmp(get(app.LSD_long_FMFT, 'Checked'),'on')
        set(app.uipanel_from_to,'Visible', 'off')
        set(app.LongtimeFA,'Visible', 'on')
    else      
        set(app.uipanel_from_to, 'Visible', 'on')
        set(app.LongtimeFA, 'Visible', 'off')
    end
%}    
    Integrate
    return
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Integrate a grid of initial values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display('                                                                 ')
display('###################################################################')
display(['    STARTING COMPUTATION with ',ODE,'!!!'])
disp('    ')
tic
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
    if get(app.check_pert_LGG3,'Value') == 1
        !python ./Python/Symbolic.py
%        eval(['!',app.pythonDir,'/python ',app.PythonDir,'/Symbolic.py'])
    elseif get(app.check_nonpert_LGG3,'Value') == 1
        !python ./Python/SymbolicNonPert.py
%        eval(['!',app.pythonDir,'/python ',app.PythonDir,'/SymbolicNonPert.py'])
    end
else
    if get(app.check_pert_LGG3,'Value') == 1
        Symbolic
        Write2file
        waitfor(exist('DiffEquation'))
    elseif get(app.check_nonpert_LGG3,'Value') == 1
        SymbolicNonPert
        Write2fileNonPert
        waitfor(exist('DiffEquation'))
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if row_tot == 1
    stepG = 0;
else
    stepG = (G_final- G_init)/(row_tot - 1);
end

if col_tot == 1
    stepG3 = 0;
else
    stepG3 = (G3_final - G3_init)/(col_tot - 1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Rel_Tol = get(app.RelTol,'Value');
Abs_Tol = get(app.AbsTol,'Value');
options = odeset('RelTol',[Rel_Tol], 'AbsTol',[Abs_Tol]);            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
begin = datestr(now, 'dd mmm HH:MM');
if ~isnan(findstr(app.KeplerDir, 'Slave'))
    % do nothing
else
        mainbar = waitbar(0,'Please wait..., KEPLER is calculating.');
end
%---------------------- Start multicore -----------------------------------
ParalStructure
parameterCell = cell(1,ext_tot);
subcell = cell(1,12);
for ext = 1:ext_tot
    subcell{1,1} = [ext];
    subcell{1,2} = [stepG];
    subcell{1,3} = [stepG3];
    subcell{1,4} = [RotS];
    subcell{1,5} = [RotD];
    subcell{1,6} = [];
    subcell{1,7} = [options];
    subcell{1,8} = [S_vec_o];
    subcell{1,9} = [D_vec_o];
    subcell{1,10} = [InitData];
    subcell{1,11} = [begin];
    subcell{1,12} = [mainbar];
    parameterCell{1,ext} = {subcell};
end

cd ..
fid = fopen('WaitBar.txt','w');
fwrite(fid,'0');
fclose(fid);
cd(app.KeplerDir)

warning('off')
settings.multicoreDir = '../multicorefiles';
settings.useWaitbar = false;
settings.nrOfEvalsAtOnce = 1;
resultCell = startmulticoremaster(@parfor_LGG3, parameterCell, settings);
warning('on')
%---------------------- End multicore -----------------------------------
freq_1 = [resultCell{1,1}(1,:)];
for k = 2 : ext_tot
    freq_1 = [freq_1; resultCell{1,k}(1,:)];
end
freq_2 = [resultCell{1,1}(2,:)];
for k = 2 : ext_tot
    freq_2 = [freq_2; resultCell{1,k}(2,:)];
end
freq_3 = [resultCell{1,1}(3,:)];
for k = 2 : ext_tot
    freq_3 = [freq_3; resultCell{1,k}(3,:)];
end
FMI_1 = [resultCell{1,1}(4,:)];
for k = 2 : ext_tot
    FMI_1 = [FMI_1; resultCell{1,k}(4,:)];
end
FMI_2 = [resultCell{1,1}(5,:)];
for k = 2 : ext_tot
    FMI_2 = [FMI_2; resultCell{1,k}(5,:)];
end
FMI_3 = [resultCell{1,1}(6,:)];
for k = 2 : ext_tot
    FMI_3 = [FMI_3; resultCell{1,k}(6,:)];
end

if row_tot <= col_tot
    freq_1 = freq_1';
    freq_2 = freq_2';
    freq_3 = freq_3';
    FMI_1 = FMI_1';
    FMI_2 = FMI_2';
    FMI_3 = FMI_3';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Save to file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save UserSaved/freq1.dat freq_1 -ascii
save UserSaved/freq2.dat freq_2 -ascii
save UserSaved/freq3.dat freq_3 -ascii
save UserSaved/FMI1.dat FMI_1 -ascii
save UserSaved/FMI2.dat FMI_2 -ascii
save UserSaved/FMI3.dat FMI_3 -ascii
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
delete *.txt
display('-------------------------------------------------------------------')
display(['            FINISH with ',ODE,'!!!'])
toc
display('###################################################################')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if row_tot > 1
    G_ = G_init : (G_final - G_init)/(row_tot - 1) : G_final;
end
if col_tot > 1
    G_3 = G3_init : (G3_final - G3_init)/(col_tot - 1) : G3_final;
end

G_Value = num2str(G_init,16);
G3_Value = num2str(G3_init,16);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%