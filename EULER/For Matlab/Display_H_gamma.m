x0 = get(app.x,'Value');
y0 = get(app.y,'Value');
Vx0 = get(app.V_x,'Value');
Vy0 = get(app.V_y,'Value');
m = get(app.m,'Value');

% Let us calculate the two first integrals of the motion: H and gamma.
H = 1/2*(Vx0^2+Vy0^2) - 1/sqrt(x0^2+y0^2) - m/sqrt(x0^2+(y0-2)^2);
gamma = -Vx0*(y0*Vx0-x0*Vy0) + y0/sqrt(x0^2+y0^2) + 1/2*(y0*Vx0-x0*Vy0)^2 - m*(y0-2)/sqrt(x0^2+(y0-2)^2) + H;

% Display the value of the two first integrals of the motion: H and gamma.
set(app.H, 'Value', H);
if x0 == 0 & (y0 == 0 | y0 == 2)
    set(app.gamma, 'Value', -H);
else
    set(app.gamma, 'Value', -gamma);
end