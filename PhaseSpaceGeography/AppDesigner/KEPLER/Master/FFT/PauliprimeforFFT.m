%%%%%%%%%%%%%%%%%%%%%
qp2SD
SD2SpDp
%%%%%%%%%%%%%%%%%%%%%
qp2uv  
%%%%%%%%%%%%%%%%%%%%%  
SoDo2uRvR
%%%%%%%%%%%%%%%%%%%%% 
d = size(Sprime_vec(:,1),1);
nump = 2^(floor(log2(d)));
freq = [0 :freq_max/nump: freq_max];
freq(nump) = [];    
freq = (freq - freq_max/2)/(2*pi);    
valCheck = get(app.check_log,'Value');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%                     Plot FFT of L        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = sqrt(sm_ax);    
cos_l_Pauli = (vR(:,3).^2+vR(:,4).^2-uR(:,3).^2-uR(:,4).^2)...    
    ./sqrt((2*uR(:,3).*vR(:,3)+2*uR(:,4).*vR(:,4)).^2+(vR(:,3).^2+vR(:,4).^2-uR(:,3).^2-uR(:,4).^2).^2);    
sin_l_Pauli = (2*uR(:,3).*vR(:,3)+2*uR(:,4).*vR(:,4))...    
    ./sqrt((2*uR(:,3).*vR(:,3)+2*uR(:,4).*vR(:,4)).^2+(vR(:,3).^2+vR(:,4).^2-uR(:,3).^2-uR(:,4).^2).^2);    
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
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Plot FFT of S    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
F = fft(Sprime_vec(:,1) + i*Sprime_vec(:,2), nump);    
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
title({'Fast Fourier Transform for Rotated \itS'})    
xlabel('Frequency', 'FontSize',10), ylabel('Amplitude', 'FontSize',10)    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Plot FFT of D    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
F = fft(Dprime_vec(:,1) + i*Dprime_vec(:,2), nump);    
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
title({'Fast Fourier Transform for Rotated \itD'})    
xlabel('Frequency', 'FontSize',10), ylabel('Amplitude', 'FontSize',10)    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
