function dotX = ERSD(tau,X)

% Definitions
dotX = zeros(6,1);
p1 = sqrt(2*X(4))*cos(6*X(1));
p2 = sqrt(2*X(5))*cos(X(2));
q1 = sqrt(2*X(4)/6)*sin(6*X(1));
q2 = sqrt(2*X(5))*sin(X(2));
Dq1 = 6/5*(2*q1 + q2) + 6/sqrt(5)*exp(2/sqrt(5)*(3*q1 - q2)) - 6/sqrt(5)*exp(1/sqrt(5)*(3*q1 - q2));
Dq2 = 3/5*(2*q1 + q2) - 2/sqrt(5)*exp(2/sqrt(5)*(3*q1 - q2)) + 2/sqrt(5)*exp(1/sqrt(5)*(3*q1 - q2));

% Differential equation
dotX(1) =  6*p1/sqrt(2*X(4))*cos(6*X(1)) + Dq1/sqrt(6*2*X(4))*sin(6*X(1)); 
dotX(2) =  p2/sqrt(2*X(5))*cos(X(2)) + Dq2/sqrt(2*X(5))*sin(X(2));
dotX(3) =  0;
dotX(4) =  6*p1*sqrt(2*X(4))*sin(6*X(1)) - Dq1*6*sqrt(2*X(4)/6)*cos(6*X(1));
dotX(5) =  p2*sqrt(2*X(5))*sin(X(2)) - Dq2*sqrt(2*X(5))*cos(X(2));
dotX(6) =  0;
