function EJ = Hamiltonian(X)
global mu
ro1 = sqrt((X(1,:)-mu).^2 + X(2,:).^2 + X(3,:).^2);
ro2 = sqrt((X(1,:)-mu+1).^2 + X(2,:).^2 + X(3,:).^2);
EJ = 1/2*(X(4,:)).^2 + 1/2*(X(5,:)).^2 + X(2,:).*X(4,:) - X(1,:).*X(5,:) - (1-mu)./ro1 - mu./ro2;