%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Venus - Jupiter  (Hring 1) %%%%%%%%%%%%%%%%%%%%%%%%%%
m1 = 2.45e-6;                                  % Venus mass
m2 = str2num(get(handles.edit_m2,'String'));   % Jupiter mass
a1 = 0.723;                                    % Venus semimajor axis 
a2 = str2num(get(handles.edit_a2,'String'));   % Jupiter semimajor axis
E1 = 0;                                        % Venus-ring eccentricity
E2 = str2num(get(handles.edit_E2,'String'));   % Jupiter eccentricity

sigma0 = m0/(m0 + m1);  sigma1 = m1/(m0 + m1);
M1 = m0 + m1; M2 = m0 + m1 + m2;
mu1 = m0*m1/(m0 + m1); mu2 = M1*m2/(M1 + m2);
k1 = mu1*M1; k2 = mu2*M2;
L1 = sqrt(mu1*a1*k1);
L2 = sqrt(mu2*a2*k2);

G1 = L1; 
G2 = (Gtot + XI1)/2;
e1 = 0;
e2 = sqrt(abs(1 - G2.^2/L2^2));
Eps2 = G2/L2;
XI3 = 0;
H2_H10
Hring = H2;
for k = 3 : series_anal
    ks = num2str(k);
    Hring = eval(['Hring + H',ks,';']);
end
Hring1 = m1*m2*Hring;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Earth - Jupiter (Hring 2) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m1 = 3e-6;                                     % Earth mass
m2 = str2num(get(handles.edit_m2,'String'));   % Jupiter mass
a1 = 1.0;                                      % Earth semimajor axis 
a2 = str2num(get(handles.edit_a2,'String'));   % Jupiter semimajor axis
E1 = 0;                                        % Earth-ring eccentricity
E2 = str2num(get(handles.edit_E2,'String'));   % Jupiter eccentricity

sigma0 = m0/(m0 + m1);  sigma1 = m1/(m0 + m1);
M1 = m0 + m1; M2 = m0 + m1 + m2;
mu1 = m0*m1/(m0 + m1); mu2 = M1*m2/(M1 + m2);
k1 = mu1*M1; k2 = mu2*M2;
L1 = sqrt(mu1*a1*k1);
L2 = sqrt(mu2*a2*k2);

G1 = L1; 
G2 = (Gtot + XI1)/2;
e1 = 0;
e2 = sqrt(abs(1 - G2.^2/L2^2));
Eps2 = G2/L2;
XI3 = 0;
H2_H10
Hring = H2;
for k = 3 : series_anal
    ks = num2str(k);
    Hring = eval(['Hring + H',ks,';']);
end
Hring2 = m1*m2*Hring;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Mars - Jupiter (Hring 3) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m1 = 3.2e-7;                                   % Mars mass
m2 = str2num(get(handles.edit_m2,'String'));   % Jupiter mass
a1 = 1.52;                                     % Mars semimajor axis 
a2 = str2num(get(handles.edit_a2,'String'));   % Jupiter semimajor axis
E1 = 0;                                        % Mars-ring eccentricity
E2 = str2num(get(handles.edit_E2,'String'));   % Jupiter eccentricity

sigma0 = m0/(m0 + m1);  sigma1 = m1/(m0 + m1);
M1 = m0 + m1; M2 = m0 + m1 + m2;
mu1 = m0*m1/(m0 + m1); mu2 = M1*m2/(M1 + m2);
k1 = mu1*M1; k2 = mu2*M2;
L1 = sqrt(mu1*a1*k1);
L2 = sqrt(mu2*a2*k2);

G1 = L1; 
G2 = (Gtot + XI1)/2;
e1 = 0;
e2 = sqrt(abs(1 - G2.^2/L2^2));
Eps2 = G2/L2;
XI3 = 0;
H2_H10
Hring = H2;
for k = 3 : series_anal
    ks = num2str(k);
    Hring = eval(['Hring + H',ks,';']);
