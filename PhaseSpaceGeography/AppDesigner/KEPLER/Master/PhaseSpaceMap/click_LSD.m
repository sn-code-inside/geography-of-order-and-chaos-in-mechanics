%global app
DS = get(gca,'CurrentPoint');
D3 = DS(2,1)
S3 = DS(2,2)
%{
set(app.edit_3D_init_S,'String', num2str(DS(2,2)))
set(app.edit_3D_init_D,'String', num2str(DS(2,1)))
set(app.edit_3D_step_S,'String', 0)
set(app.edit_3D_step_D,'String', 0)
set(app.edit_3D_final_S,'Enable', 'off')
set(app.edit_3D_final_D,'Enable', 'off')
set(app.pushbutton_FreqLGG3, 'Enable', 'off')
set(app.pushbutton_FreqlevelLGG3, 'Enable', 'off')
set(app.pushbutton_FMILGG3, 'Enable', 'off')
set(app.pushbutton_RatioLGG3, 'Enable', 'off')
set(app.pushbutton_FreqLSD, 'Enable', 'off')
set(app.pushbutton_FreqlevelLSD, 'Enable', 'off')
set(app.pushbutton_FMILSD, 'Enable', 'off')
set(app.pushbutton_RatioLSD, 'Enable', 'off')
%clear app2
%}
