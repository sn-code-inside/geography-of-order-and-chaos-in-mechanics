cd ../
[time a1 ecc1 argperi1 longasc1] = textread('Jupiter.dat','%f %f %f %*f %f %f %*f %*f %*f %*f %*f','headerlines',17);
[a2 ecc2 argperi2 longasc2] = textread('Saturn.dat','%*f %f %f %*f %f %f %*f %*f %*f %*f %*f','headerlines',17);
m1 = str2num(get(app.edit_mass6,'Value'));
m2 = str2num(get(app.edit_mass7,'Value'));
G1 = m1*sqrt(a1).*sqrt(1-ecc1.^2);
G2 = m2*sqrt(a2).*sqrt(1-ecc2.^2);
Gtot = (G1 + G2)./(m1*sqrt(a1) + m2*sqrt(a2));
xi1 = G2 - G1;
longperi1 = argperi1 + longasc1;
longperi2 = argperi2 + longasc2;
phi = longperi2 - longperi1;
%%%%%%%%%%%%%%%%%%%%% Append %%%%%%%%%%%%%%%%%%%%%%%%%%% 
global phi_tot xi1_tot
phi_tot = [phi_tot  phi];
xi1_tot = [xi1_tot  xi1];
mx = max(max(xi1_tot));
mn = min(min(xi1_tot));
mx = mx + 0.1*abs(mx-mn);
mn = mn - 0.1*abs(mx-mn);
figure
plot(phi_tot(:), xi1_tot(:), '.k','MarkerSize',4)
axis([-180 180 mn mx])
title('Action-Angle: \it\xi_1 , \phi', 'FontSize',14)
ylabel('\it\xi_1     ', 'FontSize',14,'Rotation',0.0), xlabel('\it\phi', 'FontSize',20)
Degree_x
figure
plot(time,Gtot)
title('Total angular momentum', 'FontSize',14)
xlabel('time (yr)', 'FontSize',14)
set(app.pushbutton_ClearAppend,'Enable','on')
%%%%%%%%%%%%%%%%%%% End Append %%%%%%%%%%%%%%%%%%%%%%%%%