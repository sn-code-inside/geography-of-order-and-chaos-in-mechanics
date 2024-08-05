%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Prepare figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
norma_q = sqrt((sum((q_vec.^2)'))');
sm_ax = norma_q./(2-((sum((p_vec.^2)'))').*norma_q);
Delta = scalarp(q_vec,p_vec)./sqrt(sm_ax);
delta = (sm_ax-norma(q_vec))./sm_ax;
l = 180/pi*atan2(-delta.*sin(Delta)+Delta.*cos(Delta), delta.*cos(Delta)+Delta.*sin(Delta));
G_vec = vectorp(q_vec, p_vec);
G = norma(G_vec);
Ecc_vec = vectorp(p_vec, G_vec)-q_vec./[norma_q  norma_q  norma_q];
Ecc = norma(Ecc_vec);
%{
if (G_vec(1,1).^2+G_vec(1,2).^2) == 0;
    warndlg('Node line not defined')
end
node = [-G_vec(:,2)./sqrt(G_vec(:,1).^2+G_vec(:,2).^2)...
         G_vec(:,1)./sqrt(G_vec(:,1).^2+G_vec(:,2).^2)...
         zeros(size(G_vec(:,3)))];
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G_prj = sqrt(G_vec(:,1).^2+G_vec(:,2).^2);
sz = size(G_prj);
if all(G_prj)
    node = [-G_vec(:,2)./G_prj  G_vec(:,1)./G_prj  zeros(sz)];           
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
                node(jsz,:) = [-G_vec(jsz,2)/G_prj(jsz)  G_vec(jsz,1)/G_prj(jsz)  0 ];
            end
        end
    else
        if strcmp(get(app.warningbox, 'Checked'),'on')
            warndlg('Node line not defined')
        end
        node = [ones(sz)  zeros(sz)  zeros(sz)];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Omega = 180/pi*atan2(node(:,2), node(:,1));
omega = 180/pi*atan2(scalarp(vectorp(node, Ecc_vec), G_vec)./G,...
        scalarp(node, Ecc_vec));
d = size(q_vec(:,1),1);
nump = 2^(floor(log2(d)));    
freq = [0 :freq_max/nump: freq_max];
freq(nump) = [];    
freq = (freq - freq_max/2)/(2*pi);
%freq = [freq_max/2-10 : freq_max/nump : freq_max/2+10];
valCheck = get(app.check_log,'Value');    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%                     Plot FFT of L    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
F = fft(delta.*cos(Delta)+Delta.*sin(Delta) + i*(-delta.*sin(Delta)+Delta.*cos(Delta)), nump);    
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
F = fft(G.*cos(pi/180*omega) + i*G.*sin(pi/180*omega), nump);    
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
title({'Fast Fourier Transform for \itG'})    
xlabel('Frequency', 'FontSize',10), ylabel('Amplitude', 'FontSize',10)    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Plot FFT of G3    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if any(G_prj)
    F = fft(G_vec(:,3).*cos(pi/180*Omega) + i*G_vec(:,3).*sin(pi/180*Omega), nump);
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
    title({'Fast Fourier Transform for \itG_3'})    
    xlabel('Frequency', 'FontSize',10), ylabel('Amplitude', 'FontSize',10)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
