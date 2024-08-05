%%%%%%%%%%%%%%%%%%%%%
qp2SD
SD2SpDp
%%%%%%%%%%%%%%%%%%%%%
qp2uv  
%%%%%%%%%%%%%%%%%%%%%  
SoDo2uRvR
%%%%%%%%%%%%%%%%%%%%%
L = sqrt(sm_ax);
lprime = atan2(-uR(:,4), -vR(:,4));
Gprime_vec = Sprime_vec + Dprime_vec;
Rprime_vec = Sprime_vec - Dprime_vec;
Gprime = norma(Gprime_vec);
G3prime = Gprime_vec(:,3);
Eccprime_vec = Rprime_vec./[L L L];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G_prj = sqrt(Gprime_vec(:,1).^2+Gprime_vec(:,2).^2);
sz = size(G_prj);
if all(G_prj)
    node = [-Gprime_vec(:,2)./G_prj  Gprime_vec(:,1)./G_prj  zeros(sz)];           
else
    if any(G_prj)
        node = zeros(sz(1),3);
        node(1,:) = [1  0  0];
        for jsz = 1 : sz(1)
            if G_prj(jsz) == 0
                if jsz == 1
                else
                    node(jsz,:) = node(jsz-1,:);
                end
            else
                node(jsz,:) = [-Gprime_vec(jsz,2)/G_prj(jsz)  Gprime_vec(jsz,1)/G_prj(jsz)  0 ];
            end
        end
    else
        node = [ones(sz)  zeros(sz)  zeros(sz)];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Omegaprime = atan2(node(:,2), node(:,1));
omegaprime = atan2(scalarp(vectorp(node, Eccprime_vec), Gprime_vec)./Gprime,...
        scalarp(node, Eccprime_vec));
        
d = size(q_vec(:,1),1);
nump = 2^(floor(log2(d)));    
freq = [0 :freq_max/nump: freq_max];
freq(nump) = [];    
freq = (freq - freq_max/2)/(2*pi);    
valCheck = get(app.check_log,'Value');    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%                     Plot FFT of L    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
F = fft(L.*cos(lprime) + i*L.*sin(lprime), nump);    
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
%                     Plot FFT of G    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
F = fft(Gprime.*cos(omegaprime) + i*Gprime.*sin(omegaprime), nump);    
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
title({'Fast Fourier Transform for Rotated \itG'})    
xlabel('Frequency', 'FontSize',10), ylabel('Amplitude', 'FontSize',10)    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Plot FFT of G3    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
F = fft(G3prime.*cos(Omegaprime) + i*G3prime.*sin(Omegaprime), nump);    
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
title({'Fast Fourier Transform for Rotated \itG_3'})    
xlabel('Frequency', 'FontSize',10), ylabel('Amplitude', 'FontSize',10)    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
