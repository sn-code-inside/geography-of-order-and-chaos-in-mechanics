function Y = paralfor(X)
PoincareDir = cd;
cd ..
cd ..
cd ..
PhSpGeoDir = cd;
cd(PoincareDir)

ext = X{1,1};  Init_Data = X{1,2};  Totalbar = X{1,3};  begin = X{1,4};

MAP =        Init_Data{1,1};
epsilon1 =   Init_Data{1,2};                                               %#ok<NASGU> 
epsilon2 =   Init_Data{1,3};                                               %#ok<NASGU> 
epsilon3 =   Init_Data{1,4};                                               %#ok<NASGU> 
m        =   Init_Data{1,5};                                               %#ok<NASGU> 
tau_total =  Init_Data{1,6};

x1_in =      Init_Data{1,7};
x1_fin =     Init_Data{1,8};
numstep_x1 = Init_Data{1,9};
x2_in =      Init_Data{1,10};
x2_fin =     Init_Data{1,11};
numstep_x2 = Init_Data{1,12};

min_f1 =  Init_Data{1,13};
max_f1 =  Init_Data{1,14};
n_step1 = Init_Data{1,15};
min_f2 =  Init_Data{1,16};
max_f2 =  Init_Data{1,17};
n_step2 = Init_Data{1,18};

View1 = Init_Data{1,19};
View2 = Init_Data{1,20};
View3 = Init_Data{1,21};
View4 = Init_Data{1,22};

step_x1 = (x1_fin - x1_in)/numstep_x1;
step_x2 = (x2_fin - x2_in)/numstep_x2;
row_tot = numstep_x2 + 1;
col_tot = numstep_x1 + 1;
int_tot = min(row_tot, col_tot);
ext_tot = max(row_tot, col_tot);

extstr = num2str(ext);

if row_tot <= col_tot   
    x1_o = x1_in + step_x1*(ext-1);
else
    x2_o = x2_in + step_x2*(ext-1);    
end

%%%%%%%%%%%%%%% Compute frequencies and partial bars %%%%%%%%%%%%%%%%%%%%%%
ccount = 0;
for int = 1:int_tot
    if row_tot <= col_tot
        x2_o = x2_in + step_x2*(int-1);        
    else
        x1_o = x1_in + step_x1*(int-1);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    W = zeros(tau_total,4);
    Inpt = [x1_o  x2_o  0  0];
    W(1,:) = Inpt;
    for tau = 2:tau_total
        if strcmp(MAP, 'APLE')
            W(tau,:) = eval(['APLE','(Inpt,epsilon1)']);
        elseif strcmp(MAP, 'FGL')
            W(tau,:) = eval(['FGL','(Inpt,epsilon1,epsilon2,epsilon3)']);
        elseif strcmp(MAP, 'ROT')
            W(tau,:) = eval(['ROT','(Inpt,epsilon1,epsilon2)']);
        elseif strcmp(MAP, 'FGLsteep')
            W(tau,:) = eval(['FGLsteep','(Inpt,epsilon1,m)']);
        elseif strcmp(MAP, 'User')
            W(tau,:) = eval(['User','(Inpt,epsilon1)']);            
        end        
        Inpt = W(tau,:);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    data_sep = num2str(2*pi*100000*0.05);
    flag_FMFT = num2str(1);
    d = size(W(:,1),1);    
    ndata = num2str(2^(floor(log2(d))));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------- Write inputAct1.txt -------------------------------------

    Act1x = W(:,1).*cos(W(:,3));
    Act1y = W(:,1).*sin(W(:,3));
    tau = 1:tau_total;
    fid = fopen(['inputAct1_',extstr,'.txt'], 'wt');
    fprintf(fid, '%14.10f %14.10f %14.10f\n',...
        [tau ; Act1x'; Act1y']);
    fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------- Write inputAct2.txt ------------------------------------

    Act2x = W(:,2).*cos(W(:,4));
    Act2y = W(:,2).*sin(W(:,4));
    fid = fopen(['inputAct2_',extstr,'.txt'], 'wt');
    fprintf(fid, '%14.10f %14.10f %14.10f\n',...
        [tau ; Act2x'; Act2y']);
    fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------- Compute Frequencies ------------------------------------

    d = size(W(:,1),1);
    numdata = 2^(floor(log2(d)));
    threshold = 16;
    FMFT_pick = numdata/2;
