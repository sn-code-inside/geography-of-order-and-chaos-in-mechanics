        val1 =  get(app.popupmenu_Eql,'Value');
        val2 =  get(app.edit_mass,'Value');
        val3 =  get(app.edit_time,'Value');
        val4 =  get(app.q1_o,'Value');
        val5 =  get(app.q2_o,'Value');
        val6 =  get(app.q3_o,'Value');
        val7 =  get(app.p1_o,'Value');
        val8 =  get(app.p2_o,'Value');
        val9 =  get(app.p3_o,'Value');        
        val10 = get(app.popupmenuODE,'Value');
        val11 = get(app.RelTol,'Value');
        val12 = get(app.AbsTol,'Value');
        val13 = get(app.step_ODE,'Value');
        val14 = get(app.I1_in,'Value');
        val15 = get(app.I1_fin,'Value');
        val16 = get(app.step_1,'Value');
        val17 = get(app.I2_in,'Value');
        val18 = get(app.I2_fin,'Value');
        val19 = get(app.step_2,'Value');
        val20 = get(app.I3_o,'Value');
        val21 = get(app.freq1_min,'Value');
        val22 = get(app.freq1_max,'Value');
        val23 = get(app.Step_FMI1,'Value');
        val24 = get(app.freq2_min,'Value');
        val25 = get(app.freq2_max,'Value');
        val26 = get(app.Step_FMI2,'Value');
        val27 = get(app.freq3_min,'Value');
        val28 = get(app.freq3_max,'Value');
        val29 = get(app.Step_FMI3,'Value');       
        val30 = get(app.Percentage_of_RowColumn, 'Checked');
        val31 = get(app.RowColumn_Completed, 'Checked');
        val32 = get(app.Total_bars, 'Checked');
        val33 = get(app.Wait_bars, 'Checked');
        val34 = get(app.uipanel_FMI,'Visible');

        InitStr = struct('Eql',val1, 'mass',val2, 'time',val3,...
            'q1_o',val4, 'q2_o',val5, 'q3_o',val6, 'p1_o',val7, 'p2_o',val8, 'p3_o',val9,...
            'ODE',val10,'RelTol',val11,'AbsTol',val12,'stepODE',val13,...
            'I1_in',val14,'I1_fin',val15,'step_1',val16,'I2_in',val17,'I2_fin',val18,'step_2',val19,...            
            'I3_o',val20,...
            'freq1_min',val21, 'freq1_max',val22, 'Step_FMI1',val23,...
            'freq2_min',val24,'freq2_max',val25, 'Step_FMI2',val26,...
            'freq3_min',val27,'freq3_max',val28, 'Step_FMI3',val29,...
            'View1',val30,'View2',val31,'View3',val32,'View4',val33,'Visible',val34);