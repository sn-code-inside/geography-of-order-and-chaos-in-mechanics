function [daught] = daughter(k,scale,eta,sigma2);
%global eta sigma2

n = length(k);

expnt = -(scale.*k - eta).^2/2.*(k > 0.);
daught = sqrt(scale)*exp(sigma2*expnt);               % aggiunto da Bruno
daught = daught.*(k > 0.);                           % Heaviside step function

return
% end of code