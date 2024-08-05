%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------------------ Long Frequency analysis------------------------------------
W = w(length(w)- deltaFMFT +1 : length(w), :);
%
tau_freq = tau_(length(w)- deltaFMFT +1 : length(w));
tau_floor = tau_freq - floor(tau_freq);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if get(app.check_pert,'Value') == 1
    Ko = (1/2*sqrt(sum(W(:,1:4)'.^2))...
    + 1/2*sqrt(sum(W(:,5:8)'.^2)))';
    
    x_vec = W(:,1:3).*cos([2*pi*tau_floor 2*pi*tau_floor 2*pi*tau_floor])...
        + W(:,5:7).*sin([2*pi*tau_floor 2*pi*tau_floor 2*pi*tau_floor])...
        -(W(:,5:7).*[W(:,4) W(:,4) W(:,4)]...
        - W(:,1:3).*[W(:,8) W(:,8) W(:,8)])...
        ./[Ko Ko Ko];
%
    y_vec = (-W(:,1:3).*sin([2*pi*tau_floor 2*pi*tau_floor 2*pi*tau_floor])...
        + W(:,5:7).*cos([2*pi*tau_floor 2*pi*tau_floor 2*pi*tau_floor]))...
        ./[Ko-W(:,4).*sin(2*pi*tau_floor)+W(:,8).*cos(2*pi*tau_floor),...
          Ko-W(:,4).*sin(2*pi*tau_floor)+W(:,8).*cos(2*pi*tau_floor),...
          Ko-W(:,4).*sin(2*pi*tau_floor)+W(:,8).*cos(2*pi*tau_floor)];
      
    q_vec = (lambda^2)*x_vec;
    p_vec = (1/lambda)*y_vec;
    
     global intfid
     if strcmp(num2str(intfid), '')
         intfid = fopen('UserSaved/Intermediate_values.txt', 'wt');
     end
     fprintf(intfid, '***************** Long block number = %u********************************\n', slowcount);
     fprintf(intfid, 'q1 = %18.16f   q2 = %18.16f   q3 = %18.16f\n',...
                [q_vec(1, 1); q_vec(1, 2); q_vec(1, 3)]);
     fprintf(intfid, 'p1 = %18.16f   p2 = %18.16f   p3 = %18.16f\n',...
                [p_vec(1, 1); p_vec(1, 2); p_vec(1, 3)]);
     fprintf(intfid, '           \n');
     
elseif get(app.check_nonpert,'Value') == 1
    x_vec = [2*W(:,1).*W(:,3) + 2*W(:,2).*W(:,4),...
        2*W(:,2).*W(:,3) - 2*W(:,1).*W(:,4),...
        -W(:,1).^2 - W(:,2).^2 + W(:,3).^2 + W(:,4).^2];

    norma_x = W(:,1).^2 + W(:,2).^2 + W(:,3).^2 + W(:,4).^2;

    y_vec = [-(W(:,1).*W(:,7) + W(:,2).*W(:,8)...
                + W(:,3).*W(:,5) + W(:,4).*W(:,6))./norma_x,...
         (W(:,1).*W(:,8) - W(:,2).*W(:,7)...
                - W(:,3).*W(:,6) + W(:,4).*W(:,5))./norma_x,...       
         (W(:,1).*W(:,5) + W(:,2).*W(:,6)...
                - W(:,3).*W(:,7) - W(:,4).*W(:,8))./norma_x];
            
     q_vec =  (lambda^2)*x_vec;
     p_vec = -(1/lambda)*y_vec;
     
     global intfid
     if strcmp(num2str(intfid), '')
         intfid = fopen('UserSaved/Intermediate_values.txt', 'wt');
     end
     fprintf(intfid, '***************** Long block number = %u ********************************\n', slowcount);
     fprintf(intfid, 'q1 = %18.16f   q2 = %18.16f   q3 = %18.16f\n',...
                [q_vec(1, 1); q_vec(1, 2); q_vec(1, 3)]);
     fprintf(intfid, 'p1 = %18.16f   p2 = %18.16f   p3 = %18.16f\n',...
                [p_vec(1, 1); p_vec(1, 2); p_vec(1, 3)]);
     fprintf(intfid, '           \n');       
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S_vec_o(1) = str2num(get(app.edit_S01,'Value'));  
S_vec_o(2) = str2num(get(app.edit_S02,'Value'));
S_vec_o(3) = str2num(get(app.edit_S03,'Value'));  % Relative equilibrium
D_vec_o(1) = str2num(get(app.edit_D01,'Value'));  %      position
D_vec_o(2) = str2num(get(app.edit_D02,'Value'));
D_vec_o(3) = str2num(get(app.edit_D03,'Value'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RotS3 = S_vec_o/norma(S_vec_o);
if (S_vec_o(2)^2+S_vec_o(3)^2) == 0
    RotS2 = [0  1  0];
    RotS1 = [0  0  -1];
else
    RotS2 = [0  S_vec_o(3)/sqrt(S_vec_o(2)^2+S_vec_o(3)^2)...
                  -S_vec_o(2)/sqrt(S_vec_o(2)^2+S_vec_o(3)^2)];
    RotS1 = vectorp(RotS2, RotS3);
end
RotS = [RotS1' RotS2' RotS3'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RotD3 = D_vec_o/norma(D_vec_o);
if (D_vec_o(2)^2+D_vec_o(3)^2) == 0
    RotD2 = [0  1  0];
    RotD1 = [0  0  -1];
else
    RotD2 = [0  D_vec_o(3)/sqrt(D_vec_o(2)^2+D_vec_o(3)^2)...
                  -D_vec_o(2)/sqrt(D_vec_o(2)^2+D_vec_o(3)^2)];
    RotD1 = vectorp(RotD2, RotD3);
end
RotD = [RotD1' RotD2' RotD3'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
qp2SD
Sprime_vec = S_vec*RotS;
Dprime_vec = D_vec*RotD; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
qp2uv  
%%%%%%%%%%%%%%%%%%%%%  
SoDo2uRvR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (strcmp(get(app.LGG3_long_FMFT, 'Checked'),'on'))
    ParalStructure
    DelaunayprimeforFMFT
elseif (strcmp(get(app.LSD_long_FMFT, 'Checked'),'on'))
    ParalStructure
    PauliprimeforFMFT
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputAct1.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Act1x = Act(:,1).*cos(Angl(:,1));
Act1y = Act(:,1).*sin(Angl(:,1));
fid = fopen('FMFT/inputAct1.txt', 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau_freq'; Act1x'; Act1y']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputAct2.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Act2x = Act(:,2).*cos(Angl(:,2));
Act2y = Act(:,2).*sin(Angl(:,2));
fid = fopen('FMFT/inputAct2.txt', 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau_freq'; Act2x'; Act2y']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputAct3.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Act3x = Act(:,3).*cos(Angl(:,3));
Act3y = Act(:,3).*sin(Angl(:,3));
fid = fopen('FMFT/inputAct3.txt', 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau_freq'; Act3x'; Act3y']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
KeplerDir = cd;
cd ..
cd ..
cd ..
PhSpGeoDir = cd;
cd([KeplerDir, '/FMFT'])            
flag_FMFT = num2str(get(app.popupmenu_FMFT_flag,'Value'));
data_sep = num2str(2*pi*100000*OutStep);        
ndata = num2str(deltaFMFT);                      

if (strcmp(get(app.LGG3_long_FMFT, 'Checked'),'on'))
    min_f = str2num(get(app.editGG3_min_Freq1,'Value'));
    max_f = str2num(get(app.editGG3_max_Freq1,'Value')); 
end

if (strcmp(get(app.LSD_long_FMFT, 'Checked'),'on'))
    min_f = str2num(get(app.editLSD_min_Freq1,'Value'));
    max_f = str2num(get(app.editLSD_max_Freq1,'Value'));
end

if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)            
    min_f = num2str(1000*min_f,'%6.12f');            
    max_f = num2str(1000*max_f,'%6.12f');            
    nfreq = num2str(2);            
    cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...            
          data_sep,' ',ndata,' ','<inputAct1.txt',' ','>FMFT_of_Act1.txt'];              
    eval(cmd_Value)            
    [frq_1] = textread('FMFT_of_Act1.txt', '%f %*f %*f', 'headerlines', 4);            
    if abs(frq_1(1)) > 1            
        freq_1 = frq_1(1);            
    else            
        freq_1 = frq_1(2);            
    end            
else            
    min_f = num2str(1000*min_f,'%6.12f');            
    max_f = num2str(1000*max_f,'%6.12f');                     
    nfreq = num2str(1);            
    cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...            
           data_sep,' ',ndata,' ','<inputAct1.txt',' ','>FMFT_of_Act1.txt'];              
    eval(cmd_Value)                 
    frq_1 = textread('FMFT_of_Act1.txt', '%f %*f %*f', 'headerlines', 4);            
    freq_1 = frq_1;            
end            
            
if (strcmp(get(app.LGG3_long_FMFT, 'Checked'),'on'))
    min_f = str2num(get(app.editGG3_min_Freq2,'Value'));
    max_f = str2num(get(app.editGG3_max_Freq2,'Value')); 
end

if (strcmp(get(app.LSD_long_FMFT, 'Checked'),'on'))
    min_f = str2num(get(app.editLSD_min_Freq2,'Value'));
    max_f = str2num(get(app.editLSD_max_Freq2,'Value'));
end

if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)            
    min_f = num2str(1000*min_f,'%6.12f');            
    max_f = num2str(1000*max_f,'%6.12f');            
    nfreq = num2str(2);            
    cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...            
          data_sep,' ',ndata,' ','<inputAct2.txt',' ','>FMFT_of_Act2.txt'];              
    eval(cmd_Value)            
    [frq_2] = textread('FMFT_of_Act2.txt', '%f %*f %*f', 'headerlines', 4);            
    if abs(frq_2(1)) > 1            
        freq_2 = frq_2(1);            
    else            
        freq_2 = frq_2(2);            
    end            
else            
    min_f = num2str(1000*min_f,'%6.12f');            
    max_f = num2str(1000*max_f,'%6.12f');                     
    nfreq = num2str(1);            
    cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...            
           data_sep,' ',ndata,' ','<inputAct2.txt',' ','>FMFT_of_Act2.txt'];              
    eval(cmd_Value)                 
    frq_2 = textread('FMFT_of_Act2.txt', '%f %*f %*f', 'headerlines', 4);            
    freq_2 = frq_2;            
end            
            
if (strcmp(get(app.LGG3_long_FMFT, 'Checked'),'on'))
    min_f = str2num(get(app.editGG3_min_Freq3,'Value'));
    max_f = str2num(get(app.editGG3_max_Freq3,'Value')); 
end

if (strcmp(get(app.LSD_long_FMFT, 'Checked'),'on'))
    min_f = str2num(get(app.editLSD_min_Freq3,'Value'));
    max_f = str2num(get(app.editLSD_max_Freq3,'Value'));
end

if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)            
    min_f = num2str(1000*min_f,'%6.12f');            
    max_f = num2str(1000*max_f,'%6.12f');            
    nfreq = num2str(2);            
    cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...            
          data_sep,' ',ndata,' ','<inputAct3.txt',' ','>FMFT_of_Act3.txt'];              
    eval(cmd_Value)            
    [frq_3] = textread('FMFT_of_Act3.txt', '%f %*f %*f', 'headerlines', 4);   
    if numel(frq_3) ~= 0
        if abs(frq_3(1)) > 1
            freq_3 = frq_3(1);
        else
            freq_3 = frq_3(2);
        end
    else
        freq_3 = 0;
    end      
else            
    min_f = num2str(1000*min_f,'%6.12f');            
    max_f = num2str(1000*max_f,'%6.12f');                     
    nfreq = num2str(1);            
    cmd_Value = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...            
           data_sep,' ',ndata,' ','<inputAct3.txt',' ','>FMFT_of_Act3.txt'];              
    eval(cmd_Value)                 
    frq_3 = textread('FMFT_of_Act3.txt', '%f %*f %*f', 'headerlines', 4);  
    if numel(frq_3) ~= 0
        freq_3 = frq_3; 
    else
        freq_3 = 0;
    end           
end                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
hold on
plot(slowcount, freq_1,'.r')
plot(slowcount, freq_2,'.k')
plot(slowcount, freq_3,'.b')
legend('Frequency 1','Frequency 2', 'Frequency 3')
hold off
title('Frequencies \times 1000','FontSize',12)
longblock_str = num2str(longblock);
xlabel(['\it\tau \rm\times ', longblock_str], 'FontSize',14), ylabel('Frequencies', 'FontSize',14)
clear freq_1 freq_2 freq_3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd(KeplerDir)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
