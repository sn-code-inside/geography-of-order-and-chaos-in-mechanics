function dotX = DiffEquation(tau,X)

global mu pick time
if tau > pick + time/100;
    waitbar(tau/time);
    pick = tau;
end
ro1 = sqrt((X(1)-mu)^2+X(2)^2+X(3)^2);
ro2 = sqrt((X(1)-mu+1)^2+X(2)^2+X(3)^2);
dotX = zeros(8,1);

dotX(1) =  X(2) + X(4); 
dotX(2) = -X(1) + X(5);
dotX(3) =  X(6);
dotX(4) =  X(5) - (1-mu)*(X(1)-mu)/ro1^3 - mu*(X(1)-mu+1)/ro2^3;
dotX(5) = -X(4) - (1-mu)*X(2)/ro1^3 - mu*X(2)/ro2^3;
dotX(6) = -(1-mu)*X(3)/ro1^3 - mu*X(3)/ro2^3;
dotX(7) =  0;
dotX(8) =  0;