function Y = paralfor(X)
global mu
LagrangeDir = cd;
cd ..
cd ..
cd ..
PhSpGeoDir = cd;
cd(LagrangeDir)

ext = X{1,1}; Init_Data = X{1,2}; Totalbar = X{1,3}; begin = X{1,4};

Eql =         Init_Data{1,1};
mu =          Init_Data{1,2};
tau_total =   Init_Data{1,3};
q1_o =        Init_Data{1,4};
q2_o =        Init_Data{1,5};
q3_o =        Init_Data{1,6};
p1_o =        Init_Data{1,7};
p2_o =        Init_Data{1,8};
p2_o =        Init_Data{1,9};

ODE =         Init_Data{1,10};
RelTol =      Init_Data{1,11};
AbsTol =      Init_Data{1,12};
OutStep =     Init_Data{1,13};

I1_in =      Init_Data{1,14};
I1_fin =     Init_Data{1,15};
numstep_I1 = Init_Data{1,16};
I2_in =      Init_Data{1,17};
I2_fin =     Init_Data{1,18};
numstep_I2 = Init_Data{1,19};
I3_o =       Init_Data{1,20};

freq1_min =  Init_Data{1,21};
freq1_max =  Init_Data{1,22};
Step_FMI1 =  Init_Data{1,23};
freq2_min =  Init_Data{1,24};
freq2_max =  Init_Data{1,25};
Step_FMI2 =  Init_Data{1,26};
freq3_min =  Init_Data{1,27};
freq3_max =  Init_Data{1,28};
Step_FMI3 =  Init_Data{1,29};

View1 = Init_Data{1,30};
View2 = Init_Data{1,31};
View3 = Init_Data{1,32};
View4 = Init_Data{1,33};

row_tot = numstep_I2 + 1;
col_tot = numstep_I1 + 1;
int_tot = min(row_tot, col_tot);
ext_tot = max(row_tot, col_tot);

diagH
invT = inv(T);

q1_init = sqrt(2*I1_in);  p1_o = 0;
q2_init = sqrt(2*I2_in);  p2_o = 0;
q3_o =    sqrt(2*I3_o);   p3_o = 0;

extstr = num2str(ext);
if row_tot <= col_tot   
    q1_o = sqrt(2*I1_in + 2*(I1_fin-I1_in)/numstep_I1*(ext-1));
else
    q2_o = sqrt(2*I2_in + 2*(I2_fin-I2_in)/numstep_I2*(ext-1));    
end

ccount = 0;
for int = 1:int_tot
    if row_tot <= col_tot
        q2_o = sqrt(2*I2_in + 2*(I2_fin-I2_in)/numstep_I2*(int-1));        
    else
        q1_o = sqrt(2*I1_in + 2*(I1_fin-I1_in)/numstep_I1*(int-1));
    end
    x1_o = 1/2*(q1_o-i*p1_o);  x2_o = 1/2*(q1_o+i*p1_o);
    x3_o = 1/2*(q2_o-i*p2_o);  x4_o = 1/2*(q2_o+i*p2_o);
    x5_o = 1/2*(q3_o-i*p3_o);  x6_o = 1/2*(q3_o+i*p3_o);
    x_o = [x1_o;  x2_o;  x3_o;  x4_o;  x5_o;  x6_o];
    X_o = T*x_o;
    X_o = X_o + [mu-1/2;  sqrt(3)/2;  0;  -sqrt(3)/2;  mu-1/2;  0];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 OutStep_string = num2str(OutStep);
 if strcmp(ODE, 'BulirschStoer')
     options = AbsTol;
 else
     options = odeset('RelTol',[RelTol], 'AbsTol',[AbsTol]);
 end
 %{
if strcmp(ODE, 'BulirschStoer')
    tau = [0 : OutStep : tau_total];
    [W,info] = BulirschStoer(@DiffEquation, tau, X_o, RelTol);
    W = W';
    tau = tau';
elseif strcmp(ODE, 'ABM8')
    n_eq = 6;
    y_0 = X_o;
    h = OutStep;
    t_end = tau_total;
    driver_ABM8
    W = X(1:6,:);
    W = W';
elseif strcmp(ODE, 'ShampineGordon')
    Abs_Tol = AbsTol;
    Rel_Tol = RelTol;
    if AbsTol < 1e-7
        warndlg('The Absolute Tolerance must be greater than or equal to 1e-7')
        return
    end
    tot_time = tau_total;
    n_eq = 6;
    y_init = X_o;
    driver_ShampineGordon
    W = X';
    tau = tau';
else
 %}
