%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D_vec_o(1) = str2num(get(app.edit_D01,'Value'));
D_vec_o(2) = str2num(get(app.edit_D02,'Value'));
D_vec_o(3) = str2num(get(app.edit_D03,'Value'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
normaD = norma(D_vec_o);
DO1 = num2str(D_vec_o(1)/normaD);
DO2 = num2str(D_vec_o(2)/normaD);
DO3 = num2str(D_vec_o(3)/normaD);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(app.edit_D01,'Value', DO1)
set(app.edit_D02,'Value', DO2)
set(app.edit_D03,'Value', DO3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%