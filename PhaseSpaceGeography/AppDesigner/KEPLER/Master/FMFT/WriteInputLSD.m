%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputAct1.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Act1x = Act(:,1).*cos(Angl(:,1));
Act1y = Act(:,1).*sin(Angl(:,1));
fid = fopen(['FMFT/inputAct1_',extstr,'.txt'], 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
    [tau'; Act1x'; Act1y']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputAct2.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Act2x = Act(:,2).*cos(Angl(:,2));
Act2y = Act(:,2).*sin(Angl(:,2));
fid = fopen(['FMFT/inputAct2_',extstr,'.txt'], 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
    [tau'; Act2x'; Act2y']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputAct3.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Act3x = Act(:,3).*cos(Angl(:,3));
Act3y = Act(:,3).*sin(Angl(:,3));
fid = fopen(['FMFT/inputAct3_',extstr,'.txt'], 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
    [tau'; Act3x'; Act3y']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------- Frequency Modulation Indicator (FMI) ----------------------
d = size(q_vec(:,1),1);
numdata = 2^(floor(log2(d)));
threshold = 16;
FMFT_pick = numdata/2;
%---------------------------------------------------------
n_step = InitData.step1LSD;
if n_step >= 1
    delta_step = floor((d - FMFT_pick)/n_step);
    for rr = 1:n_step + 1
        fid = fopen(['FMFT/inputAct1_',num2str(rr),'_',extstr,'.txt'], 'wt');
        fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
        Act1x(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
        Act1y(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)']);
        fclose(fid);
    end
end
%---------------------------------------------------------
n_step = InitData.step2LSD;
if n_step >= 1
    delta_step = floor((d - FMFT_pick)/n_step);
    for rr = 1:n_step + 1
        fid = fopen(['FMFT/inputAct2_',num2str(rr),'_',extstr,'.txt'], 'wt');
        fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
        Act2x(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
        Act2y(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)']);
        fclose(fid);
    end
end
%---------------------------------------------------------
n_step = InitData.step3LSD;
if n_step >= 1
    delta_step = floor((d - FMFT_pick)/n_step);
    for rr = 1:n_step + 1
        fid = fopen(['FMFT/inputAct3_',num2str(rr),'_',extstr,'.txt'], 'wt');
        fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
        Act3x(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
        Act3y(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)']);
        fclose(fid);
    end
end
%----------------- End FMI ----------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
