val0 = get(app.popupmenu_planet,'Items');

val1 = get(app.edit_mass1,'Value');
val2 = get(app.edit_mass2,'Value');
val3 = get(app.edit_mass3,'Value');
val4 = get(app.edit_mass4,'Value');
val5 = get(app.edit_mass5,'Value');
val6 = get(app.edit_mass6,'Value');
val7 = get(app.edit_mass7,'Value');
val8 = get(app.edit_mass8,'Value');
val9 = get(app.edit_mass9,'Value');
val10 = get(app.edit_mass10,'Value');

val11 = get(app.edit_sma1,'Value');
val12 = get(app.edit_sma2,'Value');
val13 = get(app.edit_sma3,'Value');
val14 = get(app.edit_sma4,'Value');
val15 = get(app.edit_sma5,'Value');
val16 = get(app.edit_sma6,'Value');
val17 = get(app.edit_sma7,'Value');
val18 = get(app.edit_sma8,'Value');
val19 = get(app.edit_sma9,'Value');
val20 = get(app.edit_sma10,'Value');

val21 = get(app.edit_ecc1,'Value');
val22 = get(app.edit_ecc2,'Value');
val23 = get(app.edit_ecc3,'Value');
val24 = get(app.edit_ecc4,'Value');
val25 = get(app.edit_ecc5,'Value');
val26 = get(app.edit_ecc6,'Value');
val27 = get(app.edit_ecc7,'Value');
val28 = get(app.edit_ecc8,'Value');
val29 = get(app.edit_ecc9,'Value');
val30 = get(app.edit_ecc10,'Value');

val31 = get(app.edit_incl1,'Value');
val32 = get(app.edit_incl2,'Value');
val33 = get(app.edit_incl3,'Value');
val34 = get(app.edit_incl4,'Value');
val35 = get(app.edit_incl5,'Value');
val36 = get(app.edit_incl6,'Value');
val37 = get(app.edit_incl7,'Value');
val38 = get(app.edit_incl8,'Value');
val39 = get(app.edit_incl9,'Value');
val40 = get(app.edit_incl10,'Value');

val41 = get(app.edit_longmean1,'Value');
val42 = get(app.edit_longmean2,'Value');
val43 = get(app.edit_longmean3,'Value');
val44 = get(app.edit_longmean4,'Value');
val45 = get(app.edit_longmean5,'Value');
val46 = get(app.edit_longmean6,'Value');
val47 = get(app.edit_longmean7,'Value');
val48 = get(app.edit_longmean8,'Value');
val49 = get(app.edit_longmean9,'Value');
val50 = get(app.edit_longmean10,'Value');

val51 = get(app.edit_peri1,'Value');
val52 = get(app.edit_peri2,'Value');
val53 = get(app.edit_peri3,'Value');
val54 = get(app.edit_peri4,'Value');
val55 = get(app.edit_peri5,'Value');
val56 = get(app.edit_peri6,'Value');
val57 = get(app.edit_peri7,'Value');
val58 = get(app.edit_peri8,'Value');
val59 = get(app.edit_peri9,'Value');
val60 = get(app.edit_peri10,'Value');

val61 = get(app.edit_asc1,'Value');
val62 = get(app.edit_asc2,'Value');
val63 = get(app.edit_asc3,'Value');
val64 = get(app.edit_asc4,'Value');
val65 = get(app.edit_asc5,'Value');
val66 = get(app.edit_asc6,'Value');
val67 = get(app.edit_asc7,'Value');
val68 = get(app.edit_asc8,'Value');
val69 = get(app.edit_asc9,'Value');
val70 = get(app.edit_asc10,'Value');

val71 = get(app.edit_integstep,'Value');
val72 = get(app.edit_totint,'Value');
val73 = get(app.edit_outstep,'Value');

Items = get(app.popupmenu_planetFMI_ext,'Items');
item_ext = str2num(get(app.popupmenu_planetFMI_ext,'Value'));
val74 = [Items{item_ext},'.dat'];
val74_1 = item_ext;
val75 = get(app.edit_extfrom,'Value');
val76 = get(app.edit_extto,'Value');
val77 = get(app.edit_extstep,'Value');
val78 = get(app.popupmenu_action_ext,'Value');

Items = get(app.popupmenu_planetFMI_int,'Items');
item_int = str2num(get(app.popupmenu_planetFMI_int,'Value'));
val79 = [Items{item_int},'.dat'];
val79_1 = item_int;
val80 = get(app.edit_intfrom,'Value');
val81 = get(app.edit_intto,'Value');
val82 = get(app.edit_intstep,'Value');
val83 = get(app.popupmenu_action_int,'Value');

