cd ../
[x1 x2 x3] = textread(['Neptune.dat'],'%*f %*f %*f %*f %*f %*f %*f %*f %f %f %f','headerlines',17);
%%%%%%%%%%%%%%%%%%%%% Append %%%%%%%%%%%%%%%%%%%%%%%%%%% 
global x1_tot  x2_tot  x3_tot
x1_tot = [x1_tot  x1];
x2_tot = [x2_tot  x2];
x3_tot = [x3_tot  x3];
figure
hold on
axis equal
plot3(x1_tot, x2_tot, x3_tot)
plot3(0,0,0,'.')
title('Solar System', 'FontSize',14)
xlabel('\itx', 'FontSize',14,'Rotation',0.0), ylabel('\ity', 'FontSize',14), zlabel('\itz', 'FontSize',14)
set(app.pushbutton_ClearAppend,'Enable','on')
%%%%%%%%%%%%%%%%%%% End Append %%%%%%%%%%%%%%%%%%%%%%%%%