end
Hring3 = m1*m2*Hring;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Saturn - Jupiter (Hring 4) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m1 = str2num(get(handles.edit_m2,'String'));   % Jupiter mass
m2 = 3e-4;                                     % Saturn mass
a1 = str2num(get(handles.edit_a2,'String'));   % Jupiter semimajor axis 
a2 = 9.53;                                     % Saturn semimajor axis
E1 = str2num(get(handles.edit_E2,'String'));   % Jupiter eccentricity
E2 = 0;                                        % Saturn-ring eccentricity

sigma0 = m0/(m0 + m1);  sigma1 = m1/(m0 + m1);
M1 = m0 + m1; M2 = m0 + m1 + m2;
mu1 = m0*m1/(m0 + m1); mu2 = M1*m2/(M1 + m2);
k1 = mu1*M1; k2 = mu2*M2;
L1 = sqrt(mu1*a1*k1);
L2 = sqrt(mu2*a2*k2);

G1 = (Gtot + XI1)/2;
G2 = L2;
e1 = sqrt(abs(1 - G1.^2/L1^2));
e2 = 0;
Eps2 = 1;
XI3 = 0;
H2_H10
Hring = H2;
for k = 3 : series_anal
    ks = num2str(k);
    Hring = eval(['Hring + H',ks,';']);
end
Hring4 = m1*m2*Hring;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Uranus - Jupiter (Hring 5) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m1 = str2num(get(handles.edit_m2,'String'));   % Jupiter mass
m2 = 4.4e-5;                                   % Uranus mass
a1 = str2num(get(handles.edit_a2,'String'));   % Jupiter semimajor axis 
a2 = 19.2;                                     % Uranus semimajor axis
E1 = str2num(get(handles.edit_E2,'String'));   % Jupiter eccentricity
E2 = 0;                                        % Uranus-ring eccentricity

sigma0 = m0/(m0 + m1);  sigma1 = m1/(m0 + m1);
M1 = m0 + m1; M2 = m0 + m1 + m2;
mu1 = m0*m1/(m0 + m1); mu2 = M1*m2/(M1 + m2);
k1 = mu1*M1; k2 = mu2*M2;
L1 = sqrt(mu1*a1*k1);
L2 = sqrt(mu2*a2*k2);

G1 = (Gtot + XI1)/2;
G2 = L2;
e1 = sqrt(abs(1 - G1.^2/L1^2));
e2 = 0;
Eps2 = 1;
XI3 = 0;
H2_H10
Hring = H2;
for k = 3 : series_anal
    ks = num2str(k);
    Hring = eval(['Hring + H',ks,';']);
end
Hring5 = m1*m2*Hring;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Neptune - Jupiter (Hring 6) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m1 = str2num(get(handles.edit_m2,'String'));   % Jupiter mass
m2 = 5.2e-5;                                   % Neptune mass
a1 = str2num(get(handles.edit_a2,'String'));   % Jupiter semimajor axis 
a2 = 30.08;                                    % Neptune semimajor axis
E1 = str2num(get(handles.edit_E2,'String'));   % Jupiter eccentricity
E2 = 0;                                        % Neptune-ring eccentricity

sigma0 = m0/(m0 + m1);  sigma1 = m1/(m0 + m1);
M1 = m0 + m1; M2 = m0 + m1 + m2;
mu1 = m0*m1/(m0 + m1); mu2 = M1*m2/(M1 + m2);
k1 = mu1*M1; k2 = mu2*M2;
L1 = sqrt(mu1*a1*k1);
L2 = sqrt(mu2*a2*k2);

G1 = (Gtot + XI1)/2;
G2 = L2;
e1 = sqrt(abs(1 - G1.^2/L1^2));
e2 = 0;
Eps2 = 1;
XI3 = 0;
H2_H10
Hring = H2;
for k = 3 : series_anal
    ks = num2str(k);
    Hring = eval(['Hring + H',ks,';']);
