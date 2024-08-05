        val1 =  get(app.popupMAP,'Value');
        val2 =  get(app.edit_epsilon1,'Value');
        val3 =  get(app.edit_epsilon2,'Value');
        val4 =  get(app.edit_epsilon3,'Value');
        val5 =  get(app.edit_m,'Value');
        val6 =  get(app.x1_in,'Value');
        val7 =  get(app.x1_fin,'Value');
        val8 =  get(app.step_1,'Value');
        val9 =  get(app.x2_in,'Value');
        val10 = get(app.x2_fin,'Value');
        val11 = get(app.step_2,'Value');
        val12 = get(app.freq1_min,'Value');
        val13 = get(app.freq1_max,'Value');
        val14 = get(app.step_FMI1,'Value');
        val15 = get(app.freq2_min,'Value');
        val16 = get(app.freq2_max,'Value');
        val17 = get(app.step_FMI2,'Value');
        val18 = get(app.iteration_number,'Value');
        val19 = get(app.Percentage_of_RowColumn, 'Checked');
        val20 = get(app.RowColumn_Completed, 'Checked');
        val21 = get(app.Total_bars, 'Checked');
        val22 = get(app.Wait_bars, 'Checked'); 

        InitStr = struct('MAP',val1, 'epsilon1',val2, 'epsilon2',val3, 'epsilon3',val4,'m',val5,...
             'x1_in',val6, 'x1_fin',val7, 'step_1',val8, 'x2_in',val9, 'x2_fin',val10, 'step_2',val11,...
             'freq1_min',val12, 'freq1_max',val13, 'Step_FMI1',val14,...
              'freq2_min',val15,'freq2_max',val16, 'Step_FMI2',val17,...
              'iteration',val18,'View1',val19,'View2',val20,'View3',val21,'View4',val22);