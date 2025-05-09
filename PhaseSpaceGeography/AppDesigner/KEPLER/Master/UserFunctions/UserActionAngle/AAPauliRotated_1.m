%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M(1,1) = str2num(get(app.editSD_uni_11,'Value'));
M(1,2) = str2num(get(app.editSD_uni_12,'Value'));
M(1,3) = str2num(get(app.editSD_uni_13,'Value'));
M(2,1) = str2num(get(app.editSD_uni_21,'Value'));
M(2,2) = str2num(get(app.editSD_uni_22,'Value'));
M(2,3) = str2num(get(app.editSD_uni_23,'Value'));
M(3,1) = str2num(get(app.editSD_uni_31,'Value'));
M(3,2) = str2num(get(app.editSD_uni_32,'Value'));
M(3,3) = str2num(get(app.editSD_uni_33,'Value'));
detM = M(1,1)*(M(2,2)*M(3,3) - M(2,3)*M(3,2))...
         - M(1,2)*(M(2,1)*M(3,3) - M(2,3)*M(3,1))...
             + M(1,3)*(M(2,1)*M(3,2) -M(2,2)*M(3,1));
if detM ~= 1
    errordlg('The matrix must be unimodular, i.e., det = 1 with integer enties.','Error');
    return
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tau_total = str2num(get(app.total_cycles,'Value'));
tau_i = str2num(get(app.edit_from,'Value'));
tau_f = str2num(get(app.edit_to,'Value'));

if get(app.check_pert,'Value') == 1
    Calculate_Trajectories
elseif get(app.check_nonpert,'Value') == 1
    Calculate_TrajectoriesNonPert
end     

%%%%%%%%%%%%%%%%%%%%%
qp2SD
SD2SpDp
%%%%%%%%%%%%%%%%%%%%%
qp2uv  
%%%%%%%%%%%%%%%%%%%%%  
SoDo2uRvR
%%%%%%%%%%%%%%%%%%%%%
Gprime_vec = Sprime_vec + Dprime_vec;
Rprime_vec = Sprime_vec - Dprime_vec;
Gprime = norma(Gprime_vec);
Eccprime_vec = Rprime_vec./[L L L];
G3prime = Gprime_vec(:,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G_prj = sqrt(Gprime_vec(:,1).^2+Gprime_vec(:,2).^2);
sz = size(G_prj);
if all(G_prj)
    node = [-Gprime_vec(:,2)./G_prj  Gprime_vec(:,1)./G_prj  zeros(sz)];           
else
    if any(G_prj)
        node = zeros(sz(1),3);
        node(1,:) = [1  0  0];
        for jsz = 1 : sz(1)
            if G_prj(jsz) == 0
                if jsz == 1
                else
                    node(jsz,:) = node(jsz-1,:);
                end
            else
                node(jsz,:) = [-Gprime_vec(jsz,2)/G_prj(jsz)  Gprime_vec(jsz,1)/G_prj(jsz)  0 ];
            end
        end
    else
        node = [ones(sz)  zeros(sz)  zeros(sz)];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
l_Pauliprime = 180/pi*atan2(2*uR(:,3).*vR(:,3)+2*uR(:,4).*vR(:,4), vR(:,3).^2+vR(:,4).^2-uR(:,3).^2-uR(:,4).^2);
phiSprime = 180/pi*atan2(Sprime_vec(:,2), Sprime_vec(:,1));
phiDprime = 180/pi*atan2(Dprime_vec(:,2), Dprime_vec(:,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
phi = M*[l_Pauliprime'+180;  phiSprime'+180;  phiDprime'+180];
Action = inv(M')*[L';  Sprime_vec(:,3)';  Dprime_vec(:,3)'];
Action = (Action(1,:))';
Angle = (phi(1,:))';
Angl = Angle - 360*floor(Angle/360) - 180;
UserFunction(:,1) = Angl;
UserFunction(:,2) = Action;

%%%%%%%%%%%%%%%%%%%%% Append %%%%%%%%%%%%%%%%%%%%%%%%%%% 
global Ang_tot Act_tot
Ang_tot = [Ang_tot  Angl];
Act_tot = [Act_tot  Action];
figure
if strcmp(get(app.LargeMS, 'Checked'),'on')
    MarkSize = 6;
else
    MarkSize = 4;
end
plot(Ang_tot(:), Act_tot(:), '.k','MarkerSize',MarkSize)
title({'Action vs angle (deg) - Append'})
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_x
end
set(app.pushbutton_clearLSD,'Enable','on')
%%%%%%%%%%%%%%%%%%% End Append %%%%%%%%%%%%%%%%%%%%%%%%%