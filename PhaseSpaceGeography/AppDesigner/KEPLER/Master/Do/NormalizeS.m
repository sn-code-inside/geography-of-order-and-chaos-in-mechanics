%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S_vec_o(1) = str2num(get(app.edit_S01,'Value'));
S_vec_o(2) = str2num(get(app.edit_S02,'Value'));
S_vec_o(3) = str2num(get(app.edit_S03,'Value'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
normaS = norma(S_vec_o);
SO1 = num2str(S_vec_o(1)/normaS);
SO2 = num2str(S_vec_o(2)/normaS);
SO3 = num2str(S_vec_o(3)/normaS);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(app.edit_S01,'Value', SO1)
set(app.edit_S02,'Value', SO2)
set(app.edit_S03,'Value', SO3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%