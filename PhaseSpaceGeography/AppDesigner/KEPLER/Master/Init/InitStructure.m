    val1 =  get(app.popupmenuHp1,'Value');
    val2 =  get(app.popupmenuHp2,'Value');
    val3 =  get(app.popupmenuHp3,'Value');
    val4 =  get(app.popupmenuHp4,'Value');
    val4b = get(app.popupmenuHp5,'Value');
    val5 =  get(app.edit_epsilon1,'Value');
    val6 =  get(app.edit_epsilon2,'Value');
    val7 =  get(app.edit_epsilon3,'Value');
    val8 =  get(app.edit_epsilon4,'Value');
    val8b = get(app.edit_epsilon5,'Value');
    val9 =  get(app.q1_value,'Value');
    val10 = get(app.q2_value,'Value');
    val11 = get(app.q3_value,'Value');
    val12 = get(app.p1_value,'Value');
    val13 = get(app.p2_value,'Value');
    val14 = get(app.p3_value,'Value');
    val15 = get(app.edit_smaxis,'Value');
    val16 = get(app.edit_Eccentricity,'Value');
    val17 = get(app.edit_AscNode,'Value');
    val18 = get(app.edit_ArgPericenter,'Value');
    val19 = get(app.edit_Inclination,'Value');
    val20 = get(app.edit_TrueAnomaly,'Value');

    val21 = get(app.edit_S01,'Value');
    val22 = get(app.edit_S02,'Value');
    val23 = get(app.edit_S03,'Value');
    val24 = get(app.edit_D01,'Value');
    val25 = get(app.edit_D02,'Value');
    val26 = get(app.edit_D03,'Value');
    val27 = get(app.uipanel_Pauli,'Visible');
%    val28 = get(app.EnableUpdatebuttonCheckBox,'Value');
    val30 = get(app.edit_Energy,'Value');
    
    val31 = get(app.edit_Init_Gprime,'Value');
    val32 = get(app.edit_Final_Gprime,'Value');
    val33 = get(app.edit_Step_Gprime,'Value');
    val34 = get(app.edit_Init_G3prime,'Value');
    val35 = get(app.edit_Final_G3prime,'Value');
    val36 = get(app.edit_Step_G3prime,'Value');
    val37 = get(app.edit_LGG3_perprime,'Value');
    val37a= get(app.nstep1LGG3,'Value');
    val37b= get(app.nstep2LGG3,'Value');
    val37c= get(app.nstep3LGG3,'Value');
 
    val38 = get(app.edit_3D_init_S,'Value');
    val39 = get(app.edit_3D_final_S,'Value');
    val40 = get(app.edit_3D_step_S,'Value');
    val41 = get(app.edit_3D_init_D,'Value');
    val42 = get(app.edit_3D_final_D,'Value');
    val43 = get(app.edit_3D_step_D,'Value');
    val44 = get(app.edit_phiR,'Value');
    val44a= get(app.nstep1LSD,'Value');
    val44b= get(app.nstep2LSD,'Value');
    val44c= get(app.nstep3LSD,'Value');

    val45 = str2num(get(app.popupmenu_head, 'Value'));
    val46 = get(app.total_cycles,'Value');
    val47 = get(app.popupmenuODE,'Value');
    val48 = get(app.RelTol,'Value');
    val49 = get(app.AbsTol,'Value');
    val51 = get(app.step_ODE,'Value');
    val54 = get(app.edit_block,'Value');

    val55 = get(app.check_pert,'Value');
    val56 = get(app.check_nonpert,'Value');
    val57 = get(app.check_2D_pert,'Value');
    val58 = get(app.check_2D_nonpert,'Value');
    val59 = get(app.check_pert_LGG3,'Value');
    val60 = get(app.check_nonpert_LGG3,'Value');
    val61 = get(app.check_pert_LSD,'Value');
    val62 = get(app.check_nonpert_LSD,'Value');

    val63 = get(app.Percentage_of_RowColumn, 'Checked');
    val64 = get(app.RowColumn_Completed, 'Checked');
    val65 = get(app.Total_bars, 'Checked');
    val66 = get(app.Wait_bars, 'Checked');    


    InitStr = struct('Hp1',val1, 'Hp2',val2, 'Hp3',val3, 'Hp4',val4, 'Hp5',val4b,...
            'epsilon1',val5, 'epsilon2',val6, 'epsilon3',val7, 'epsilon4',val8, 'epsilon5',val8b,...
            'q1',val9, 'q2',val10, 'q3',val11,...
            'p1',val12, 'p2',val13, 'p3',val14,...
            'sm',val15, 'ecc',val16, 'Omega',val17,...
            'omega',val18, 'incl',val19, 'f',val20,...
            'SO1',val21, 'SO2',val22, 'SO3',val23,...
            'DO1',val24, 'DO2',val25, 'DO3',val26,...
            'Visible',val27, 'TotE',val30,...
            'G_init',val31,'G_final',val32,'row_tot',val33,...
            'G3_init',val34,'G3_final',val35,'col_tot',val36,'omega_o',val37,...
            'step1LGG3',val37a,'step2LGG3',val37b,'step3LGG3',val37c,...
            'S_init',val38,'S_final',val39,'row_tot_SD',val40,...
            'D_init',val41,'D_final',val42,'col_tot_SD',val43,'phiR',val44,...
            'step1LSD',val44a,'step2LSD',val44b,'step3LSD',val44c,...
            'Head',val45,'cycls',val46,'ODE',val47,...
            'RelTol',val48,'AbsTol',val49,'StepSize',val51,'block',val54,...
            'checkpert',val55,'checknonpert',val56,'checkpert2D',val57,'checknonpert2D',val58,...
            'checkpertLGG3',val59,'checknonpertLGG3',val60,'checkpertLSD',val61,'checknonpertLSD',val62,...
            'View1',val63,'View2',val64,'View3',val65,'View4',val66);
            
            