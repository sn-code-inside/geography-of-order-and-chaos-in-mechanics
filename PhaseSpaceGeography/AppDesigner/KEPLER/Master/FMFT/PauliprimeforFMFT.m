%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = sqrt(sm_ax);       
l_Pauliprime = atan2(2*uR(:,3).*vR(:,3)+2*uR(:,4).*vR(:,4), vR(:,3).^2+vR(:,4).^2-uR(:,3).^2-uR(:,4).^2);
phiS = atan2(Sprime_vec(:,2), Sprime_vec(:,1));
phiD = atan2(Dprime_vec(:,2), Dprime_vec(:,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ParalStructure
UniModSD = InitData.UniModSD;
if det(UniModSD) ~= 1
    errordlg('The matrix must be unimodular, i.e., det = 1 with integer enties.','Error');
    return
end

OldAngl = [l_Pauliprime phiS phiD];
OldAct = [L Sprime_vec(:,3) Dprime_vec(:,3)];
Angl = OldAngl*UniModSD';
Act = OldAct*inv(UniModSD);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%