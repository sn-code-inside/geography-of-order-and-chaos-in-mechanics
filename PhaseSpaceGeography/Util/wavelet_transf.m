function [wave,Frequency] = wavelet_transf(Y,dtau,min_freq, max_freq, eta, sigma2, fourier_factor);
%global min_freq max_freq eta sigma2 fourier_factor

n1 = length(Y);
s_init = 1/(max_freq*fourier_factor);
dj = 1/100*log2(max_freq/min_freq);
index_tot = 100;

%....construct time series to analyze and pad it
x(1:n1) = Y - mean(Y);
base2 = fix(log(n1)/log(2) + 0.4999);                 % power of 2 nearest to N
x = [x,zeros(1,2^(base2+1)-n1)];
n = length(x);

%....construct wavenumber array used in transform     % Attenzione: dt = 2*pi*dtau
k = 1/(n*dtau)*[0, 1:fix(n/2), -fix((n-1)/2):-1];

%....compute FFT of the (padded) time series
f = fft(x);                                           % [Eqn(3)]

%....construct SCALE array & empty PERIOD & WAVE arrays
scale = s_init*2.^((0:index_tot)*dj);
wave = zeros(index_tot+1,n);                          % define the wavelet array
wave = wave + i*wave;                                 % make it complex

% loop through all scales and compute transform
for index = 1:index_tot+1
	[daught] = daughter(k,scale(index),eta,sigma2);	
	wave(index,:) = ifft(f.*daught);                  % wavelet transform
end

Frequency = 1000./(fourier_factor*scale);
wave = wave(:,1:n1);                                  % get rid of padding before returning

return
% end of code