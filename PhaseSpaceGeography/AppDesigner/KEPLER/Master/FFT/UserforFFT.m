%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Prepare figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
KeplerDir = cd;
d = size(q_vec(:,1),1);
nump = 2^(floor(log2(d)));
freq = [0 :freq_max/nump: freq_max];
freq(nump) = [];    
freq = (freq - freq_max/2)/(2*pi);    
valCheck = get(app.check_log,'Value');    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%                     Plot FFT of User    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
[filename, pathname] = uigetfile( ...    
    {'*.m', 'All M-Files (*.m)'; ...    
        '*.*','All Files (*.*)'}, ...    
    'Choose Action-Angle file','UserFunctions/UserActionAngle/');    
if isequal([filename,pathname],[0,0])    
    return    
else    
    [pathstr, name, ext] = fileparts(filename);    
    cd(pathname)    
    eval(name)    
    cd(KeplerDir)    
end    
    
F = fft(Action.*cos(pi/180*Angl) + i*(Action.*sin(pi/180*Angl)), nump);    
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
title({'Fast Fourier Transform for User'})    
xlabel('Frequency', 'FontSize',10), ylabel('Amplitude', 'FontSize',10)    
    
