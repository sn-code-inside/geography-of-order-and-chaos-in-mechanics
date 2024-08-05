UserFunction(:,1) = asin(q2./sqrt(q1.^2 + q2.^2));
global dist3
figure
hold on
plot(sqrt(q1.^2 + q2.^2), q3);
plot(0,0,'-mo','MarkerFaceColor','yellow','MarkerSize',5)
plot(0,dist3,'-mo','MarkerFaceColor','black','MarkerSize',5)
xlabel('\rho', 'FontSize',18), ylabel('q_3', 'FontSize',16)
hold off
