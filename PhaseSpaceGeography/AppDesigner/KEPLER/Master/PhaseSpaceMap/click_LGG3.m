%global app
GG3 = get(gca,'CurrentPoint');
G3 = GG3(2,1)
G = GG3(2,2)
%{
%Set LGG3
set(app.edit_Init_Gprime,'Value', num2str(GG3(2,2)))
set(app.edit_Init_G3prime,'String', num2str(GG3(2,1)))
set(app.edit_Step_Gprime,'String', 0)
set(app.edit_Step_G3prime,'String', 0)
set(app.edit_Final_Gprime,'Enable', 'off')
set(app.edit_Final_G3prime,'Enable', 'off')
set(app.pushbutton_FreqLGG3, 'Enable', 'off')
set(app.pushbutton_FreqlevelLGG3, 'Enable', 'off')
set(app.pushbutton_FMILGG3, 'Enable', 'off')
set(app.pushbutton_RatioLGG3, 'Enable', 'off')
set(app.pushbutton_FreqLGG3, 'Enable', 'off')
set(app.pushbutton_FreqlevelLGG3, 'Enable', 'off')
set(app.pushbutton_FMILGG3, 'Enable', 'off')
set(app.pushbutton_RatioLGG3, 'Enable', 'off')
%Set Poincare
set(app.edit_2D_final,'String', num2str(GG3(2,2)))
set(app.edit_2D_G3,'String', num2str(GG3(2,1)))
set(app.edit_2D_init,'Enable', 'off')
set(app.edit_2D_step,'String', 0)
clear global Ang_tot Act_tot
set(app.pushbutton_clear, 'Enable', 'off')
%clear app2
%}
