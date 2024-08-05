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
omegaprime = 180/pi*atan2(scalarp(vectorp(node, Eccprime_vec), Gprime_vec)./Gprime,...
        scalarp(node, Eccprime_vec));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Action = Gprime;
Angl = omegaprime;
UserFunction(:,1) = Action;
UserFunction(:,2) = Angl;

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
set(app.pushbutton_clearLGG3,'Enable','on')
%%%%%%%%%%%%%%%%%%% End Append %%%%%%%%%%%%%%%%%%%%%%%%%