end
Hring6 = m1*m2*Hring;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Venus - Mercury (Hring 7) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m1 = str2num(get(handles.edit_m1,'String'));   % Mercury mass
m2 = 2.45e-6;                                  % Venus mass
a1 = str2num(get(handles.edit_a1,'String'));   % Mercury semimajor axis 
a2 = 0.723;                                    % Venus semimajor axis
E1 = str2num(get(handles.edit_E1,'String'));   % Mercury eccentricity
E2 = 0;                                        % Venus-ring eccentricity

sigma0 = m0/(m0 + m1);  sigma1 = m1/(m0 + m1);
M1 = m0 + m1; M2 = m0 + m1 + m2;
mu1 = m0*m1/(m0 + m1); mu2 = M1*m2/(M1 + m2);
k1 = mu1*M1; k2 = mu2*M2;
L1 = sqrt(mu1*a1*k1);
L2 = sqrt(mu2*a2*k2);

G1 = (Gtot - XI1)/2;
G2 = L2;
e1 = sqrt(abs(1 - G1.^2/L1^2));
e2 = 0;
Eps2 = 1;
XI3 = 0;
H2_H10
Hring = H2;
for k = 3 : series_anal
    ks = num2str(k);
    Hring = eval(['Hring + H',ks,';']);
end
Hring7 = m1*m2*Hring;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Earth - Mercury (Hring 8) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m1 = str2num(get(handles.edit_m1,'String'));   % Mercury mass
m2 = 3e-6;                                     % Earth mass
a1 = str2num(get(handles.edit_a1,'String'));   % Mercury semimajor axis 
a2 = 1.0;                                      % Earth semimajor axis
E1 = str2num(get(handles.edit_E1,'String'));   % Mercury eccentricity
E2 = 0;                                        % Earth-ring eccentricity

sigma0 = m0/(m0 + m1);  sigma1 = m1/(m0 + m1);
M1 = m0 + m1; M2 = m0 + m1 + m2;
mu1 = m0*m1/(m0 + m1); mu2 = M1*m2/(M1 + m2);
k1 = mu1*M1; k2 = mu2*M2;
L1 = sqrt(mu1*a1*k1);
L2 = sqrt(mu2*a2*k2);

G1 = (Gtot - XI1)/2;
G2 = L2;
e1 = sqrt(abs(1 - G1.^2/L1^2));
e2 = 0;
Eps2 = 1;
XI3 = 0;
H2_H10
Hring = H2;
for k = 3 : series_anal
    ks = num2str(k);
    Hring = eval(['Hring + H',ks,';']);
end
Hring8 = m1*m2*Hring;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Mars - Mercury (Hring 9) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m1 = str2num(get(handles.edit_m1,'String'));   % Mercury mass
m2 = 3.2e-7;                                   % Mars mass
a1 = str2num(get(handles.edit_a1,'String'));   % Mercury semimajor axis 
a2 = 1.52;                                     % Mars semimajor axis
E1 = str2num(get(handles.edit_E1,'String'));   % Mercury eccentricity
E2 = 0;                                        % Mars-ring eccentricity

sigma0 = m0/(m0 + m1);  sigma1 = m1/(m0 + m1);
M1 = m0 + m1; M2 = m0 + m1 + m2;
mu1 = m0*m1/(m0 + m1); mu2 = M1*m2/(M1 + m2);
k1 = mu1*M1; k2 = mu2*M2;
L1 = sqrt(mu1*a1*k1);
L2 = sqrt(mu2*a2*k2);

G1 = (Gtot - XI1)/2;
G2 = L2;
e1 = sqrt(abs(1 - G1.^2/L1^2));
e2 = 0;
Eps2 = 1;
XI3 = 0;
H2_H10
Hring = H2;
for k = 3 : series_anal
    ks = num2str(k);
    Hring = eval(['Hring + H',ks,';']);
