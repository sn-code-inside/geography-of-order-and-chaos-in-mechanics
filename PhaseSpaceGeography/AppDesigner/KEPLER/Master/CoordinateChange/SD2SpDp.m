%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S_vec_o(1) = str2num(get(app.edit_S01,'Value'));
S_vec_o(2) = str2num(get(app.edit_S02,'Value'));
S_vec_o(3) = str2num(get(app.edit_S03,'Value'));
D_vec_o(1) = str2num(get(app.edit_D01,'Value'));
D_vec_o(2) = str2num(get(app.edit_D02,'Value'));
D_vec_o(3) = str2num(get(app.edit_D03,'Value'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RotS3 = S_vec_o/norma(S_vec_o);
if (S_vec_o(2)^2+S_vec_o(3)^2) == 0
    RotS2 = [0  1  0];
    RotS1 = [0  0  -1];
else
    RotS2 = [0  S_vec_o(3)/sqrt(S_vec_o(2)^2+S_vec_o(3)^2)...
                  -S_vec_o(2)/sqrt(S_vec_o(2)^2+S_vec_o(3)^2)];
    RotS1 = vectorp(RotS2, RotS3);
end
RotS = [RotS1' RotS2' RotS3'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RotD3 = D_vec_o/norma(D_vec_o);
if (D_vec_o(2)^2+D_vec_o(3)^2) == 0
    RotD2 = [0  1  0];
    RotD1 = [0  0  -1];
else
    RotD2 = [0  D_vec_o(3)/sqrt(D_vec_o(2)^2+D_vec_o(3)^2)...
                  -D_vec_o(2)/sqrt(D_vec_o(2)^2+D_vec_o(3)^2)];
    RotD1 = vectorp(RotD2, RotD3);
end
RotD = [RotD1' RotD2' RotD3'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sprime_vec = S_vec*RotS;
Dprime_vec = D_vec*RotD;
%clear RotS RotD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%