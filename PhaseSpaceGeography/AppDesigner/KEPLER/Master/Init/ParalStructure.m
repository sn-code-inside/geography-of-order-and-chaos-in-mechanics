val1  = str2num(get(app.edit_LGG3_perprime,'Value'));
val2  = str2num(get(app.edit_Init_Gprime,'Value'));
val3  = str2num(get(app.edit_Step_Gprime,'Value')) + 1;
val4  = str2num(get(app.edit_Init_G3prime,'Value'));
val5  = str2num(get(app.edit_Step_G3prime,'Value')) + 1;
val6  = str2num(get(app.edit_EnergyLGG3,'Value'));
val7  = str2num(get(app.edit_epsilon1,'Value'));
val8  = str2num(get(app.edit_epsilon2,'Value'));
val9  = str2num(get(app.edit_epsilon3,'Value'));
val10 = str2num(get(app.edit_epsilon4,'Value'));
val11 = str2num(get(app.edit_epsilon5,'Value'));
val12 = [0.5,0.5,0.5,2,2,2,1,1,1,2,-1,-1,-1,3,-2,-3,-0.5,2,-1,-1];
            
            item = str2num(get(app.popupmenuHp1,'Value'));
            Items = get(app.popupmenuHp1,'Items');            
val13 = Items{item};
val14 = degrees(item);

            item = str2num(get(app.popupmenuHp2,'Value'));
            Items = get(app.popupmenuHp2,'Items');            
val15 = Items{item};
val16 = degrees(item);

            item = str2num(get(app.popupmenuHp3,'Value'));
            Items = get(app.popupmenuHp3,'Items');            
val17 = Items{item};
val18 = degrees(item);

            item = str2num(get(app.popupmenuHp4,'Value'));
            Items = get(app.popupmenuHp4,'Items');            
val19 = Items{item};
val20 = degrees(item);

            item = str2num(get(app.popupmenuHp5,'Value'));
            Items = get(app.popupmenuHp5,'Items');            
val21 = Items{item};
val22 = degrees(item);

val23 = app.popupmenuODE.Value;           
val24 = str2num(get(app.total_cycles,'Value'));
val25 = str2num(get(app.edit_from,'Value'));
val26 = str2num(get(app.edit_to,'Value'));
val27 = get(app.check_pert_LGG3,'Value');
val28 = get(app.check_nonpert_LGG3,'Value');
val29 = str2num(get(app.edit_block,'Value'));
val30 = str2num(get(app.step_ODE,'Value'));
val31 = get(app.warningbox, 'Checked');
val32 = str2num(get(app.editGG3_min_Freq1,'Value'));
val33 = str2num(get(app.editGG3_max_Freq1,'Value'));
val34 = str2num(get(app.editGG3_min_Freq2,'Value'));
val35 = str2num(get(app.editGG3_max_Freq2,'Value'));
val36 = str2num(get(app.editGG3_min_Freq3,'Value'));
val37 = str2num(get(app.editGG3_max_Freq3,'Value'));
val38 = str2num(get(app.nstep1LGG3,'Value'));
val39 = str2num(get(app.nstep2LGG3,'Value'));
val40 = str2num(get(app.nstep3LGG3,'Value'));
val41 = get(app.Percentage_of_RowColumn,'Check');
val42 = get(app.RowColumn_Completed,'Check');
val43 = get(app.Total_bars,'Check');
val44 = get(app.Wait_bars,'Check');

UniModGG3(1,1) = str2num(get(app.editGG3_uni_11,'Value'));
UniModGG3(1,2) = str2num(get(app.editGG3_uni_12,'Value'));
UniModGG3(1,3) = str2num(get(app.editGG3_uni_13,'Value'));
UniModGG3(2,1) = str2num(get(app.editGG3_uni_21,'Value'));
UniModGG3(2,2) = str2num(get(app.editGG3_uni_22,'Value'));
UniModGG3(2,3) = str2num(get(app.editGG3_uni_23,'Value'));
UniModGG3(3,1) = str2num(get(app.editGG3_uni_31,'Value'));
UniModGG3(3,2) = str2num(get(app.editGG3_uni_32,'Value'));
UniModGG3(3,3) = str2num(get(app.editGG3_uni_33,'Value'));
val45 = UniModGG3;