X_o = [X_o; 0; 0];
[tau,W] = eval([ODE, '(@DiffEquation, [0 :',OutStep_string,': tau_total], X_o, options)']);
W = W(:,1:6);
%end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_sep = num2str(2*pi*15915.7*OutStep);
flag_FMFT = num2str(1);
d = size(W(:,1),1);    
ndata = num2str(2^(floor(log2(d))));

W(:,1) = W(:,1)-mu+1/2;
W(:,2) = W(:,2)-sqrt(3)/2;
W(:,3) = W(:,3);
W(:,4) = W(:,4)+sqrt(3)/2;
W(:,5) = W(:,5)-mu+1/2;
W(:,6) = W(:,6);

x = invT*(W');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputAct1.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q1 = real(x(1,:)+x(2,:));  p1 = -real(i*(x(1,:)-x(2,:)));
fid = fopen(['inputAct1_',extstr,'.txt'], 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
    [tau'; q1; p1]);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputAct2.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q2 = real(x(3,:)+x(4,:));  p2 = real(i*(x(3,:)-x(4,:)));
fid = fopen(['inputAct2_',extstr,'.txt'], 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
    [tau'; q2; p2]);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputAct3.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q3 = real(x(5,:)+x(6,:));  p3 = -real(i*(x(5,:)-x(6,:)));
fid = fopen(['inputAct3_',extstr,'.txt'], 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
    [tau'; q3; p3;]);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d = size(W(:,1),1);
numdata = 2^(floor(log2(d)));
threshold = 16;
FMFT_pick = numdata/2;
%---------------------------------------------------------
n_step = Step_FMI1;;
if n_step >= 1
    delta_step = floor((d - FMFT_pick)/n_step);
    for rr = 1:n_step + 1
        fid = fopen(['inputAct1_',num2str(rr),'_',extstr,'.txt'], 'wt');
        fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
        q1(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick);...
            p1(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)]);
        fclose(fid);
    end
end

%---------------------------------------------------------
n_step = Step_FMI2;
if n_step >= 1
    delta_step = floor((d - FMFT_pick)/n_step);
    for rr = 1:n_step + 1
        fid = fopen(['inputAct2_',num2str(rr),'_',extstr,'.txt'], 'wt');
        fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
        q2(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick);...
            p2(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)]);
        fclose(fid);
    end
end

%---------------------------------------------------------
n_step = Step_FMI3;
if n_step >= 1
    delta_step = floor((d - FMFT_pick)/n_step);
    for rr = 1:n_step + 1
        fid = fopen(['inputAct3_',num2str(rr),'_',extstr,'.txt'], 'wt');
        fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
        q3(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick);...
            p3(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)]);
        fclose(fid);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------------- Frequencies ----------------------------------
    min_f = freq1_min;
    max_f = freq1_max;
    if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = num2str(1000*max_f,'%6.12f');
        nfreq = num2str(2);
        cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
            data_sep,' ',ndata,' ',['<inputAct1_',extstr,'.txt'],' ',['>FMFT_of_Act1_',extstr,'.txt']];  
        eval(cmd_string)
        [frq_1] = textread(['FMFT_of_Act1_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
        if numel(frq_1)== 0
            disp('Some error occurred: the corresponding frequency and FMI values will be left blank.')
            freq_1(int) = NaN;
            freq_min_1(int) = NaN;
            freq_max_1(int) = NaN;
            freq_2(int) = NaN;
            freq_min_2(int) = NaN;
            freq_max_2(int) = NaN;        
            freq_3(int) = NaN;
            freq_min_3(int) = NaN;
            freq_max_3(int) = NaN;
            cd(LagrangeDir)
            continue
        end        
        if abs(frq_1(1)) > 1
            freq_1(int) = frq_1(1);
        else
            freq_1(int) = frq_1(2);
        end
    else
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = num2str(1000*max_f,'%6.12f');         
        nfreq = num2str(1);
        cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
            data_sep,' ',ndata,' ',['<inputAct1_',extstr,'.txt'],' ',['>FMFT_of_Act1_',extstr,'.txt']];  
        eval(cmd_string)
        [frq_1] = textread(['FMFT_of_Act1_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
        if numel(frq_1)== 0
            disp('Some error occurred: the corresponding frequency and FMI values will be left blank.')
            freq_1(int) = NaN;
            freq_min_1(int) = NaN;
            freq_max_1(int) = NaN;
            freq_2(int) = NaN;
            freq_min_2(int) = NaN;
            freq_max_2(int) = NaN;        
            freq_3(int) = NaN;
            freq_min_3(int) = NaN;
            freq_max_3(int) = NaN;
            cd(LagrangeDir)
            continue
        end          
        freq_1(int) = frq_1;
    end

    min_f = freq2_min;
    max_f = freq2_max;
    if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = num2str(1000*max_f,'%6.12f');
        nfreq = num2str(2);
        cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
            data_sep,' ',ndata,' ',['<inputAct2_',extstr,'.txt'],' ',['>FMFT_of_Act2_',extstr,'.txt']];  
        eval(cmd_string)
        [frq_2] = textread(['FMFT_of_Act2_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
        if numel(frq_2)== 0
            disp('Some error occurred: the corresponding frequency and FMI values will be left blank.')
            freq_1(int) = NaN;
            freq_min_1(int) = NaN;
            freq_max_1(int) = NaN;
            freq_2(int) = NaN;
            freq_min_2(int) = NaN;
            freq_max_2(int) = NaN;        
            freq_3(int) = NaN;
            freq_min_3(int) = NaN;
            freq_max_3(int) = NaN;
            cd(LagrangeDir)
            continue
        end          
        if abs(frq_2(1)) > 1
            freq_2(int) = frq_2(1);
        else
            freq_2(int) = frq_2(2);
        end
    else
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = num2str(1000*max_f,'%6.12f');         
        nfreq = num2str(1);
        cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
            data_sep,' ',ndata,' ',['<inputAct2_',extstr,'.txt'],' ',['>FMFT_of_Act2_',extstr,'.txt']];  
        eval(cmd_string)
        [frq_2] = textread(['FMFT_of_Act2_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
        if numel(frq_2)== 0
            disp('Some error occurred: the corresponding frequency and FMI values will be left blank.')
            freq_1(int) = NaN;
            freq_min_1(int) = NaN;
            freq_max_1(int) = NaN;
            freq_2(int) = NaN;
            freq_min_2(int) = NaN;
            freq_max_2(int) = NaN;        
            freq_3(int) = NaN;
            freq_min_3(int) = NaN;
            freq_max_3(int) = NaN;
            cd(LagrangeDir)
            continue
        end          
        freq_2(int) = frq_2;
    end

    freq_3(int) = 0;        
    if I3_o ~= 0
        min_f = freq3_min;
        max_f = freq3_max;
        if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)
            min_f = num2str(1000*min_f,'%6.12f');
            max_f = num2str(1000*max_f,'%6.12f');
            nfreq = num2str(2);
            cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                data_sep,' ',ndata,' ',['<inputAct3_',extstr,'.txt'],' ',['>FMFT_of_Act3_',extstr,'.txt']];  
            eval(cmd_string)
            [frq_3] = textread(['FMFT_of_Act3_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
            if numel(frq_3)== 0
            disp('Some error occurred: the corresponding frequency and FMI values will be left blank.')
                freq_1(int) = NaN;
                freq_min_1(int) = NaN;
                freq_max_1(int) = NaN;
                freq_2(int) = NaN;
                freq_min_2(int) = NaN;
                freq_max_2(int) = NaN;        
                freq_3(int) = NaN;
                freq_min_3(int) = NaN;
                freq_max_3(int) = NaN;
                cd(LagrangeDir)
                continue
            end                     
            if abs(frq_3(1)) > 1
                freq_3(int) = frq_3(1);
            else
                freq_3(int) = frq_3(2);
            end          
        else
            min_f = num2str(1000*min_f,'%6.12f');
            max_f = num2str(1000*max_f,'%6.12f');         
            nfreq = num2str(1);
            cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                data_sep,' ',ndata,' ',['<inputAct3_',extstr,'.txt'],' ',['>FMFT_of_Act3_',extstr,'.txt']];  
            eval(cmd_string)
            [frq_3] = textread(['FMFT_of_Act3_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
            if numel(frq_3)== 0
                freq_1(int) = NaN;
                freq_min_1(int) = NaN;
                freq_max_1(int) = NaN;
                freq_2(int) = NaN;
                freq_min_2(int) = NaN;
                freq_max_2(int) = NaN;        
                freq_3(int) = NaN;
                freq_min_3(int) = NaN;
                freq_max_3(int) = NaN;
                cd(LagrangeDir)
                continue
            end                     
            freq_3(int) = frq_3;               
        end
    end
%-------------- Frequency Modulation Indicator (FMI)---------------
    str_FMFT_pick = num2str(FMFT_pick);                  
%----------------------- Freq1 ------------------------------------
    n_step = Step_FMI1;
    if n_step >= 1
        min_f = freq1_min; 
        max_f = freq1_max;        
        if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)
            min_f = num2str(1000*min_f,'%6.12f');
            max_f = num2str(1000*max_f,'%6.12f');
            nfreq = num2str(2);                
            for rr = 1:n_step + 1
                cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                    data_sep,' ',str_FMFT_pick,' ','<inputAct1_',num2str(rr),'_',extstr,'.txt',' ','>FMFT_of_Act1_',num2str(rr),'_',extstr,'.txt'];  
                eval(cmd_string)
                [frq] = textread(['FMFT_of_Act1_',num2str(rr),'_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
                if abs(frq(1)) > 1
                    freq(rr) = frq(1);
                else
                    freq(rr) = frq(2);
                end
            end
        else
            min_f = num2str(1000*min_f,'%6.12f');
            max_f = num2str(1000*max_f,'%6.12f');         
            nfreq = num2str(1);
            for rr = 1:n_step + 1
                cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                    data_sep,' ',str_FMFT_pick,' ','<inputAct1_',num2str(rr),'_',extstr,'.txt',' ','>FMFT_of_Act1_',num2str(rr),'_',extstr,'.txt'];  
                eval(cmd_string) 
                frq = textread(['FMFT_of_Act1_',num2str(rr),'_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
                freq(rr) = frq;
            end
        end

        freq_min_1(int) = min(freq);
        freq_max_1(int) = max(freq);

%       Set min FMI1 = -12        
        if abs((freq_max_1(int)-freq_min_1(int))/(freq_max_1(int)+freq_min_1(int))) < 1e-12
            freq_min_1(int) = 1;
            freq_max_1(int) = (1+1e-12)/(1-1e-12);
        end
    end
%--------------------- Freq2 -- -------------------------------
    n_step = Step_FMI2;
    if n_step >= 1
        min_f = freq2_min; 
        max_f = freq2_max;         
        if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)
            min_f = num2str(1000*min_f,'%6.12f');
            max_f = num2str(1000*max_f,'%6.12f');
            nfreq = num2str(2);
            for rr = 1:n_step + 1
                cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                    data_sep,' ',str_FMFT_pick,' ','<inputAct2_',num2str(rr),'_',extstr,'.txt',' ','>FMFT_of_Act2_',num2str(rr),'_',extstr,'.txt'];  
                eval(cmd_string)
                [frq] = textread(['FMFT_of_Act2_',num2str(rr),'_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
                if abs(frq(1)) > 1
                    freq(rr) = frq(1);
                else
                    freq(rr) = frq(2);
                end
            end
        else
            min_f = num2str(1000*min_f,'%6.12f');
            max_f = num2str(1000*max_f,'%6.12f');         
            nfreq = num2str(1);
            for rr = 1:n_step + 1
                cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                    data_sep,' ',str_FMFT_pick,' ','<inputAct2_',num2str(rr),'_',extstr,'.txt',' ','>FMFT_of_Act2_',num2str(rr),'_',extstr,'.txt'];  
                eval(cmd_string) 
                frq = textread(['FMFT_of_Act2_',num2str(rr),'_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
                freq(rr) = frq;
            end
        end

        freq_min_2(int) = min(freq);
        freq_max_2(int) = max(freq);

%       Set min FMI2 = -12        
        if abs((freq_max_2(int)-freq_min_2(int))/(freq_max_2(int)+freq_min_2(int))) < 1e-12
            freq_min_2(int) = 1;
            freq_max_2(int) = (1+1e-12)/(1-1e-12);
        end           
    end
%--------------------- Freq3 ----------------------------------
    n_step = Step_FMI3;
    if n_step >= 1
        min_f = freq3_min; 
        max_f = freq3_max;         
        if (sign(min_f) ~= sign(max_f) | min_f == 0 | max_f == 0)
            min_f = num2str(1000*min_f,'%6.12f');
            max_f = num2str(1000*max_f,'%6.12f');
            nfreq = num2str(2);              
            for rr = 1:n_step + 1
                cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                    data_sep,' ',str_FMFT_pick,' ','<inputAct3_',num2str(rr),'_',extstr,'.txt',' ','>FMFT_of_Act3_',num2str(rr),'_',extstr,'.txt'];  
                eval(cmd_string)
                [frq] = textread(['FMFT_of_Act3_',num2str(rr),'_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
                if abs(frq(1)) > 1
                    freq(rr) = frq(1);
                else
                    freq(rr) = frq(2);
                end
            end
        else
            min_f = num2str(1000*min_f,'%6.12f');
            max_f = num2str(1000*max_f,'%6.12f');         
            nfreq = num2str(1);
            for rr = 1:n_step + 1
                cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                    data_sep,' ',str_FMFT_pick,' ','<inputAct3_',num2str(rr),'_',extstr,'.txt',' ','>FMFT_of_Act3_',num2str(rr),'_',extstr,'.txt'];  
                eval(cmd_string) 
                frq = textread(['FMFT_of_Act3_',num2str(rr),'_',extstr,'.txt'], '%f %*f %*f', 'headerlines', 4);
                freq(rr) = frq;
            end
        end

        freq_min_3(int) = min(freq);
        freq_max_3(int) = max(freq);

%       Set min FMI3 = -12        
        if abs((freq_max_3(int)-freq_min_3(int))/(freq_max_3(int)+freq_min_3(int))) < 1e-12
            freq_min_3(int) = 1;
            freq_max_3(int) = (1+1e-12)/(1-1e-12);
        end
    end
%--------------------- End FMI --------------------------------------------
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
cd(LagrangeDir)
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
    Progressbar = waitbar(0,'Please wait..., LAGRANGE is calculating.',...
        'Units', 'pixel', 'Position', Pos);
    waitbar(sum(num)/ext_tot, Progressbar, update);
end
%--------------------------------------------------------------------------

disp('                                             ')
%%%%%%%%%%%%%%%%%%%%%%%%% Compute FMI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_step = Step_FMI1;
if n_step >= 1
    FMI_1 = log10(abs((freq_max_1 - freq_min_1)./(freq_max_1 + freq_min_1)));
else
    FMI_1 = zeros(1, int_tot);
end

n_step = Step_FMI2;
if n_step >= 1    
    FMI_2 = log10(abs((freq_max_2 - freq_min_2)./(freq_max_2 + freq_min_2)));
else
    FMI_2 = zeros(1, int_tot);
end

n_step = Step_FMI3;
if n_step >= 1     
    FMI_3 = log10(abs((freq_max_3 - freq_min_3)./(freq_max_3 + freq_min_3)));
else
    FMI_3 = zeros(1, int_tot);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------- Generate output of the function ------------------------
Y = [freq_1; freq_2; freq_3; FMI_1; FMI_2; FMI_3];
delete *.txt
%%%%%%%%%%%%%%%%%%%%%%%%% End of the function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%