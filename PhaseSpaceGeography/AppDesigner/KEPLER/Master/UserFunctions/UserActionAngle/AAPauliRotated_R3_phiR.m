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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Action = Sprime_vec(:,3) - Dprime_vec(:,3);
Angl = 180/pi*atan2(Sprime_vec(:,2), Sprime_vec(:,1))...
           - 180/pi*atan2(Dprime_vec(:,2), Dprime_vec(:,1));
UserFunction(:,1) = Action;
UserFunction(:,2) = Angl;

%%%%%%%%%%%%%%%%%%%%%%%%% Append %%%%%%%%%%%%%%%%%%%%%%% 
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
mn = min(min(Act_tot));
mx = max(max(Act_tot));
mmn = mn - 0.05*(mx - mn);
mmx = mx + 0.05*(mx - mn);
axis([-180  180  mmn  mmx]);
set(app.pushbutton_clearLSD,'Enable','on')
if strcmp(get(app.no_degree, 'Checked'),'off')
    Degree_x
end
title({'Action vs angle (deg) - Append'})
%%%%%%%%%%%%%%%%%%%%%%%% End Append %%%%%%%%%%%%%%%%%%%