val46 = str2num(get(app.edit_3D_init_S,'Value'));
val47 = str2num(get(app.edit_3D_step_S,'Value')) + 1;
val48 = str2num(get(app.edit_3D_init_D,'Value'));
val49 = str2num(get(app.edit_3D_step_D,'Value')) + 1;
val50 =  str2num(get(app.edit_phiR,'Value'));
val51 = -str2num(get(app.edit_phiR,'Value'));
val52 = str2num(get(app.edit_EnergyLSD,'Value'));
val53 = get(app.check_pert_LSD,'Value');
val54 = get(app.check_nonpert_LSD,'Value');

UniModSD(1,1) = str2num(get(app.editSD_uni_11,'Value'));
UniModSD(1,2) = str2num(get(app.editSD_uni_12,'Value'));
UniModSD(1,3) = str2num(get(app.editSD_uni_13,'Value'));
UniModSD(2,1) = str2num(get(app.editSD_uni_21,'Value'));
UniModSD(2,2) = str2num(get(app.editSD_uni_22,'Value'));
UniModSD(2,3) = str2num(get(app.editSD_uni_23,'Value'));
UniModSD(3,1) = str2num(get(app.editSD_uni_31,'Value'));
UniModSD(3,2) = str2num(get(app.editSD_uni_32,'Value'));
UniModSD(3,3) = str2num(get(app.editSD_uni_33,'Value'));
val55 = UniModSD;

val56 = str2num(get(app.nstep1LSD,'Value'));
val57 = str2num(get(app.nstep2LSD,'Value'));
val58 = str2num(get(app.nstep3LSD,'Value'));
val59 = str2num(get(app.editLSD_min_Freq1,'Value'));
val60 = str2num(get(app.editLSD_max_Freq1,'Value'));
val61 = str2num(get(app.editLSD_min_Freq2,'Value'));
val62 = str2num(get(app.editLSD_max_Freq2,'Value'));
val63 = str2num(get(app.editLSD_min_Freq3,'Value'));
val64 = str2num(get(app.editLSD_max_Freq3,'Value'));


InitData = struct('omega_o',val1,'G_init',val2, 'row_tot_LGG3',val3,'G3_init',val4,'col_tot_LGG3',val5,...
                     'E_tot_LGG3',val6,'epsilon1',val7,'epsilon2',val8,'epsilon3',val9,...
                     'epsilon4',val10,'epsilon5',val11,'degrees',val12,'Hp1',val13,...
                     'deg1',val14,'Hp2',val15,'deg2',val16,'Hp3',val17,'deg3',val18,...
                     'Hp4',val19,'deg4',val20,'Hp5',val21,'deg5',val22,'ODE',val23,...
                     'tau_total',val24,'tau_i',val25,'tau_f',val26,'Pert_LGG3',val27,...
                     'NonPert_LGG3',val28,'block',val29,'OutStep',val30,'warningbox',val31,...
                     'min_f1_LGG3',val32,'max_f1_LGG3',val33,'min_f2_LGG3',val34,'max_f2_LGG3',val35,...
                     'min_f3_LGG3',val36,'max_f3_LGG3',val37,'step1LGG3',val38,'step2LGG3',val39,...
                     'step3LGG3',val40,'View1',val41,'View2',val42,'View3',val43,'View4',val44,...
                     'UniModGG3',val45,'init_S',val46,...
                     'row_tot_LSD',val47,'init_D',val48,'col_tot_LSD',val49,...
                     'phiS_o',val50,'phiD_o',val51,'E_tot_LSD',val52, ...
                     'Pert_LSD',val53,'NonPert_LSD',val54,'UniModSD',val55,...
                     'step1LSD',val56,'step2LSD',val57,'step3LSD',val58,'min_f1_LSD',val59,...
                     'max_f1_LSD',val60,'min_f2_LSD',val61,'max_f2_LSD',val62,...
                     'min_f3_LSD',val63,'max_f3_LSD',val64);