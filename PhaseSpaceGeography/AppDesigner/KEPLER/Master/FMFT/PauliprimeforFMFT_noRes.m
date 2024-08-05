%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputL.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = sqrt(sm_ax);       
cos_l_Pauli = (vR(:,3).^2+vR(:,4).^2-uR(:,3).^2-uR(:,4).^2)...    
    ./sqrt((2*uR(:,3).*vR(:,3)+2*uR(:,4).*vR(:,4)).^2+(vR(:,3).^2+vR(:,4).^2-uR(:,3).^2-uR(:,4).^2).^2);   
sin_l_Pauli = (2*uR(:,3).*vR(:,3)+2*uR(:,4).*vR(:,4))...    
    ./sqrt((2*uR(:,3).*vR(:,3)+2*uR(:,4).*vR(:,4)).^2+(vR(:,3).^2+vR(:,4).^2-uR(:,3).^2-uR(:,4).^2).^2);
Lx = L.*cos_l_Pauli;
Ly = L.*sin_l_Pauli;

fid = fopen('FMFT/inputL.txt', 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau'; Lx'; Ly']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputS.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
phiS = atan2(Sprime_vec(:,2), Sprime_vec(:,1));
Sx = Sprime_vec(:,3).*cos(phiS);
Sy = Sprime_vec(:,3).*sin(phiS);
fid = fopen('FMFT/inputS.txt', 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n', [tau'; Sx'; Sy']);       
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputD.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
phiD = atan2(Dprime_vec(:,2), Dprime_vec(:,1));
Dx = Dprime_vec(:,3).*cos(phiD);
Dy = Dprime_vec(:,3).*sin(phiD);
fid = fopen('FMFT/inputD.txt', 'wt');
%fprintf(fid, '%14.10f %14.10f %14.10f\n',...
%            [tau'; (D_vec(:,1))'; (D_vec(:,2))']);
fprintf(fid, '%14.10f %14.10f %14.10f\n', [tau'; Dx'; Dy']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%