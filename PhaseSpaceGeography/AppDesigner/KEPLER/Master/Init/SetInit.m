set(app.popupmenuHp1,'Value', Hp1)
set(app.popupmenuHp2,'Value', Hp2)
set(app.popupmenuHp3,'Value', Hp3)
set(app.popupmenuHp4,'Value', Hp4)
set(app.popupmenuHp5,'Value', Hp5)
set(app.edit_epsilon1,'Value', epsilon1)
set(app.edit_epsilon2,'Value', epsilon2)
set(app.edit_epsilon3,'Value', epsilon3)
set(app.edit_epsilon4,'Value', epsilon4)
set(app.edit_epsilon5,'Value', epsilon5)
set(app.q1_value,'Value', q1)
set(app.q2_value,'Value', q2)
set(app.q3_value,'Value', q3)
set(app.p1_value,'Value', p1)
set(app.p2_value,'Value', p2)
set(app.p3_value,'Value', p3)
set(app.edit_smaxis,'Value', sm)
set(app.edit_Eccentricity,'Value', ecc)
set(app.edit_AscNode,'Value', Omega)
set(app.edit_ArgPericenter,'Value', omega)
set(app.edit_Inclination,'Value', incl)
set(app.edit_TrueAnomaly,'Value', f)

set(app.popupmenuODE,'Value', ODE)
set(app.RelTol,'Value',RelTol);
set(app.AbsTol,'Value',AbsTol);
set(app.step_ODE,'Value',StepSize);
if isempty(get(app.step_ODE,'Value'))
    set(app.edit_block,'Visible', 'off')
    set(app.text_block,'Visible', 'off')
else
    set(app.edit_block,'Visible', 'on')
    set(app.text_block,'Visible', 'on')
end
set(app.edit_S01,'Value', SO1)
set(app.edit_S02,'Value', SO2)
set(app.edit_S03,'Value', SO3)
set(app.edit_D01,'Value', DO1)
set(app.edit_D02,'Value', DO2)
set(app.edit_D03,'Value', DO3)
set(app.uipanel_Pauli,'Visible', Visible)
if strcmp(get(app.uipanel_Pauli, 'Visible'),'on') == 1
    set(app.radiobutton_Delaunayprime, 'Enable', 'on')
    set(app.radiobutton_Pauliprime, 'Enable', 'on')
end
%    set(app.EnableUpdatebuttonCheckBox,'Value', yes)
set(app.edit_Energy,'Value', TotE)
set(app.edit_EnergyPoincare,'Value', TotE)
set(app.edit_EnergyLGG3,'Value', TotE)
set(app.edit_EnergyLSD,'Value', TotE)

set(app.edit_Init_Gprime,'Value',G_init);
set(app.edit_Final_Gprime,'Value',G_final);
set(app.edit_Step_Gprime,'Value',row_tot);
set(app.edit_Init_G3prime,'Value',G3_init);
set(app.edit_Final_G3prime,'Value',G3_final);
set(app.edit_Step_G3prime,'Value',col_tot);
set(app.edit_LGG3_perprime,'Value',omega_o);
set(app.nstep1LGG3,'Value',step1LGG3);
set(app.nstep2LGG3,'Value',step2LGG3);
set(app.nstep3LGG3,'Value',step3LGG3);  

set(app.edit_3D_init_S,'Value',S_init);
set(app.edit_3D_final_S,'Value',S_final);
set(app.edit_3D_step_S,'Value',row_tot_SD);
set(app.edit_3D_init_D,'Value',D_init);
set(app.edit_3D_final_D,'Value',D_final);
set(app.edit_3D_step_D,'Value',col_tot_SD);
set(app.edit_phiR,'Value',phiR);
set(app.nstep1LSD,'Value',step1LSD);
set(app.nstep2LSD,'Value',step2LSD);
set(app.nstep3LSD,'Value',step3LSD);  

set(app.total_cycles,'Value',cycls);
set(app.edit_from,'Value','0');
set(app.edit_to,'Value',cycls);

if strcmp(get(app.edit_Step_Gprime,'Value'),'0');
    set(app.edit_Final_Gprime,'Enable','off');
    set(app.leqGLleqLabel_2,'Text','$=G/L$');
else
    set(app.edit_Final_Gprime,'Enable','on');
    set(app.leqGLleqLabel_2,'Text','$\leq G/L  \leq$')
end

if strcmp(get(app.edit_Step_G3prime,'Value'),'0');
    set(app.edit_Final_G3prime,'Enable','off');
    set(app.leqG_3LleqLabel,'Text','$=G_3/L$');
else
    set(app.edit_Final_G3prime,'Enable','on');
    set(app.leqG_3LleqLabel,'Text','$\leq G_3/L  \leq$')
end

if strcmp(get(app.edit_3D_step_S,'Value'),'0');
    set(app.edit_3D_final_S,'Enable','off');
    set(app.leq2S_3LleqLabel,'Text','$=2S_3/L$');
else
    set(app.edit_3D_final_S,'Enable','on');
    set(app.leq2S_3LleqLabel,'Text','$\leq 2S_3/L \leq$');
end

if strcmp(get(app.edit_3D_step_D,'Value'),'0');
    set(app.edit_3D_final_D,'Enable','off');
    set(app.leq2D_3LleqLabel,'Text','$=2D_3/L$');
else
    set(app.edit_3D_final_D,'Enable','on');
    set(app.leq2D_3LleqLabel,'Text','$\leq 2D_3/L \leq$');
end


set(app.check_pert,'Value',checkpert);
set(app.check_nonpert,'Value',checknonpert);
set(app.check_2D_pert,'Value',checkpert2D);
set(app.check_2D_nonpert,'Value',checknonpert2D);
set(app.check_pert_LGG3,'Value',checkpertLGG3);
set(app.check_nonpert_LGG3,'Value',checknonpertLGG3);
set(app.check_pert_LSD,'Value',checkpertLSD);
set(app.check_nonpert_LSD,'Value',checknonpertLSD);

set(app.Percentage_of_RowColumn, 'Checked',View1);
set(app.RowColumn_Completed, 'Checked',View2);
set(app.Total_bars, 'Checked',View3);
set(app.Wait_bars, 'Checked',View4);

if strcmp(get(app.popupmenuODE,'Value'),'RungeKutta4') | strcmp(get(app.popupmenuODE,'Value'),'RungeKutta5')
    set(app.RelTol, 'Enable', 'off')
    set(app.AbsTol, 'Enable', 'off')
    set(app.edit_block, 'Enable', 'off')
    if get(app.step_ODE,'Value');
        % do nothing
    else
        warndlg('The Output Step must for Runge-Kutta be strictly positive. Default value = 0.01.')
        set(app.step_ODE,'Value','0.01');
    end
else
    set(app.RelTol, 'Enable', 'on')
    set(app.AbsTol, 'Enable', 'on')
    set(app.edit_block, 'Enable', 'on')
end

if strcmp(get(app.popupmenuODE,'Value'),'ShampineGordon')
    set(app.AbsTol,'Value', 1e-07);
else
    set(app.AbsTol,'Value', 1e-14);
end