val84 = get(app.edit_minfreq1,'Value');
val85 = get(app.edit_maxfreq1,'Value');
val86 = get(app.edit_stepFMI1,'Value');
val87 = get(app.edit_minfreq2,'Value');
val88 = get(app.edit_maxfreq2,'Value');
val89 = get(app.edit_stepFMI2,'Value');
val90 = get(app.edit_minfreq3,'Value');
val91 = get(app.edit_maxfreq3,'Value');
val92 = get(app.edit_stepFMI3,'Value');
val93 = get(app.check1st1,'Value');
val94 = get(app.check1st2,'Value');
val95 = get(app.check1st3,'Value');
val96 = get(app.check2nd1,'Value');
val97 = get(app.check2nd2,'Value');
val98 = get(app.check2nd3,'Value');

val99= get(app.text1,'Visible');
val100= get(app.text2,'Visible');
val101= get(app.text3,'Visible');
val102= get(app.text4,'Visible');
val103= get(app.text5,'Visible');
val104= get(app.text6,'Visible');
val105= get(app.text7,'Visible');
val106= get(app.text8,'Visible');
val107= get(app.text9,'Visible');
val108= get(app.text10,'Visible');

val109 = get(app.Percentage_of_Column, 'Checked');
val110 = get(app.Column_Completed, 'Checked');
val111 = get(app.Total_bars, 'Checked');
val112 = get(app.Wait_bars, 'Checked');

val113 = str2num(get(app.popupmenu_ODE,'Value'));
val114 = get(app.popupmenu_FMFT_flag,'Value');
val115 = get(app.verbose,'Checked');

InitData = struct('planet',val0,'mass1',val1, 'mass2',val2, 'mass3',val3, 'mass4',val4,'mass5',val5, 'mass6',val6, 'mass7',val7, 'mass8',val8,'mass9',val9, 'mass10',val10,...
        'sma1',val11, 'sma2',val12, 'sma3',val13, 'sma4',val14,'sma5',val15, 'sma6',val16, 'sma7',val17, 'sma8',val18,'sma9',val19, 'sma10',val20,...
        'ecc1',val21, 'ecc2',val22, 'ecc3',val23, 'ecc4',val24,'ecc5',val25, 'ecc6',val26, 'ecc7',val27, 'ecc8',val28,'ecc9',val29, 'ecc10',val30,...
        'incl1',val31, 'incl2',val32, 'incl3',val33, 'incl4',val34,'incl5',val35, 'incl6',val36, 'incl7',val37, 'incl8',val38,'incl9',val39, 'incl10',val40,...
        'longmean1',val41, 'longmean2',val42, 'longmean3',val43, 'longmean4',val44,'longmean5',val45, 'longmean6',val46, 'longmean7',val47, 'longmean8',val48,'longmean9',val49, 'longmean10',val50,...
        'peri1',val51, 'peri2',val52, 'peri3',val53, 'peri4',val54,'peri5',val55, 'peri6',val56, 'peri7',val57, 'peri8',val58,'peri9',val59, 'peri10',val60,...
        'asc1',val61, 'asc2',val62, 'asc3',val63, 'asc4',val64,'asc5',val65, 'asc6',val66, 'asc7',val67, 'asc8',val68,'asc9',val69, 'asc10',val70,...
        'integstep',val71,'totint',val72,'outstep',val73,...
        'planetFMI_ext',val74,'item_ext',val74_1,'extfrom',val75,'extto',val76,'extstep',val77, 'action_ext',val78,...
        'planetFMI_int',val79,'item_int',val79_1,'intfrom',val80,'intto',val81,'intstep',val82, 'action_int',val83,...
        'minfreq1',val84,'maxfreq1',val85,'stepFMI1',val86,...
        'minfreq2',val87,'maxfreq2',val88,'stepFMI2',val89,...
        'minfreq3',val90,'maxfreq3',val91,'stepFMI3',val92,...
        'check1st1',val93,'check1st2',val94,'check1st3',val95,'check2nd1',val96,'check2nd2',val97,'check2nd3',val98,...
        'text1',val99, 'text2',val100, 'text3',val101, 'text4',val102, 'text5',val103, 'text6',val104, 'text7',val105, 'text8',val106, 'text9',val107, 'text10',val108,...
        'View1',val109,'View2',val110,'View3',val111,'View4',val112,...
        'itemODE',val113,'flag_FMFT',val114,'Verbose',val115);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%