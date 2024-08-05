%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = norma(x_vec);
t = lambda^3*cumtrapz(tau,x);
figure
plot(tau,t)
title('True time vs False time','FontSize',12)
xlabel('\tau', 'FontSize',14), ylabel('\itt', 'FontSize',14)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

