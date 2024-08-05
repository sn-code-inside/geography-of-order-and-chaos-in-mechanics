Planets = {'Mercury', 'Venus', 'Earth-Moon', 'Mars', 'Asteroid',...
                 'Jupiter', 'Saturn', 'Uranus', 'Neptune', 'Pluto'};
mass = eval(['get(app.edit_mass',k_str,', ''Value'');']);
if mass
    list = get(app.popupmenu_planet,'Items');
    eval(['list(',k_str,') = Planets(',k_str,');']);
    set(app.popupmenu_planet,'Items',list);
    set(app.popupmenu_planetFMI_ext,'Items',list);
    set(app.popupmenu_planetFMI_int,'Items',list);
    for rr = 1:9
        rr = num2str(rr);
        P_rr = ['set(app.popupmenu_P', rr, ',''Items'',list)'];
        eval(P_rr)
    end
    eval(['set(app.text',k_str,', ''Visible''',',','''on''',');']);
else
    list = get(app.popupmenu_planet,'Items');
    eval(['list(',k_str,') = {''Absent''};']);
    set(app.popupmenu_planet,'Items',list);
    set(app.popupmenu_planetFMI_ext,'Items',list);
    set(app.popupmenu_planetFMI_int,'Items',list);
    for rr = 1:9
        rr = num2str(rr);
        P_rr = ['set(app.popupmenu_P', rr, ',''Items'',list)'];
        eval(P_rr)
    end
    eval(['set(app.text',k_str,', ''Visible''',',','''off''',');']);
end 