end
Hring9 = m1*m2*Hring;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Saturn - Mercury (Hring 10) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m1 = str2num(get(handles.edit_m1,'String'));   % Mercury mass
m2 = 3e-4;                                     % Saturn mass
a1 = str2num(get(handles.edit_a1,'String'));   % Mercury semimajor axis 
a2 = 9.53;                                     % Saturn semimajor axis
E1 = str2num(get(handles.edit_E1,'String'));   % Mercury eccentricity
E2 = 0;                                        % Saturn-ring eccentricity

sigma0 = m0/(m0 + m1);  sigma1 = m1/(m0 + m1);
M1 = m0 + m1; M2 = m0 + m1 + m2;
mu1 = m0*m1/(m0 + m1); mu2 = M1*m2/(M1 + m2);
k1 = mu1*M1; k2 = mu2*M2;
L1 = sqrt(mu1*a1*k1);
L2 = sqrt(mu2*a2*k2);

G1 = (Gtot - XI1)/2;
G2 = L2;
e1 = sqrt(abs(1 - G1.^2/L1^2));
e2 = 0;
Eps2 = 1;
XI3 = 0;
H2_H10
Hring = H2;
for k = 3 : series_anal
    ks = num2str(k);
    Hring = eval(['Hring + H',ks,';']);
end
Hring10 = m1*m2*Hring;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Uranus - Mercury (Hring 11) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m1 = str2num(get(handles.edit_m1,'String'));   % Mercury mass
m2 = 4.4e-5;                                   % Uranus mass
a1 = str2num(get(handles.edit_a1,'String'));   % Mercury semimajor axis 
a2 = 19.2;                                     % Uranus semimajor axis
E1 = str2num(get(handles.edit_E1,'String'));   % Mercury eccentricity
E2 = 0;                                        % Uranus-ring eccentricity

sigma0 = m0/(m0 + m1);  sigma1 = m1/(m0 + m1);
M1 = m0 + m1; M2 = m0 + m1 + m2;
mu1 = m0*m1/(m0 + m1); mu2 = M1*m2/(M1 + m2);
k1 = mu1*M1; k2 = mu2*M2;
L1 = sqrt(mu1*a1*k1);
L2 = sqrt(mu2*a2*k2);

G1 = (Gtot - XI1)/2;
G2 = L2;
e1 = sqrt(abs(1 - G1.^2/L1^2));
e2 = 0;
Eps2 = 1;
XI3 = 0;
H2_H10
Hring = H2;
for k = 3 : series_anal
    ks = num2str(k);
    Hring = eval(['Hring + H',ks,';']);
end
Hring11 = m1*m2*Hring;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Neptune - Mercury (Hring 12) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m1 = str2num(get(handles.edit_m1,'String'));   % Mercury mass
m2 = 5.2e-5;                                   % Neptune mass
a1 = str2num(get(handles.edit_a1,'String'));   % Mercury semimajor axis 
a2 = 30.07;                                    % Neptune semimajor axis
E1 = str2num(get(handles.edit_E1,'String'));   % Mercury eccentricity
E2 = 0;                                        % Neptune-ring eccentricity

sigma0 = m0/(m0 + m1);  sigma1 = m1/(m0 + m1);
M1 = m0 + m1; M2 = m0 + m1 + m2;
mu1 = m0*m1/(m0 + m1); mu2 = M1*m2/(M1 + m2);
k1 = mu1*M1; k2 = mu2*M2;
L1 = sqrt(mu1*a1*k1);
L2 = sqrt(mu2*a2*k2);

G1 = (Gtot - XI1)/2;
G2 = L2;
e1 = sqrt(abs(1 - G1.^2/L1^2));
e2 = 0;
Eps2 = 1;
XI3 = 0;
H2_H10
Hring = H2;
for k = 3 : series_anal
    ks = num2str(k);
    Hring = eval(['Hring + H',ks,';']);
end
Hring12 = m1*m2*Hring;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Hring = Hring1 + Hring2 + Hring3 + Hring4 + Hring5 + Hring6...
       + Hring7 + Hring8 + Hring9 + Hring10 + Hring11 + Hring12;

