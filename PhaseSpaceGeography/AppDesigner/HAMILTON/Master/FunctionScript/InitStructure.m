        val1 =  get(app.popupHamilton,'Value');
        val2 =  get(app.edit_eps,'Value');
        val3 =  get(app.edit_time,'Value');
        val4 =  get(app.I1_in,'Value');
        val5 =  get(app.I1_fin,'Value');
        val6 =  get(app.step_1,'Value');
        val7 =  get(app.I2_in,'Value');
        val8 =  get(app.I2_fin,'Value');
        val9 =  get(app.step_2,'Value');
        val10 = get(app.I3_o,'Value');
        val11 = get(app.freq1_min,'Value');
        val12 = get(app.freq1_max,'Value');
        val13 = get(app.Step_FMI1,'Value');
        val14 = get(app.freq2_min,'Value');
        val15 = get(app.freq2_max,'Value');
        val16 = get(app.Step_FMI2,'Value');
        val17 = get(app.freq3_min,'Value');
        val18 = get(app.freq3_max,'Value');
        val19 = get(app.Step_FMI3,'Value');
        val20 = get(app.popupmenuODE,'Value');
        val21 = get(app.RelTol,'Value');
        val22 = get(app.AbsTol,'Value');
        val23 = get(app.step_ODE,'Value');
        val24 = get(app.Percentage_of_RowColumn, 'Checked');
        val25 = get(app.RowColumn_Completed, 'Checked');
        val26 = get(app.Total_bars, 'Checked');
        val27 = get(app.Wait_bars, 'Checked');        

        InitStr = struct('Hamiltonian',val1, 'epsilon',val2, 'time',val3,...
            'I1_in',val4, 'I1_fin',val5, 'step_1',val6, 'I2_in',val7, 'I2_fin',val8, 'step_2',val9,...
            'I3_o',val10,...
             'freq1_min',val11, 'freq1_max',val12, 'Step_FMI1',val13,...
             'freq2_min',val14,'freq2_max',val15, 'Step_FMI2',val16,...
             'freq3_min',val17,'freq3_max',val18, 'Step_FMI3',val19,...
              'ODE',val20,'RelTol',val21,'AbsTol',val22,'stepODE',val23,...
              'View1',val24,'View2',val25,'View3',val26,'View4',val27);