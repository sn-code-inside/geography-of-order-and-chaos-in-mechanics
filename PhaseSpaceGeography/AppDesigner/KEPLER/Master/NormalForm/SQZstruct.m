    val1 =  get(app.Zeeman3,'Value');
    val2 =  get(app.Stark1,'Value');
    val3 =  get(app.Stark3,'Value');
    val4 =  get(app.S1,'Text');
    val5 =  get(app.S2,'Text');
    val6 =  get(app.S3,'Text');
    val7 =  get(app.D1,'Text');
    val8 =  get(app.D2,'Text');
    val9 =  get(app.D3,'Text');

    SQZstructure = struct('Zeeman3_str',val1, 'Stark1_str',val2, 'Stark3_str',val3,...
                        'S1_str',val4, 'S2_str',val5, 'S3_str',val6,...
                         'D1_str',val7, 'D2_str',val8, 'D3_str',val9);