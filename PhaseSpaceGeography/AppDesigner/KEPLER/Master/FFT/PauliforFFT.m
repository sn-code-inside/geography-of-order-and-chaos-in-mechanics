%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
qp2uv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d = size(S_vec(:,1),1);
nump = 2^(floor(log2(d)));
freq = [0 :freq_max/nump: freq_max];
freq(nump) = [];    
freq = (freq - freq_max/2)/(2*pi);    
valCheck = get(app.check_log,'Value');    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%                     Plot FFT of L    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
L = sqrt(sm_ax);    
cos_l_Pauli = (v(:,3).^2+v(:,4).^2-u(:,3).^2-u(:,4).^2)...    
    ./sqrt((2*u(:,3).*v(:,3)+2*u(:,4).*v(:,4)).^2+(v(:,3).^2+v(:,4).^2-u(:,3).^2-u(:,4).^2).^2);    
sin_l_Pauli = (2*u(:,3).*v(:,3)+2*u(:,4).*v(:,4))...    
    ./sqrt((2*u(:,3).*v(:,3)+2*u(:,4).*v(:,4)).^2+(v(:,3).^2+v(:,4).^2-u(:,3).^2-u(:,4).^2).^2);    
F = fft(L.*(cos_l_Pauli + i*sin_l_Pauli), nump);    
figure    
Farray = sqrt(real(F).^2 + imag(F).^2);    
Farray1 = Farray(1:nump/2, 1);    
Farray2 = Farray(nump/2+1:nump, 1);    
Farray = [Farray2;  Farray1];    
if valCheck == 0;    
    plot(freq, Farray/nump)    
else    
    semilogy(freq, Farray/nump)    
end    
title({'Fast Fourier Transform for \itL'})    
xlabel('Frequency', 'FontSize',10), ylabel('Amplitude', 'FontSize',10)    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Plot FFT of S    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
F = fft(S_vec(:,1) + i*S_vec(:,2), nump);    
figure    
Farray = sqrt(real(F).^2 + imag(F).^2);    
Farray1 = Farray(1:nump/2, 1);    
Farray2 = Farray(nump/2+1:nump, 1);    
Farray = [Farray2;  Farray1];    
if valCheck == 0;    
    plot(freq, Farray/nump)    
else    
    semilogy(freq, Farray/nump)    
end    
title({'Fast Fourier Transform for \itS'})    
xlabel('Frequency', 'FontSize',10), ylabel('Amplitude', 'FontSize',10)    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Plot FFT of D    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
F = fft(D_vec(:,1) + i*D_vec(:,2), nump);    
figure    
Farray = sqrt(real(F).^2 + imag(F).^2);    
Farray1 = Farray(1:nump/2, 1);    
Farray2 = Farray(nump/2+1:nump, 1);    
Farray = [Farray2;  Farray1];    
if valCheck == 0;    
    plot(freq, Farray/nump)    
else    
    semilogy(freq, Farray/nump)    
end    
title({'Fast Fourier Transform for \itD'})    
xlabel('Frequency', 'FontSize',10), ylabel('Amplitude', 'FontSize',10)    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%