%------------------ Input files for frequency 1 ---------------------------
    if n_step1 >= 1
        delta_step = floor((d - FMFT_pick)/n_step1);
        for rr = 1:n_step1 + 1
            fid = fopen(['inputAct1_',num2str(rr),'_',extstr,'.txt'], 'wt');
            fprintf(fid, '%14.10f %14.10f %14.10f\n',...
                [tau(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick);...
                Act1x(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
            Act1y(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)']);
            fclose(fid);
        end
    end

%-------------------- Input files for frequency 2 -------------------------
    if n_step2 >= 1
        delta_step = floor((d - FMFT_pick)/n_step2);
        for rr = 1:n_step2 + 1
            fid = fopen(['inputAct2_',num2str(rr),'_',extstr,'.txt'], 'wt');
            fprintf(fid, '%14.10f %14.10f %14.10f\n',...
                [tau(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick);...
                Act2x(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
            Act2y(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)']);
            fclose(fid);
        end
    end

    str_FMFT_pick = num2str(FMFT_pick); 

%----------------------- Freq1 --------------------------------------------
    if n_step1 >= 1  
        nfreq = num2str(1);
        for rr = 1:n_step1 + 1
            cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ', ...
                min_f1,' ',max_f1,' ',flag_FMFT,' ',nfreq,' ',...
                    data_sep,' ',str_FMFT_pick,' ','<inputAct1_',num2str(rr), ...
                        '_',extstr,'.txt',' ','>FMFT_of_Act1_',num2str(rr),'_',extstr,'.txt'];  
            eval(cmd_string) 
            frq = textread(['FMFT_of_Act1_',num2str(rr),'_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
            if numel(frq)== 0
                warndlg('Some error occurred: the corresponding FMI value will be left blank.')
                freq = NaN;
                cd(PoincareDir)
                break
            end
            freq(rr) = frq;
        end

        freq_min_1(int) = min(freq);
        freq_max_1(int) = max(freq);
        
        if abs((freq_max_1(int)-freq_min_1(int))/(freq_max_1(int)+freq_min_1(int))) < 1e-12
            freq_min_1(int) = 1;
            freq_max_1(int) = (1+1e-12)/(1-1e-12);
        end
    end

%--------------------- Freq2 -- -------------------------------
    if n_step2 >= 1     
        nfreq = num2str(1);
        for rr = 1:n_step2 + 1
            cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ', ...
                min_f2,' ',max_f2,' ',flag_FMFT,' ',nfreq,' ',...
                    data_sep,' ',str_FMFT_pick,' ','<inputAct2_',num2str(rr), ...
                        '_',extstr,'.txt',' ','>FMFT_of_Act2_',num2str(rr),'_',extstr,'.txt'];  
            eval(cmd_string) 
            frq = textread(['FMFT_of_Act2_',num2str(rr),'_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
            if numel(frq)== 0
                warndlg('Some error occurred: the corresponding FMI value will be left blank.')
                freq = NaN;        
                cd(PoincareDir)
                break
            end            
            freq(rr) = frq;
        end

        freq_min_2(int) = min(freq);
        freq_max_2(int) = max(freq);
               
        if abs((freq_max_2(int)-freq_min_2(int))/(freq_max_2(int)+freq_min_2(int))) < 1e-12
            freq_min_2(int) = 1;
            freq_max_2(int) = (1+1e-12)/(1-1e-12);
        end
    end

%%%%%%%%%%%%%%%%%%%%%%% Display percentage of row/column %%%%%%%%%%%%%%%%%%
    ccount = ccount + 1;
    if strcmp(View1, 'on')
        perc = ccount/int_tot*100;
        fprintf('\n\n')
        if row_tot <= col_tot
            if ccount == 1
                lgt = fprintf(['\b\bColumn ',extstr,' computed at %4.2f%%'],perc);
            else
                fprintf(repmat('\b', 1, lgt));
                lgt = fprintf(['Column ',extstr,' computed at %4.2f%%'],perc) + 2;
            end
        else
            if ccount == 1
                lgt = fprintf(['\b\bRow',extstr,' computed at %4.2f%%'],perc);
            else
                fprintf(repmat('\b', 1, lgt));
                lgt = fprintf(['Row ',extstr,' computed at %4.2f%%'],perc) + 2;
            end
        end
    end
end
disp('                                             ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd ..
fid = fopen('WaitBar.txt','a');
fwrite(fid,'1');
fclose(fid);
fid = fopen('WaitBar.txt','r');
B = fread(fid,'*char');
num = str2num(B);
perc = num2str(sum(num)/ext_tot*100,'%4.2f');
cd(PoincareDir)
list = strread(cd, '%s','delimiter',strrep(filesep,'\','\\'));
dim = size(list);
curdir = list{dim(1,1), dim(1,2)};
%%%%%%%%%%%%%%%%% Display completed row/column %%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(View2, 'on')
    disp([curdir,': computation completed at ', datestr(now)])
    disp(['|===================== Total progress: ',perc,'% ========================|']);
end

if strcmp(View3, 'on')
    bar = '@';
    while strlength(bar) < floor(0.7*str2num(perc))
        bar = [bar,'@'];
    end
    bar = ['|',bar,'|'];
    fprintf(bar);
    disp('    ')
    disp('------------------------------------------------------------------------')
end

if strcmp(View4, 'on')
    close all
    InitPos = [10 60 380 70];
    Shift_x = [380 0 0 0];
    Shift_y = [0 100 0 0];
    if strcmp('Master', curdir)
        Pos = InitPos + 9*Shift_y;
    elseif strcmp('Slave1', curdir)
        Pos = InitPos + 9*Shift_y + Shift_x;
    elseif strcmp('Slave2', curdir)
        Pos = InitPos + 8*Shift_y;
    elseif strcmp('Slave3', curdir)
        Pos = InitPos + 8*Shift_y + Shift_x;
    elseif strcmp('Slave4', curdir)
        Pos = InitPos + 7*Shift_y;
    elseif strcmp('Slave5', curdir)
        Pos = InitPos + 7*Shift_y + Shift_x;
    elseif strcmp('Slave6', curdir)
        Pos = InitPos + 6*Shift_y;
    elseif strcmp('Slave7', curdir)
        Pos = InitPos + 6*Shift_y + Shift_x;
    elseif strcmp('Slave8', curdir)
        Pos = InitPos + 5*Shift_y;
    elseif strcmp('Slave9', curdir)
        Pos = InitPos + 5*Shift_y + Shift_x;
    elseif strcmp('Slave10', curdir)
        Pos = InitPos + 4*Shift_y;
    elseif strcmp('Slave11', curdir)
        Pos = InitPos + 4*Shift_y + Shift_x;
    elseif strcmp('Slave12', curdir)
        Pos = InitPos + 3*Shift_y;
    elseif strcmp('Slave13', curdir)
        Pos = InitPos + 3*Shift_y + Shift_x;
    elseif strcmp('Slave14', curdir)
        Pos = InitPos + 2*Shift_y;
    elseif strcmp('Slave15', curdir)
        Pos = InitPos + 2*Shift_y + Shift_x;       
    end
    update = [' ',curdir,' - Total progress: ', perc, '% - ','Start: ', begin];
    Progressbar = waitbar(0,'Please wait..., POINCARE is calculating.',...
        'Units', 'pixel', 'Position', Pos);
    waitbar(sum(num)/ext_tot, Progressbar, update);
end
%--------------------------------------------------------------------------


%%%%%%%%%%%%%%%%%%%%%%%%% Compute FMI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if n_step1 >= 1
    FMI_1 = log10(abs((freq_max_1 - freq_min_1)./(freq_max_1 + freq_min_1)));
else
    FMI_1 = zeros(1, int_tot);
end

if n_step2 >= 1    
    FMI_2 = log10(abs((freq_max_2 - freq_min_2)./(freq_max_2 + freq_min_2)));
else
    FMI_2 = zeros(1, int_tot);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------- Generate output of the function ------------------------
Y = [FMI_1; FMI_2];
delete *.txt
%%%%%%%%%%%%%%%%%%%%%%%%% End of the function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%