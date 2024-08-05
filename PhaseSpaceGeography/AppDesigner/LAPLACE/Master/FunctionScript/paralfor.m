function Y = paralfor(X)
LaplaceDir = cd;
cd ..
cd ..
cd ..
PhSpGeoDir = cd;
cd(LaplaceDir);

ext = X{1,1}; InitData = X(1,2); Totalbar = X{1,3};  begin = X{1,4};
InitData = InitData{1,1};
extstr = num2str(ext,10);                           % Quindi ext e extstr spazzano i valori  fisici corrispondenti alle colonne             
Planets = {InitData(1).planet, InitData(2).planet,InitData(3).planet,InitData(4).planet,InitData(5).planet,...
    InitData(6).planet, InitData(7).planet,InitData(8).planet,InitData(9).planet,InitData(10).planet};
planet = Planets;

N = 10;
for k = 1:10
    if strcmp(planet(k),'Absent')
        N = N-1;
    end
end
         
for k = 1:N
    while strcmp(planet(k),'Absent')
        planet(k) = '';
    end
end
            
while size(planet,2) > N
    planet(N+1) = '';
end
%%%%%%%%%%%%%%%%%%%% Mercury %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mass1   = InitData.mass1;
sma1    = InitData.sma1;
ecc1    = InitData.ecc1;
incl1   = InitData.incl1;
asc1    = InitData.asc1;
peri1    = InitData.peri1;
longmean1 = InitData.longmean1;
%%%%%%%%%%%%%%%%%%%% Venus %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mass2   = InitData.mass2;
sma2    = InitData.sma2;
ecc2    = InitData.ecc2;
incl2   = InitData.incl2;
asc2    = InitData.asc2;
peri2    = InitData.peri2;
longmean2 = InitData.longmean2;
%%%%%%%%%%%%%%%%%%%% Earth-Moon %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mass3   = InitData.mass3;
sma3    = InitData.sma3;
ecc3    = InitData.ecc3;
incl3   = InitData.incl3;
asc3    = InitData.asc3;
peri3    = InitData.peri3;
longmean3 = InitData.longmean3;
%%%%%%%%%%%%%%%%%%%%% Mars %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mass4   = InitData.mass4;
sma4    = InitData.sma4;
ecc4    = InitData.ecc4;
incl4   = InitData.incl4;
asc4    = InitData.asc4;
peri4    = InitData.peri4;
longmean4 = InitData.longmean4;
%%%%%%%%%%%%%%%%%%%% Asteroid %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mass5   = InitData.mass5;
sma5    = InitData.sma5;
ecc5    = InitData.ecc5;
incl5   = InitData.incl5;
asc5    = InitData.asc5;
peri5    = InitData.peri5;
longmean5 = InitData.longmean5;
%%%%%%%%%%%%%%%%%%%% Jupiter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mass6   = InitData.mass6;
sma6    = InitData.sma6;
ecc6    = InitData.ecc6;
incl6   = InitData.incl6;
asc6    = InitData.asc6;
peri6    = InitData.peri6;
longmean6 = InitData.longmean6;
%%%%%%%%%%%%%%%%%%%% Saturn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mass7   = InitData.mass7;
sma7    = InitData.sma7;
ecc7    = InitData.ecc7;
incl7   = InitData.incl7;
asc7    = InitData.asc7;
peri7    = InitData.peri7;
longmean7 = InitData.longmean7;
%%%%%%%%%%%%%%%%%%%% Uranus %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mass8   = InitData.mass8;
sma8    = InitData.sma8;
ecc8    = InitData.ecc8;
incl8   = InitData.incl8;
asc8    = InitData.asc8;
peri8    = InitData.peri8;
longmean8 = InitData.longmean8;
%%%%%%%%%%%%%%%%%%%% Neptune %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mass9   = InitData.mass9;
sma9    = InitData.sma9;
ecc9    = InitData.ecc9;
incl9   = InitData.incl9;
asc9    = InitData.asc9;
peri9    = InitData.peri9;
longmean9 = InitData.longmean9;
%%%%%%%%%%%%%%%%%%%% Pluto %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mass10   = InitData.mass10;
sma10    = InitData.sma10;
ecc10    = InitData.ecc10;
incl10   = InitData.incl10;
asc10    = InitData.asc10;
peri10    = InitData.peri10;
longmean10 = InitData.longmean10;
%%%%%%%%%%%%%%%%% ODE integration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
item = InitData.itemODE;
if item == 1;
    Method = 'Symplectic';
elseif item == 2;
    Method = 'Bulirsch-Stoer';
elseif item == 3;
    Method = 'Runge-Kutta';
elseif item == 4;
    Method = 'MVS';
elseif item == 5;
    Method = 'Radau';
elseif item == 6;
    Method = 'BS2';
elseif item == 7;
    Method = 'Hybrid';
end
if item < 4;
    jumprow = 17;
else
    jumprow = 4;
end
integstep = InitData.integstep;
integstep_str = num2str(integstep);
totint = InitData.totint;
totint_str = num2str(totint);
outstep = InitData.outstep;
outstep_str = num2str(outstep);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

intfrom = InitData.intfrom;
intstep = InitData.intstep;        % Quindi intstep+1 = numero righe da calcolare
if intstep ~= 0
    intto = InitData.intto;
else
    intto = intfrom;
end
if intstep ~= 0
    intdelta = (intto - intfrom)/intstep;
else
    intdelta = 1;
end

planetFMI_int = InitData.planetFMI_int;
item_int = InitData.item_int;
item_action_int = InitData.action_int;
item_action_int = str2num(item_action_int);

planetFMI_ext = InitData.planetFMI_ext;
item_ext = InitData.item_ext;
item_action_ext = InitData.action_ext;
item_action_ext = str2num(item_action_ext);

freq_ext_1 = NaN*ones(1,intstep+1);
freq_ext_2 = NaN*ones(1,intstep+1);
freq_ext_3 = NaN*ones(1,intstep+1);
freq_int_1 = NaN*ones(1,intstep+1);
freq_int_2 = NaN*ones(1,intstep+1);
freq_int_3 = NaN*ones(1,intstep+1);
FMI1 = NaN*ones(1,intstep+1);
FMI2 = NaN*ones(1,intstep+1);
FMI3 = NaN*ones(1,intstep+1);
int_count = 1;

for int = intfrom : intdelta : intto                 % Quindi int e intstr spazzano i valori
    intstr = num2str(int,10);                        % fisici corrispondenti alle righe
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if item < 4
        jumprow = 17;
        fid = fopen( 'custom.hnb', 'wt');
        fprintf(fid, ['Integrator: ',Method,'\n']);
        fprintf(fid, ['StepSize: ',integstep_str,'\n']);
        fprintf(fid, ['Tfinal: ',totint_str,'\n']);
        fprintf(fid, ['OutputInterval: ',outstep_str,'\n']);
        fprintf(fid, ['EnergyInterval: ',outstep_str,'\n']);

        if mass1
            if (item_ext == 1 & item_int ~= 1)
                if item_action_ext == 1
                    fprintf(fid, [mass1,'   ',extstr,'   ',ecc1,'   ',incl1,'   ',asc1,'   ',peri1,'   ',longmean1,'\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [mass1,'   ',sma1,'   ',extstr,'   ',incl1,'   ',asc1,'   ',peri1,'   ',longmean1,'\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [mass1,'   ',sma1,'   ',ecc1,'   ',extstr,'   ',asc1,'   ',peri1,'   ',longmean1,'\n']);
                end
            elseif (item_ext ~= 1 & item_int == 1)
                if item_action_int == 1
                    fprintf(fid, [mass1,'   ',intstr,'   ',ecc1,'   ',incl1,'   ',asc1,'   ',peri1,'   ',longmean1,'\n']);
                elseif item_action_int == 2
                    fprintf(fid, [mass1,'   ',sma1,'   ',intstr,'   ',incl1,'   ',asc1,'   ',peri1,'   ',longmean1,'\n']);
                elseif item_action_int == 3
                    fprintf(fid, [mass1,'   ',sma1,'   ',ecc1,'   ',intstr,'   ',asc1,'   ',peri1,'   ',longmean1,'\n']);
                end
            elseif (item_ext == 1 & item_int == 1)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [mass1,'   ',extstr,'   ',intstr,'   ',incl1,'   ',asc1,'   ',peri1,'   ',longmean1,'\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [mass1,'   ',extstr,'   ',ecc1,'   ',intstr,'   ',asc1,'   ',peri1,'   ',longmean1,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [mass1,'   ',intstr,'   ',extstr,'   ',incl1,'   ',asc1,'   ',peri1,'   ',longmean1,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [mass1,'   ',sma1,'   ',extstr,'   ',intstr,'   ',asc1,'   ',peri1,'   ',longmean1,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [mass1,'   ',intstr,'   ',ecc1,'   ',extstr,'   ',asc1,'   ',peri1,'   ',longmean1,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [mass1,'   ',sma1,'   ',intstr,'   ',extstr,'   ',asc1,'   ',peri1,'   ',longmean1,'\n']);
                end
            else
                fprintf(fid, [mass1,'   ',sma1,'   ',ecc1,'   ',incl1,'   ',asc1,'   ',peri1,'   ',longmean1,'\n']);
            end
        else
% do nothing
        end

        if mass2
            if (item_ext == 2 & item_int ~= 2)
                if item_action_ext == 1
                    fprintf(fid, [mass2,'   ',extstr,'   ',ecc2,'   ',incl2,'   ',asc2,'   ',peri2,'   ',longmean2,'\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [mass2,'   ',sma2,'   ',extstr,'   ',incl2,'   ',asc2,'   ',peri2,'   ',longmean2,'\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [mass2,'   ',sma2,'   ',ecc2,'   ',extstr,'   ',asc2,'   ',peri2,'   ',longmean2,'\n']);
                end
            elseif (item_ext ~= 2 & item_int == 2)
                if item_action_int == 1
                    fprintf(fid, [mass2,'   ',intstr,'   ',ecc2,'   ',incl2,'   ',asc2,'   ',peri2,'   ',longmean2,'\n']);
                elseif item_action_int == 2
                    fprintf(fid, [mass2,'   ',sma2,'   ',intstr,'   ',incl2,'   ',asc2,'   ',peri2,'   ',longmean2,'\n']);
                elseif item_action_int == 3
                    fprintf(fid, [mass2,'   ',sma2,'   ',ecc2,'   ',intstr,'   ',asc2,'   ',peri2,'   ',longmean2,'\n']);
                end
            elseif (item_ext == 2 & item_int == 2)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [mass2,'   ',extstr,'   ',intstr,'   ',incl2,'   ',asc2,'   ',peri2,'   ',longmean1,'\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [mass2,'   ',extstr,'   ',ecc2,'   ',intstr,'   ',asc2,'   ',peri2,'   ',longmean2,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [mass2,'   ',intstr,'   ',extstr,'   ',incl2,'   ',asc2,'   ',peri2,'   ',longmean2,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [mass2,'   ',sma2,'   ',extstr,'   ',intstr,'   ',asc2,'   ',peri2,'   ',longmean2,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [mass2,'   ',intstr,'   ',ecc2,'   ',extstr,'   ',asc2,'   ',peri2,'   ',longmean2,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [mass2,'   ',sma2,'   ',intstr,'   ',extstr,'   ',asc2,'   ',peri2,'   ',longmean2,'\n']);
                end
            else
                fprintf(fid, [mass2,'   ',sma2,'   ',ecc2,'   ',incl2,'   ',asc2,'   ',peri2,'   ',longmean2,'\n']);
            end
        else
% do nothing
        end

        if mass3
            if (item_ext == 3 & item_int ~= 3)
                if item_action_ext == 1
                    fprintf(fid, [mass3,'   ',extstr,'   ',ecc3,'   ',incl3,'   ',asc3,'   ',peri3,'   ',longmean3,'\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [mass3,'   ',sma3,'   ',extstr,'   ',incl3,'   ',asc3,'   ',peri3,'   ',longmean3,'\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [mass3,'   ',sma3,'   ',ecc3,'   ',extstr,'   ',asc3,'   ',peri3,'   ',longmean3,'\n']);
                end
            elseif (item_ext ~= 3 & item_int == 3)
                if item_action_int == 1
                    fprintf(fid, [mass3,'   ',intstr,'   ',ecc3,'   ',incl3,'   ',asc3,'   ',peri3,'   ',longmean3,'\n']);
                elseif item_action_int == 2
                    fprintf(fid, [mass3,'   ',sma3,'   ',intstr,'   ',incl3,'   ',asc3,'   ',peri3,'   ',longmean3,'\n']);
                elseif item_action_int == 3
                    fprintf(fid, [mass3,'   ',sma3,'   ',ecc3,'   ',intstr,'   ',asc3,'   ',peri3,'   ',longmean3,'\n']);
                end
            elseif (item_ext == 3 & item_int == 3)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [mass3,'   ',extstr,'   ',intstr,'   ',incl3,'   ',asc3,'   ',peri3,'   ',longmean3,'\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [mass3,'   ',extstr,'   ',ecc3,'   ',intstr,'   ',asc3,'   ',peri3,'   ',longmean3,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [mass3,'   ',intstr,'   ',extstr,'   ',incl3,'   ',asc3,'   ',peri3,'   ',longmean3,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [mass3,'   ',sma3,'   ',extstr,'   ',intstr,'   ',asc3,'   ',peri3,'   ',longmean3,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [mass3,'   ',intstr,'   ',ecc3,'   ',extstr,'   ',asc3,'   ',peri3,'   ',longmean3,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [mass3,'   ',sma3,'   ',intstr,'   ',extstr,'   ',asc3,'   ',peri3,'   ',longmean3,'\n']);
                end
            else
                fprintf(fid, [mass3,'   ',sma3,'   ',ecc3,'   ',incl3,'   ',asc3,'   ',peri3,'   ',longmean3,'\n']);
            end
        else
% do nothing
        end

        if mass4
            if (item_ext == 4 & item_int ~= 4)
                if item_action_ext == 1
                    fprintf(fid, [mass4,'   ',extstr,'   ',ecc4,'   ',incl4,'   ',asc4,'   ',peri4,'   ',longmean4,'\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [mass4,'   ',sma4,'   ',extstr,'   ',incl4,'   ',asc4,'   ',peri4,'   ',longmean4,'\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [mass4,'   ',sma4,'   ',ecc4,'   ',extstr,'   ',asc4,'   ',peri4,'   ',longmean4,'\n']);
                end
            elseif (item_ext ~= 4 & item_int == 4)
                if item_action_int == 1
                    fprintf(fid, [mass4,'   ',intstr,'   ',ecc4,'   ',incl4,'   ',asc4,'   ',peri4,'   ',longmean4,'\n']);
                elseif item_action_int == 2
                    fprintf(fid, [mass4,'   ',sma4,'   ',intstr,'   ',incl4,'   ',asc4,'   ',peri4,'   ',longmean4,'\n']);
                elseif item_action_int == 3
                    fprintf(fid, [mass4,'   ',sma4,'   ',ecc4,'   ',intstr,'   ',asc4,'   ',peri4,'   ',longmean4,'\n']);
                end
            elseif (item_ext == 4 & item_int == 4)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [mass4,'   ',extstr,'   ',intstr,'   ',incl4,'   ',asc4,'   ',peri4,'   ',longmean4,'\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [mass4,'   ',extstr,'   ',ecc4,'   ',intstr,'   ',asc4,'   ',peri4,'   ',longmean4,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [mass4,'   ',intstr,'   ',extstr,'   ',incl4,'   ',asc4,'   ',peri4,'   ',longmean4,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [mass4,'   ',sma4,'   ',extstr,'   ',intstr,'   ',asc4,'   ',peri4,'   ',longmean4,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [mass4,'   ',intstr,'   ',ecc4,'   ',extstr,'   ',asc4,'   ',peri4,'   ',longmean4,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [mass4,'   ',sma4,'   ',intstr,'   ',extstr,'   ',asc4,'   ',peri4,'   ',longmean4,'\n']);
                end
            else
                fprintf(fid, [mass4,'   ',sma4,'   ',ecc4,'   ',incl4,'   ',asc4,'   ',peri4,'   ',longmean4,'\n']);
            end
        else
% do nothing
        end

        if mass5
            if (item_ext == 5 & item_int ~= 5)
                if item_action_ext == 1
                    fprintf(fid, [mass5,'   ',extstr,'   ',ecc5,'   ',incl5,'   ',asc5,'   ',peri5,'   ',longmean5,'\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [mass5,'   ',sma5,'   ',extstr,'   ',incl5,'   ',asc5,'   ',peri5,'   ',longmean5,'\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [mass5,'   ',sma5,'   ',ecc5,'   ',extstr,'   ',asc5,'   ',peri5,'   ',longmean5,'\n']);
                end
            elseif (item_ext ~= 5 & item_int == 5)
                if item_action_int == 1
                    fprintf(fid, [mass5,'   ',intstr,'   ',ecc5,'   ',incl5,'   ',asc5,'   ',peri5,'   ',longmean5,'\n']);
                elseif item_action_int == 2
                    fprintf(fid, [mass5,'   ',sma5,'   ',intstr,'   ',incl5,'   ',asc5,'   ',peri5,'   ',longmean5,'\n']);
                elseif item_action_int == 3
                    fprintf(fid, [mass5,'   ',sma5,'   ',ecc5,'   ',intstr,'   ',asc5,'   ',peri5,'   ',longmean5,'\n']);
                end
            elseif (item_ext == 5 & item_int == 5)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [mass5,'   ',extstr,'   ',intstr,'   ',incl5,'   ',asc5,'   ',peri5,'   ',longmean5,'\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [mass5,'   ',extstr,'   ',ecc5,'   ',intstr,'   ',asc5,'   ',peri5,'   ',longmean5,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [mass5,'   ',intstr,'   ',extstr,'   ',incl5,'   ',asc5,'   ',peri5,'   ',longmean5,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [mass5,'   ',sma5,'   ',extstr,'   ',intstr,'   ',asc5,'   ',peri5,'   ',longmean5,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [mass5,'   ',intstr,'   ',ecc5,'   ',extstr,'   ',asc5,'   ',peri5,'   ',longmean5,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [mass5,'   ',sma5,'   ',intstr,'   ',extstr,'   ',asc5,'   ',peri5,'   ',longmean5,'\n']);
                end
            else
                fprintf(fid, [mass5,'   ',sma5,'   ',ecc5,'   ',incl5,'   ',asc5,'   ',peri5,'   ',longmean5,'\n']);
            end
        else
% do nothing
        end

        if mass6
            if (item_ext == 6 & item_int ~= 6)
                if item_action_ext == 1
                    fprintf(fid, [mass6,'   ',extstr,'   ',ecc6,'   ',incl6,'   ',asc6,'   ',peri6,'   ',longmean6,'\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [mass6,'   ',sma6,'   ',extstr,'   ',incl6,'   ',asc6,'   ',peri6,'   ',longmean6,'\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [mass6,'   ',sma6,'   ',ecc6,'   ',extstr,'   ',asc6,'   ',peri6,'   ',longmean6,'\n']);
                end
            elseif (item_ext ~= 6 & item_int == 6)
                if item_action_int == 1
                    fprintf(fid, [mass6,'   ',intstr,'   ',ecc6,'   ',incl6,'   ',asc6,'   ',peri6,'   ',longmean6,'\n']);
                elseif item_action_int == 2
                    fprintf(fid, [mass6,'   ',sma6,'   ',intstr,'   ',incl6,'   ',asc6,'   ',peri6,'   ',longmean6,'\n']);
                elseif item_action_int == 3
                    fprintf(fid, [mass6,'   ',sma6,'   ',ecc6,'   ',intstr,'   ',asc6,'   ',peri6,'   ',longmean6,'\n']);
                end
            elseif (item_ext == 6 & item_int == 6)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [mass6,'   ',extstr,'   ',intstr,'   ',incl6,'   ',asc6,'   ',peri6,'   ',longmean6,'\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [mass6,'   ',extstr,'   ',ecc6,'   ',intstr,'   ',asc6,'   ',peri6,'   ',longmean6,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [mass6,'   ',intstr,'   ',extstr,'   ',incl6,'   ',asc6,'   ',peri6,'   ',longmean6,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [mass6,'   ',sma6,'   ',extstr,'   ',intstr,'   ',asc6,'   ',peri6,'   ',longmean6,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [mass6,'   ',intstr,'   ',ecc6,'   ',extstr,'   ',asc6,'   ',peri6,'   ',longmean6,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [mass6,'   ',sma6,'   ',intstr,'   ',extstr,'   ',asc6,'   ',peri6,'   ',longmean6,'\n']);
                end
            else
                fprintf(fid, [mass6,'   ',sma6,'   ',ecc6,'   ',incl6,'   ',asc6,'   ',peri6,'   ',longmean6,'\n']);
            end
        else
% do nothing
        end

        if mass7
            if (item_ext == 7 & item_int ~= 7)
                if item_action_ext == 1
                    fprintf(fid, [mass7,'   ',extstr,'   ',ecc7,'   ',incl7,'   ',asc7,'   ',peri7,'   ',longmean7,'\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [mass7,'   ',sma7,'   ',extstr,'   ',incl7,'   ',asc7,'   ',peri7,'   ',longmean7,'\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [mass7,'   ',sma7,'   ',ecc7,'   ',extstr,'   ',asc7,'   ',peri7,'   ',longmean7,'\n']);
                end
            elseif (item_ext ~= 7 & item_int == 7)
                if item_action_int == 1
                    fprintf(fid, [mass7,'   ',intstr,'   ',ecc7,'   ',incl7,'   ',asc7,'   ',peri7,'   ',longmean7,'\n']);
                elseif item_action_int == 2
                    fprintf(fid, [mass7,'   ',sma7,'   ',intstr,'   ',incl7,'   ',asc7,'   ',peri7,'   ',longmean7,'\n']);
                elseif item_action_int == 3
                    fprintf(fid, [mass7,'   ',sma7,'   ',ecc7,'   ',intstr,'   ',asc7,'   ',peri7,'   ',longmean7,'\n']);
                end
            elseif (item_ext == 7 & item_int == 7)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [mass7,'   ',extstr,'   ',intstr,'   ',incl7,'   ',asc7,'   ',peri7,'   ',longmean7,'\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [mass7,'   ',extstr,'   ',ecc7,'   ',intstr,'   ',asc7,'   ',peri7,'   ',longmean7,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [mass7,'   ',intstr,'   ',extstr,'   ',incl7,'   ',asc7,'   ',peri7,'   ',longmean7,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [mass7,'   ',sma7,'   ',extstr,'   ',intstr,'   ',asc7,'   ',peri7,'   ',longmean7,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [mass7,'   ',intstr,'   ',ecc7,'   ',extstr,'   ',asc7,'   ',peri7,'   ',longmean7,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [mass7,'   ',sma7,'   ',intstr,'   ',extstr,'   ',asc7,'   ',peri7,'   ',longmean7,'\n']);
                end
            else
                fprintf(fid, [mass7,'   ',sma7,'   ',ecc7,'   ',incl7,'   ',asc7,'   ',peri7,'   ',longmean7,'\n']);
            end
        else
% do nothing
        end

        if mass8
            if (item_ext == 8 & item_int ~= 8)
                if item_action_ext == 1
                    fprintf(fid, [mass8,'   ',extstr,'   ',ecc8,'   ',incl8,'   ',asc8,'   ',peri8,'   ',longmean8,'\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [mass8,'   ',sma8,'   ',extstr,'   ',incl8,'   ',asc8,'   ',peri8,'   ',longmean8,'\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [mass8,'   ',sma8,'   ',ecc8,'   ',extstr,'   ',asc8,'   ',peri8,'   ',longmean8,'\n']);
                end
            elseif (item_ext ~= 8 & item_int == 8)
                if item_action_int == 1
                    fprintf(fid, [mass8,'   ',intstr,'   ',ecc8,'   ',incl8,'   ',asc8,'   ',peri8,'   ',longmean8,'\n']);
                elseif item_action_int == 2
                    fprintf(fid, [mass8,'   ',sma8,'   ',intstr,'   ',incl8,'   ',asc8,'   ',peri8,'   ',longmean8,'\n']);
                elseif item_action_int == 3
                    fprintf(fid, [mass8,'   ',sma8,'   ',ecc8,'   ',intstr,'   ',asc8,'   ',peri8,'   ',longmean8,'\n']);
                end
            elseif (item_ext == 8 & item_int == 8)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [mass8,'   ',extstr,'   ',intstr,'   ',incl8,'   ',asc8,'   ',peri8,'   ',longmean8,'\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [mass8,'   ',extstr,'   ',ecc8,'   ',intstr,'   ',asc8,'   ',peri8,'   ',longmean8,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [mass8,'   ',intstr,'   ',extstr,'   ',incl8,'   ',asc8,'   ',peri8,'   ',longmean8,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [mass8,'   ',sma8,'   ',extstr,'   ',intstr,'   ',asc8,'   ',peri8,'   ',longmean8,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [mass8,'   ',intstr,'   ',ecc8,'   ',extstr,'   ',asc8,'   ',peri8,'   ',longmean8,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [mass8,'   ',sma8,'   ',intstr,'   ',extstr,'   ',asc8,'   ',peri8,'   ',longmean8,'\n']);
                end
            else
                fprintf(fid, [mass8,'   ',sma8,'   ',ecc8,'   ',incl8,'   ',asc8,'   ',peri8,'   ',longmean8,'\n']);
            end
        else
% do nothing
        end

        if mass9
            if (item_ext == 9 & item_int ~= 9)
                if item_action_ext == 1
                    fprintf(fid, [mass9,'   ',extstr,'   ',ecc9,'   ',incl9,'   ',asc9,'   ',peri9,'   ',longmean9,'\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [mass9,'   ',sma9,'   ',extstr,'   ',incl9,'   ',asc9,'   ',peri9,'   ',longmean9,'\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [mass9,'   ',sma9,'   ',ecc9,'   ',extstr,'   ',asc9,'   ',peri9,'   ',longmean9,'\n']);
                end
            elseif (item_ext ~= 9 & item_int == 9)
                if item_action_int == 1
                    fprintf(fid, [mass9,'   ',intstr,'   ',ecc9,'   ',incl9,'   ',asc9,'   ',peri9,'   ',longmean9,'\n']);
                elseif item_action_int == 2
                    fprintf(fid, [mass9,'   ',sma9,'   ',intstr,'   ',incl9,'   ',asc9,'   ',peri9,'   ',longmean9,'\n']);
                elseif item_action_int == 3
                    fprintf(fid, [mass9,'   ',sma9,'   ',ecc9,'   ',intstr,'   ',asc9,'   ',peri9,'   ',longmean9,'\n']);
                end
            elseif (item_ext == 9 & item_int == 9)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [mass9,'   ',extstr,'   ',intstr,'   ',incl9,'   ',asc9,'   ',peri9,'   ',longmean9,'\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [mass9,'   ',extstr,'   ',ecc9,'   ',intstr,'   ',asc9,'   ',peri9,'   ',longmean9,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [mass9,'   ',intstr,'   ',extstr,'   ',incl9,'   ',asc9,'   ',peri9,'   ',longmean9,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [mass9,'   ',sma9,'   ',extstr,'   ',intstr,'   ',asc9,'   ',peri9,'   ',longmean9,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [mass9,'   ',intstr,'   ',ecc9,'   ',extstr,'   ',asc9,'   ',peri9,'   ',longmean9,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [mass9,'   ',sma9,'   ',intstr,'   ',extstr,'   ',asc9,'   ',peri9,'   ',longmean9,'\n']);
                end
            else
                fprintf(fid, [mass9,'   ',sma9,'   ',ecc9,'   ',incl9,'   ',asc9,'   ',peri9,'   ',longmean9,'\n']);
            end
        else
% do nothing
        end

        if mass10
            if (item_ext == 10 & item_int ~= 10)
                if item_action_ext == 1
                    fprintf(fid, [mass10,'   ',extstr,'   ',ecc10,'   ',incl10,'   ',asc10,'   ',peri10,'   ',longmean10,'\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [mass10,'   ',sma10,'   ',extstr,'   ',incl10,'   ',asc10,'   ',peri10,'   ',longmean10,'\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [mass10,'   ',sma10,'   ',ecc10,'   ',extstr,'   ',asc10,'   ',peri10,'   ',longmean10,'\n']);
                end
            elseif (item_ext ~= 10 & item_int == 10)
                if item_action_int == 1
                    fprintf(fid, [mass10,'   ',intstr,'   ',ecc10,'   ',incl10,'   ',asc10,'   ',peri10,'   ',longmean10,'\n']);
                elseif item_action_int == 2
                    fprintf(fid, [mass10,'   ',sma10,'   ',intstr,'   ',incl10,'   ',asc10,'   ',peri10,'   ',longmean10,'\n']);
                elseif item_action_int == 3
                    fprintf(fid, [mass10,'   ',sma10,'   ',ecc10,'   ',intstr,'   ',asc10,'   ',peri10,'   ',longmean10,'\n']);
                end
            elseif (item_ext == 10 & item_int == 10)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [mass10,'   ',extstr,'   ',intstr,'   ',incl10,'   ',asc10,'   ',peri10,'   ',longmean10,'\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [mass10,'   ',extstr,'   ',ecc10,'   ',intstr,'   ',asc10,'   ',peri10,'   ',longmean10,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [mass10,'   ',intstr,'   ',extstr,'   ',incl10,'   ',asc10,'   ',peri10,'   ',longmean10,'\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [mass10,'   ',sma10,'   ',extstr,'   ',intstr,'   ',asc10,'   ',peri10,'   ',longmean10,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [mass10,'   ',intstr,'   ',ecc10,'   ',extstr,'   ',asc10,'   ',peri10,'   ',longmean10,'\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [mass10,'   ',sma10,'   ',intstr,'   ',extstr,'   ',asc10,'   ',peri10,'   ',longmean10,'\n']);
                end
            else
                fprintf(fid, [mass10,'   ',sma10,'   ',ecc10,'   ',incl10,'   ',asc10,'   ',peri10,'   ',longmean10,'\n']);
            end
        else
% do nothing
        end

        fclose(fid);
        clear fid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %       cmd_string = ['!',LaplaceDir,'/hnbody -q init.hnb'];
 %       eval(cmd_string)
        Verbose = InitData.Verbose;
        if strcmp(Verbose,'on')
             cmd_string = ['!',LaplaceDir,'/hnbody init.hnb'];
        else
             cmd_string = ['!',LaplaceDir,'/hnbody -q init.hnb'];
        end
        eval(cmd_string)
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for k = 1:N
            k_str = num2str(k);
            movefile([k_str,'.dat'],[planet{k},'.dat'])
        end
    else
        jumprow = 4;
        fid = fopen( 'param.in', 'wt');
        fprintf(fid, ')O+_06 Integration parameters  (WARNING: Do not delete this line!!)\n');
        fprintf(fid, ['algorithm = ',Method,'\n']);
        fprintf(fid, ['start time = 0\n']);
        fprintf(fid, ['stop time = ',num2str(365.25*totint),'\n']);
        fprintf(fid, ['output interval = ',num2str(365.25*outstep),'\n']);                                                       
        fprintf(fid, ['timestep = ',num2str(365.25*integstep),'\n']);
        fprintf(fid, ['accuracy parameter=1.d-12\n']);
        fprintf(fid, ['stop integration after a close encounter = no\n']);
        fprintf(fid, ['allow collisions to occur = no\n']);
        fprintf(fid, ['include collisional fragmentation = no\n']);
        fprintf(fid, ['express time in days or years = years\n']);
        fprintf(fid, ['express time relative to integration start time = yes\n']);
        fprintf(fid, ['output precision = medium\n']);
        fprintf(fid, ['< not used at present >\n']);
        fprintf(fid, ['include relativity in integration= no\n']);
        fprintf(fid, ['include user-defined force = no\n']);
        fprintf(fid, ['ejection distance (AU)= 100\n']);
        fprintf(fid, ['radius of central body (AU) = 0.005\n']);
        fprintf(fid, ['central mass (solar) = 1.0\n']);
        fprintf(fid, ['central J2 = 0\n']);
        fprintf(fid, ['central J4 = 0\n']);
        fprintf(fid, ['central J6 = 0\n']);
        fprintf(fid, ['< not used at present >\n']);
        fprintf(fid, ['< not used at present >\n']);
        fprintf(fid, ['Hybrid integrator changeover (Hill radii) = 3.\n']);

        Verbose = InitData.Verbose;
        if strcmp(Verbose,'on')
            numts = num2str(ceil(totint/integstep)/1000);
        else
            numts = num2str(ceil(totint/integstep)/0.1);
        end

        fprintf(fid, ['number of timesteps between data dumps = ' numts '\n']);
        fprintf(fid, ['number of timesteps between periodic effects = 100\n']);

        fclose(fid);

        fid = fopen( 'element.in', 'wt');
        fprintf(fid, ')O+_06 element  (WARNING: Do not delete this line!!)\n');
        fprintf(fid, 'number of input files = 1\n');
        fprintf(fid, 'xv.out\n');
        fprintf(fid, 'type of elements (central body, barycentric, Jacobi) = Cen\n');
        fprintf(fid, 'minimum interval between outputs (days) = 3.6525\n');
        fprintf(fid, 'express time in days or years = years\n');
        fprintf(fid, 'express time relative to integration start time = yes\n');
        fprintf(fid, 'a10.7 e10.8 i10.6 g10.6 n10.6 l10.6 m13e\n');
        for k = 1:N
            fprintf(fid, [char(planet(k)),'\n']);
        end
        fclose(fid);

        fid = fopen( 'big.in', 'wt');
        fprintf(fid, [')O+_06 Big-body initial data  (WARNING: Do not delete this line!!)\n']);
        fprintf(fid, ['style = Asteroidal\n']);
        fprintf(fid, ['epoch (in days) = 0.\n']);
        if mass1
            periarg1 = num2str(str2num(peri1) - str2num(asc1),14);
            meanan1 = num2str(str2num(longmean1) - str2num(peri1),14);
            fprintf(fid,['Mercury','   m=',mass1,'\n']);
            if (item_ext == 1 & item_int ~= 1)
                if item_action_ext == 1
                    fprintf(fid, [extstr,'   ',ecc1,'   ',incl1,'   ',periarg1,'   ',asc1,'   ',meanan1,'  0.  0.  0.\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [sma1,'   ',extstr,'   ',incl1,'   ',periarg1,'   ',asc1,'   ',meanan1,'  0.  0.  0.\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [sma1,'   ',ecc1,'   ',extstr,'   ',periarg1,'   ',asc1,'   ',meanan1,'  0.  0.  0.\n']);
                end
            elseif (item_ext ~= 1 & item_int == 1)
                if item_action_int == 1
                    fprintf(fid, [intstr,'   ',ecc1,'   ',incl1,'   ',periarg1,'   ',asc1,'   ',meanan1,'  0.  0.  0.\n']);
                elseif item_action_int == 2
                    fprintf(fid, [sma1,'   ',intstr,'   ',incl1,'   ',periarg1,'   ',asc1,'   ',meanan1,'  0.  0.  0.\n']);
                elseif item_action_int == 3
                    fprintf(fid, [sma1,'   ',ecc1,'   ',intstr,'   ',periarg1,'   ',asc1,'   ',meanan1,'  0.  0.  0.\n']);
                end
            elseif (item_ext == 1 & item_int == 1)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [extstr,'   ',intstr,'   ',incl1,'   ',periarg1,'   ',asc1,'   ',meanan1,'  0.  0.  0.\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [extstr,'   ',ecc1,'   ',intstr,'   ',periarg1,'   ',asc1,'   ',meanan1,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',extstr,'   ',incl1,'   ',periarg1,'   ',asc1,'   ',meanan1,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [sma1,'   ',extstr,'   ',intstr,'   ',periarg1,'   ',asc1,'   ',meanan1,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',ecc1,'   ',extstr,'   ',periarg1,'   ',asc1,'   ',meanan1,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [sma1,'   ',intstr,'   ',extstr,'   ',periarg1,'   ',asc1,'   ',meanan1,'  0.  0.  0.\n']);
                end
            else
                fprintf(fid, [sma1,'   ',ecc1,'   ',incl1,'   ',periarg1,'   ',asc1,'   ',meanan1,'  0.  0.  0.\n']);
            end
        else
% do nothing
        end

        if mass2
            periarg2 = num2str(str2num(peri2) - str2num(asc2),14);
            meanan2 = num2str(str2num(longmean2) - str2num(peri2),14);
            fprintf(fid,['Venus','   m=',mass2,'\n']);
            if (item_ext == 2 & item_int ~= 2)
                if item_action_ext == 1
                    fprintf(fid, [extstr,'   ',ecc2,'   ',incl2,'   ',periarg2,'   ',asc2,'   ',meanan2,'  0.  0.  0.\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [sma2,'   ',extstr,'   ',incl2,'   ',periarg2,'   ',asc2,'   ',meanan2,'  0.  0.  0.\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [sma2,'   ',ecc2,'   ',extstr,'   ',periarg2,'   ',asc2,'   ',meanan2,'  0.  0.  0.\n']);
                end
            elseif (item_ext ~= 2 & item_int == 2)
                if item_action_int == 1
                    fprintf(fid, [intstr,'   ',ecc2,'   ',incl2,'   ',periarg2,'   ',asc2,'   ',meanan2,'  0.  0.  0.\n']);
                elseif item_action_int == 2
                    fprintf(fid, [sma2,'   ',intstr,'   ',incl2,'   ',periarg2,'   ',asc2,'   ',meanan2,'  0.  0.  0.\n']);
                elseif item_action_int == 3
                    fprintf(fid, [sma2,'   ',ecc2,'   ',intstr,'   ',periarg2,'   ',asc2,'   ',meanan2,'  0.  0.  0.\n']);
                end
            elseif (item_ext == 2 & item_int == 2)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [extstr,'   ',intstr,'   ',incl2,'   ',periarg2,'   ',asc2,'   ',meanan2,'  0.  0.  0.\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [extstr,'   ',ecc2,'   ',intstr,'   ',periarg2,'   ',asc2,'   ',meanan2,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',extstr,'   ',incl2,'   ',periarg2,'   ',asc2,'   ',meanan2,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [sma2,'   ',extstr,'   ',intstr,'   ',periarg2,'   ',asc2,'   ',meanan2,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',ecc2,'   ',extstr,'   ',periarg2,'   ',asc2,'   ',meanan2,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [sma2,'   ',intstr,'   ',extstr,'   ',periarg2,'   ',asc2,'   ',meanan2,'  0.  0.  0.\n']);
                end
            else
                fprintf(fid, [sma2,'   ',ecc2,'   ',incl2,'   ',periarg2,'   ',asc2,'   ',meanan2,'  0.  0.  0.\n']);
            end
        else
% do nothing
        end

        if mass3
            periarg3 = num2str(str2num(peri3) - str2num(asc3),14);
            meanan3 = num2str(str2num(longmean3) - str2num(peri3),14);
            fprintf(fid,['Earth-Moon','   m=',mass3,'\n']);
            if (item_ext == 3 & item_int ~= 3)
                if item_action_ext == 1
                    fprintf(fid, [extstr,'   ',ecc3,'   ',incl3,'   ',periarg3,'   ',asc3,'   ',meanan3,'  0.  0.  0.\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [sma3,'   ',extstr,'   ',incl3,'   ',periarg3,'   ',asc3,'   ',meanan3,'  0.  0.  0.\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [sma3,'   ',ecc3,'   ',extstr,'   ',periarg3,'   ',asc3,'   ',meanan3,'  0.  0.  0.\n']);
                end
            elseif (item_ext ~= 3 & item_int == 3)
                if item_action_int == 1
                    fprintf(fid, [intstr,'   ',ecc3,'   ',incl3,'   ',periarg3,'   ',asc3,'   ',meanan3,'  0.  0.  0.\n']);
                elseif item_action_int == 2
                    fprintf(fid, [sma3,'   ',intstr,'   ',incl3,'   ',periarg3,'   ',asc3,'   ',meanan3,'  0.  0.  0.\n']);
                elseif item_action_int == 3
                    fprintf(fid, [sma3,'   ',ecc3,'   ',intstr,'   ',periarg3,'   ',asc3,'   ',meanan3,'  0.  0.  0.\n']);
                end
            elseif (item_ext == 3 & item_int == 3)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [extstr,'   ',intstr,'   ',incl3,'   ',periarg3,'   ',asc3,'   ',meanan3,'  0.  0.  0.\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [extstr,'   ',ecc3,'   ',intstr,'   ',periarg3,'   ',asc3,'   ',meanan3,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',extstr,'   ',incl3,'   ',periarg3,'   ',asc3,'   ',meanan3,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [sma3,'   ',extstr,'   ',intstr,'   ',periarg3,'   ',asc3,'   ',meanan3,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',ecc3,'   ',extstr,'   ',periarg3,'   ',asc3,'   ',meanan3,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [sma3,'   ',intstr,'   ',extstr,'   ',periarg3,'   ',asc3,'   ',meanan3,'  0.  0.  0.\n']);
                end
            else
                fprintf(fid, [sma3,'   ',ecc3,'   ',incl3,'   ',periarg3,'   ',asc3,'   ',meanan3,'  0.  0.  0.\n']);  
            end
        else
% do nothing
        end

        if mass4
            periarg4 = num2str(str2num(peri4) - str2num(asc4),14);
            meanan4 = num2str(str2num(longmean4) - str2num(peri4),14);
            fprintf(fid,['Mars','   m=',mass4,'\n']);
            if (item_ext == 4 & item_int ~= 4)
                if item_action_ext == 1
                    fprintf(fid, [extstr,'   ',ecc4,'   ',incl4,'   ',periarg4,'   ',asc4,'   ',meanan4,'  0.  0.  0.\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [sma4,'   ',extstr,'   ',incl4,'   ',periarg4,'   ',asc4,'   ',meanan4,'  0.  0.  0.\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [sma4,'   ',ecc4,'   ',extstr,'   ',periarg4,'   ',asc4,'   ',meanan4,'  0.  0.  0.\n']);
                end
            elseif (item_ext ~= 4 & item_int == 4)
                if item_action_int == 1
                    fprintf(fid, [intstr,'   ',ecc4,'   ',incl4,'   ',periarg4,'   ',asc4,'   ',meanan4,'  0.  0.  0.\n']);
                elseif item_action_int == 2
                    fprintf(fid, [sma4,'   ',intstr,'   ',incl4,'   ',periarg4,'   ',asc4,'   ',meanan4,'  0.  0.  0.\n']);
                elseif item_action_int == 3
                    fprintf(fid, [sma4,'   ',ecc4,'   ',intstr,'   ',periarg4,'   ',asc4,'   ',meanan4,'  0.  0.  0.\n']);
                end
            elseif (item_ext == 4 & item_int == 4)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [extstr,'   ',intstr,'   ',incl4,'   ',periarg4,'   ',asc4,'   ',meanan4,'  0.  0.  0.\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [extstr,'   ',ecc4,'   ',intstr,'   ',periarg4,'   ',asc4,'   ',meanan4,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',extstr,'   ',incl4,'   ',periarg4,'   ',asc4,'   ',meanan4,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [sma4,'   ',extstr,'   ',intstr,'   ',periarg4,'   ',asc4,'   ',meanan4,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',ecc4,'   ',extstr,'   ',periarg4,'   ',asc4,'   ',meanan4,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [sma4,'   ',intstr,'   ',extstr,'   ',periarg4,'   ',asc4,'   ',meanan4,'  0.  0.  0.\n']);
                end
            else
                fprintf(fid, [sma4,'   ',ecc4,'   ',incl4,'   ',periarg4,'   ',asc4,'   ',meanan4,'  0.  0.  0.\n']);  
            end
        else
% do nothing
        end

        if mass6
            periarg6 = num2str(str2num(peri6) - str2num(asc6),14);
            meanan6 = num2str(str2num(longmean6) - str2num(peri6),14);
            fprintf(fid,['Jupiter','   m=',mass6,'\n']);
            if (item_ext == 6 & item_int ~= 6)
                if item_action_ext == 1
                    fprintf(fid, [extstr,'   ',ecc6,'   ',incl6,'   ',periarg6,'   ',asc6,'   ',meanan6,'  0.  0.  0.\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [sma6,'   ',extstr,'   ',incl6,'   ',periarg6,'   ',asc6,'   ',meanan6,'  0.  0.  0.\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [sma6,'   ',ecc6,'   ',extstr,'   ',periarg6,'   ',asc6,'   ',meanan6,'  0.  0.  0.\n']);
                end
            elseif (item_ext ~= 6 & item_int == 6)
                if item_action_int == 1
                    fprintf(fid, [intstr,'   ',ecc6,'   ',incl6,'   ',periarg6,'   ',asc6,'   ',meanan6,'  0.  0.  0.\n']);
                elseif item_action_int == 2
                    fprintf(fid, [sma6,'   ',intstr,'   ',incl6,'   ',periarg6,'   ',asc6,'   ',meanan6,'  0.  0.  0.\n']);
                elseif item_action_int == 3
                    fprintf(fid, [sma6,'   ',ecc6,'   ',intstr,'   ',periarg6,'   ',asc6,'   ',meanan6,'  0.  0.  0.\n']);
                end
            elseif (item_ext == 6 & item_int == 6)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [extstr,'   ',intstr,'   ',incl6,'   ',periarg6,'   ',asc6,'   ',meanan6,'  0.  0.  0.\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [extstr,'   ',ecc6,'   ',intstr,'   ',periarg6,'   ',asc6,'   ',meanan6,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',extstr,'   ',incl6,'   ',periarg6,'   ',asc6,'   ',meanan6,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [sma6,'   ',extstr,'   ',intstr,'   ',periarg6,'   ',asc6,'   ',meanan6,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',ecc6,'   ',extstr,'   ',periarg6,'   ',asc6,'   ',meanan6,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [sma6,'   ',intstr,'   ',extstr,'   ',periarg6,'   ',asc6,'   ',meanan6,'  0.  0.  0.\n']);
                end
            else
                fprintf(fid, [sma6,'   ',ecc6,'   ',incl6,'   ',periarg6,'   ',asc6,'   ',meanan6,'  0.  0.  0.\n']);  
            end
        else
% do nothing
        end

        if mass7
            periarg7 = num2str(str2num(peri7) - str2num(asc7),14);
            meanan7 = num2str(str2num(longmean7) - str2num(peri7),14);
            fprintf(fid,['Saturn','   m=',mass7,'\n']);
            if (item_ext == 7 & item_int ~= 7)
                if item_action_ext == 1
                    fprintf(fid, [extstr,'   ',ecc7,'   ',incl7,'   ',periarg7,'   ',asc7,'   ',meanan7,'  0.  0.  0.\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [sma7,'   ',extstr,'   ',incl7,'   ',periarg7,'   ',asc7,'   ',meanan7,'  0.  0.  0.\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [sma7,'   ',ecc7,'   ',extstr,'   ',periarg7,'   ',asc7,'   ',meanan7,'  0.  0.  0.\n']);
                end
            elseif (item_ext ~= 7 & item_int == 7)
                if item_action_int == 1
                    fprintf(fid, [intstr,'   ',ecc7,'   ',incl7,'   ',periarg7,'   ',asc7,'   ',meanan7,'  0.  0.  0.\n']);
                elseif item_action_int == 2
                    fprintf(fid, [sma7,'   ',intstr,'   ',incl7,'   ',periarg7,'   ',asc7,'   ',meanan7,'  0.  0.  0.\n']);
                elseif item_action_int == 3
                    fprintf(fid, [sma7,'   ',ecc7,'   ',intstr,'   ',periarg7,'   ',asc7,'   ',meanan7,'  0.  0.  0.\n']);
                end
            elseif (item_ext == 7 & item_int == 7)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [extstr,'   ',intstr,'   ',incl7,'   ',periarg7,'   ',asc7,'   ',meanan7,'  0.  0.  0.\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [extstr,'   ',ecc7,'   ',intstr,'   ',periarg7,'   ',asc7,'   ',meanan7,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',extstr,'   ',incl7,'   ',periarg7,'   ',asc7,'   ',meanan7,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [sma7,'   ',extstr,'   ',intstr,'   ',periarg7,'   ',asc7,'   ',meanan7,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',ecc7,'   ',extstr,'   ',periarg7,'   ',asc7,'   ',meanan7,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [sma7,'   ',intstr,'   ',extstr,'   ',periarg7,'   ',asc7,'   ',meanan7,'  0.  0.  0.\n']);
                end
            else
                fprintf(fid, [sma7,'   ',ecc7,'   ',incl7,'   ',periarg7,'   ',asc7,'   ',meanan7,'  0.  0.  0.\n']);
            end
        else
% do nothing
        end

        if mass8
            periarg8 = num2str(str2num(peri8) - str2num(asc8),14);
            meanan8 = num2str(str2num(longmean8) - str2num(peri8),14);
            fprintf(fid,['Uranus','   m=',mass8,'\n']);
            if (item_ext == 8 & item_int ~= 8)
                if item_action_ext == 1
                    fprintf(fid, [extstr,'   ',ecc8,'   ',incl8,'   ',periarg8,'   ',asc8,'   ',meanan8,'  0.  0.  0.\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [sma8,'   ',extstr,'   ',incl8,'   ',periarg8,'   ',asc8,'   ',meanan8,'  0.  0.  0.\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [sma8,'   ',ecc8,'   ',extstr,'   ',periarg8,'   ',asc8,'   ',meanan8,'  0.  0.  0.\n']);
                end
            elseif (item_ext ~= 8 & item_int == 8)
                if item_action_int == 1
                    fprintf(fid, [intstr,'   ',ecc8,'   ',incl8,'   ',periarg8,'   ',asc8,'   ',meanan8,'  0.  0.  0.\n']);
                elseif item_action_int == 2
                    fprintf(fid, [sma8,'   ',intstr,'   ',incl8,'   ',periarg8,'   ',asc8,'   ',meanan8,'  0.  0.  0.\n']);
                elseif item_action_int == 3
                    fprintf(fid, [sma8,'   ',ecc8,'   ',intstr,'   ',periarg8,'   ',asc8,'   ',meanan8,'  0.  0.  0.\n']);
                end
            elseif (item_ext == 8 & item_int == 8)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [extstr,'   ',intstr,'   ',incl8,'   ',periarg8,'   ',asc8,'   ',meanan8,'  0.  0.  0.\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [extstr,'   ',ecc8,'   ',intstr,'   ',periarg8,'   ',asc8,'   ',meanan8,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',extstr,'   ',incl8,'   ',periarg8,'   ',asc8,'   ',meanan8,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [sma8,'   ',extstr,'   ',intstr,'   ',periarg8,'   ',asc8,'   ',meanan8,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',ecc8,'   ',extstr,'   ',periarg8,'   ',asc8,'   ',meanan8,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [sma8,'   ',intstr,'   ',extstr,'   ',periarg8,'   ',asc8,'   ',meanan8,'  0.  0.  0.\n']);
                end
            else
                fprintf(fid, [sma8,'   ',ecc8,'   ',incl8,'   ',periarg8,'   ',asc8,'   ',meanan8,'  0.  0.  0.\n']);  
            end
        else
% do nothing
        end

        if mass9
            periarg9 = num2str(str2num(peri9) - str2num(asc9),14);
            meanan9 = num2str(str2num(longmean9) - str2num(peri9),14);
            fprintf(fid,['Neptune','   m=',mass9,'\n']);
            if (item_ext == 9 & item_int ~= 9)
                if item_action_ext == 1
                    fprintf(fid, [extstr,'   ',ecc9,'   ',incl9,'   ',periarg9,'   ',asc9,'   ',meanan9,'  0.  0.  0.\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [sma9,'   ',extstr,'   ',incl9,'   ',periarg9,'   ',asc9,'   ',meanan9,'  0.  0.  0.\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [sma9,'   ',ecc9,'   ',extstr,'   ',periarg9,'   ',asc9,'   ',meanan9,'  0.  0.  0.\n']);
                end
            elseif (item_ext ~= 9 & item_int == 9)
                if item_action_int == 1
                    fprintf(fid, [intstr,'   ',ecc9,'   ',incl9,'   ',periarg9,'   ',asc9,'   ',meanan9,'  0.  0.  0.\n']);
                elseif item_action_int == 2
                    fprintf(fid, [sma9,'   ',intstr,'   ',incl9,'   ',periarg9,'   ',asc9,'   ',meanan9,'  0.  0.  0.\n']);
                elseif item_action_int == 3
                    fprintf(fid, [sma9,'   ',ecc9,'   ',intstr,'   ',periarg9,'   ',asc9,'   ',meanan9,'  0.  0.  0.\n']);
                end
            elseif (item_ext == 9 & item_int == 9)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [extstr,'   ',intstr,'   ',incl9,'   ',periarg9,'   ',asc9,'   ',meanan9,'  0.  0.  0.\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [extstr,'   ',ecc9,'   ',intstr,'   ',periarg9,'   ',asc9,'   ',meanan9,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',extstr,'   ',incl9,'   ',periarg9,'   ',asc9,'   ',meanan9,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [sma9,'   ',extstr,'   ',intstr,'   ',periarg9,'   ',asc9,'   ',meanan9,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',ecc9,'   ',extstr,'   ',periarg9,'   ',asc9,'   ',meanan9,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [sma9,'   ',intstr,'   ',extstr,'   ',periarg9,'   ',asc9,'   ',meanan9,'  0.  0.  0.\n']);
                end
            else
                fprintf(fid, [sma9,'   ',ecc9,'   ',incl9,'   ',periarg9,'   ',asc9,'   ',meanan9,'  0.  0.  0.\n']);  
            end
        else
% do nothing
        end

        if mass10
            periarg10 = num2str(str2num(peri10) - str2num(asc10),14);
            meanan10 = num2str(str2num(longmean10) - str2num(peri10),14);
            fprintf(fid,['Pluto','   m=',mass10,'\n']);
            if (item_ext == 10 & item_int ~= 10)
                if item_action_ext == 1
                    fprintf(fid, [extstr,'   ',ecc10,'   ',incl10,'   ',periarg10,'   ',asc10,'   ',meanan10,'  0.  0.  0.\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [sma10,'   ',extstr,'   ',incl10,'   ',periarg10,'   ',asc10,'   ',meanan10,'  0.  0.  0.\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [sma10,'   ',ecc10,'   ',extstr,'   ',periarg10,'   ',asc10,'   ',meanan10,'  0.  0.  0.\n']);
                end
            elseif (item_ext ~= 10 & item_int == 10)
                if item_action_int == 1
                    fprintf(fid, [intstr,'   ',ecc10,'   ',incl10,'   ',periarg10,'   ',asc10,'   ',meanan10,'  0.  0.  0.\n']);
                elseif item_action_int == 2
                    fprintf(fid, [sma10,'   ',intstr,'   ',incl10,'   ',periarg10,'   ',asc10,'   ',meanan10,'  0.  0.  0.\n']);
                elseif item_action_int == 3
                    fprintf(fid, [sma10,'   ',ecc10,'   ',intstr,'   ',periarg10,'   ',asc10,'   ',meanan10,'  0.  0.  0.\n']);
                end
            elseif (item_ext == 10 & item_int == 10)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [extstr,'   ',intstr,'   ',incl10,'   ',periarg10,'   ',asc10,'   ',meanan10,'  0.  0.  0.\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [extstr,'   ',ecc10,'   ',intstr,'   ',periarg10,'   ',asc10,'   ',meanan10,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',extstr,'   ',incl10,'   ',periarg10,'   ',asc10,'   ',meanan10,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [sma10,'   ',extstr,'   ',intstr,'   ',periarg10,'   ',asc10,'   ',meanan10,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',ecc10,'   ',extstr,'   ',periarg10,'   ',asc10,'   ',meanan10,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [sma10,'   ',intstr,'   ',extstr,'   ',periarg10,'   ',asc10,'   ',meanan10,'  0.  0.  0.\n']);
                end
            else
                fprintf(fid, [sma10,'   ',ecc10,'   ',incl10,'   ',periarg10,'   ',asc10,'   ',meanan10,'  0.  0.  0.\n']);
            end
        else
% do nothing
        end
        fclose(fid);

        fid = fopen( 'small.in', 'wt');
        fprintf(fid, [')O+_06 Small-body initial data  (WARNING: Do not delete this line!!)\n']);
        fprintf(fid, ['style = Asteroidal\n']);
        if mass5
            periarg5 = num2str(str2num(peri5) - str2num(asc5),14);
            meanan5 = num2str(str2num(longmean5) - str2num(peri5),14);
            fprintf(fid,['Asteroid','   m=',mass5,'\n']);
            if (item_ext == 5 & item_int ~= 5)
                if item_action_ext == 1
                    fprintf(fid, [extstr,'   ',ecc5,'   ',incl5,'   ',periarg5,'   ',asc5,'   ',meanan5,'  0.  0.  0.\n']);
                elseif item_action_ext == 2
                    fprintf(fid, [sma5,'   ',extstr,'   ',incl5,'   ',periarg5,'   ',asc5,'   ',meanan5,'  0.  0.  0.\n']);
                elseif item_action_ext == 3
                    fprintf(fid, [sma5,'   ',ecc5,'   ',extstr,'   ',periarg5,'   ',asc5,'   ',meanan5,'  0.  0.  0.\n']);
                end
            elseif (item_ext ~= 5 & item_int == 5)
                if item_action_int == 1
                    fprintf(fid, [intstr,'   ',ecc5,'   ',incl5,'   ',periarg5,'   ',asc5,'   ',meanan5,'  0.  0.  0.\n']);
                elseif item_action_int == 2
                    fprintf(fid, [sma5,'   ',intstr,'   ',incl5,'   ',periarg5,'   ',asc5,'   ',meanan5,'  0.  0.  0.\n']);
                elseif item_action_int == 3
                    fprintf(fid, [sma5,'   ',ecc5,'   ',intstr,'   ',periarg5,'   ',asc5,'   ',meanan5,'  0.  0.  0.\n']);
                end
            elseif (item_ext == 5 & item_int == 5)
                if (item_action_ext == 1 & item_action_int == 2)
                    fprintf(fid, [extstr,'   ',intstr,'   ',incl5,'   ',periarg5,'   ',asc5,'   ',meanan5,'  0.  0.  0.\n']);
                elseif (item_action_ext == 1 & item_action_int == 3)
                    fprintf(fid, [extstr,'   ',ecc5,'   ',intstr,'   ',periarg5,'   ',asc5,'   ',meanan5,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',extstr,'   ',incl5,'   ',periarg5,'   ',asc5,'   ',meanan5,'  0.  0.  0.\n']);
                elseif (item_action_ext == 2 & item_action_int == 3)
                    fprintf(fid, [sma5,'   ',extstr,'   ',intstr,'   ',periarg5,'   ',asc5,'   ',meanan5,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 1)
                    fprintf(fid, [intstr,'   ',ecc5,'   ',extstr,'   ',periarg5,'   ',asc5,'   ',meanan5,'  0.  0.  0.\n']);
                elseif (item_action_ext == 3 & item_action_int == 2)
                    fprintf(fid, [sma5,'   ',intstr,'   ',extstr,'   ',periarg5,'   ',asc5,'   ',meanan5,'  0.  0.  0.\n']);
                end
            else
                fprintf(fid, [sma5,'   ',ecc5,'   ',incl5,'   ',periarg5,'   ',asc5,'   ',meanan5,'  0.  0.  0.\n']);  
            end
        else
% do nothing
        end
        fclose(fid);
   
        Verbose = InitData.Verbose;
        if strcmp(Verbose,'on')
            cmd_string = ['!',LaplaceDir,'/mercury6_2 1'];
        else
            cmd_string = ['!',LaplaceDir,'/mercury6_2 2'];
        end
        eval(cmd_string)
        cmd_string = ['!',LaplaceDir,'/element6'];
        eval(cmd_string)  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if exist('Earth-Mo.aei')
            movefile('Earth-Mo.aei','Earth-Moon.aei')
        end
        for k = 1:N
            movefile([char(planet(k)) '.aei'], [char(planet(k)) '.dat'])
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------- Write input and Frequency analysis -----------------------------------------------
    flag_FMFT = InitData.flag_FMFT;
    nfreq = num2str(1);
    data_sep = num2str(2*pi*100000*outstep);   
    %--------------------------------------------
    try
        [time semi ecc incl argperi longasc meananom] = ...
            textread(planetFMI_ext,'%f %f %f %f %f %f %f %*f %*f %*f %*f','headerlines',jumprow);
    catch
        warndlg('Some error occurred: the corresponding frequency and FMI values will be left blank.')
        int_count = int_count + 1;
        continue
    end
    d = size(time,1);
    ndata = num2str(2^(floor(log2(d))));
    if d < (totint/outstep);
        warndlg('Some error occurred: the corresponding frequency and FMI values will be left blank.')
        int_count = int_count + 1;
        continue
    end
    longperi = longasc + argperi;
    meanlong = longasc + argperi + meananom;
    %--------------------------------------------
    semi_x_ext = semi.*cos(pi/180*meanlong);
    semi_y_ext = semi.*sin(pi/180*meanlong);
    check = InitData.check1st1;
    if check
        fid = fopen(['input_semi.txt'], 'wt');
        fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [time'; semi_x_ext'; semi_y_ext']);
        fclose(fid);
        min_f = InitData.minfreq1;
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = InitData.maxfreq1;
        max_f = num2str(1000*max_f,'%6.12f');   
        cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
            data_sep,' ',ndata,' <input_semi.txt >FMFT_of_semi.txt'];  
        eval(cmd_string)
        try
            freq_ext_1(int_count) = textread(['FMFT_of_semi.txt'], '%f %*f %*f', 'headerlines', 4);
        catch
            warndlg('Some error occurred: the corresponding Frequency 1 value will be left blank.')
            freq_ext_1(int_count) = NaN;
        end
        delete input_semi.txt
    end
    %--------------------------------------------
    ecc_x_ext = ecc.*cos(pi/180*longperi);
    ecc_y_ext = ecc.*sin(pi/180*longperi);    
    check = InitData.check1st2;
    if check
        fid = fopen(['input_ecc.txt'], 'wt');
        fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [time'; ecc_x_ext'; ecc_y_ext']);
        fclose(fid);
        min_f = InitData.minfreq2;
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = InitData.maxfreq2;
        max_f = num2str(1000*max_f,'%6.12f');    
        cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
            data_sep,' ',ndata,' <input_ecc.txt >FMFT_of_ecc.txt'];  
        eval(cmd_string)
        try
            freq_ext_2(int_count) = textread(['FMFT_of_ecc.txt'], '%f %*f %*f', 'headerlines', 4);
        catch
            warndlg('Some error occurred: the corresponding Frequency 2 value will be left blank.')
            freq_ext_2(int_count) = NaN;
        end
        delete input_ecc.txt
    end
    %--------------------------------------------
    incl_x_ext = sin(pi/180*incl).*cos(pi/180*longasc);
    incl_y_ext = sin(pi/180*incl).*sin(pi/180*longasc);    
    check = InitData.check1st3;
    if check
        fid = fopen(['input_incl.txt'], 'wt');
        fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [time'; incl_x_ext'; incl_y_ext']);
        fclose(fid);
        min_f = InitData.minfreq3;
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = InitData.maxfreq3;
        max_f = num2str(1000*max_f,'%6.12f');   
        cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
            data_sep,' ',ndata,' <input_incl.txt >FMFT_of_incl.txt'];  
        eval(cmd_string)
        try
            freq_ext_3(int_count) = textread(['FMFT_of_incl.txt'], '%f %*f %*f', 'headerlines', 4);
        catch
            warndlg('Some error occurred: the corresponding Frequency 3 value will be left blank.')
            freq_ext_3(int_count) = NaN;
        end
        delete input_incl.txt
    end
    %--------------------------------------------
    try
        [time semi ecc incl argperi longasc meananom] = ...
            textread(planetFMI_int,'%f %f %f %f %f %f %f %*f %*f %*f %*f','headerlines',jumprow);
    catch
        warndlg('Some error occurred: the corresponding frequency and FMI values will be left blank.')
        int_count = int_count + 1;
        continue
    end
    d = size(time,1);
    if d < (totint/outstep);
        warndlg('Some error occurred: the corresponding frequency and FMI values will be left blank.')
        int_count = int_count + 1;
        continue
    end
    longperi = longasc + argperi;
    meanlong = longasc + argperi + meananom;
    %--------------------------------------------
    semi_x_int = semi.*cos(pi/180*meanlong);
    semi_y_int = semi.*sin(pi/180*meanlong);    
    check = InitData.check2nd1;
    if check
        fid = fopen(['input_semi.txt'], 'wt');
        fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [time'; semi_x_int'; semi_y_int']);
        fclose(fid);
        min_f = InitData.minfreq1;
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = InitData.maxfreq1;
        max_f = num2str(1000*max_f,'%6.12f');
        cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
            data_sep,' ',ndata,' <input_semi.txt >FMFT_of_semi.txt'];  
        eval(cmd_string)
        try
            freq_int_1(int_count) = textread(['FMFT_of_semi.txt'], '%f %*f %*f', 'headerlines', 4);
        catch
            warndlg('Some error occurred: the corresponding Frequency 1 value will be left blank.')
            freq_int_1(int_count) = NaN;
        end
        delete input_semi.txt
    end
    %--------------------------------------------
    ecc_x_int = ecc.*cos(pi/180*longperi);
    ecc_y_int = ecc.*sin(pi/180*longperi);    
    check = InitData.check2nd2;
    if check        
        fid = fopen(['input_ecc.txt'], 'wt');
        fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [time'; ecc_x_int'; ecc_y_int']);
        fclose(fid);
        min_f = InitData.minfreq2;
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = InitData.maxfreq2;
        max_f = num2str(1000*max_f,'%6.12f');   
        cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
            data_sep,' ',ndata,' <input_ecc.txt >FMFT_of_ecc.txt'];  
        eval(cmd_string)
        try
            freq_int_2(int_count) = textread(['FMFT_of_ecc.txt'], '%f %*f %*f', 'headerlines', 4);
        catch
            warndlg('Some error occurred: the corresponding Frequency 2 value will be left blank.')
            freq_int_2(int_count) = NaN;
        end
        delete input_ecc.txt
    end
    %--------------------------------------------
    incl_x_int = sin(pi/180*incl).*cos(pi/180*longasc);
    incl_y_int = sin(pi/180*incl).*sin(pi/180*longasc);    
    check = InitData.check2nd3;
    if check        
        fid = fopen(['input_incl.txt'], 'wt');
        fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [time'; incl_x_int'; incl_y_int']);
        fclose(fid);
        min_f = InitData.minfreq3;
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = InitData.maxfreq3;
        max_f = num2str(1000*max_f,'%6.12f');   
        cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
            data_sep,' ',ndata,' <input_incl.txt >FMFT_of_incl.txt'];  
        eval(cmd_string)
        try
            freq_int_3(int_count) = textread(['FMFT_of_incl.txt'], '%f %*f %*f', 'headerlines', 4);
        catch
            warndlg('Some error occurred: the corresponding Frequency 3 value will be left blank.')
            freq_int_3(int_count) = NaN;
        end
        delete input_incl.txt
    end
    %--------------------------------------------

    FMFT_pick = 2^(floor(log2(d)))/2;
    if FMFT_pick > 65536
        FMFT_pick = 65536;
    end
    n_step1 = InitData.stepFMI1;
    n_step2 = InitData.stepFMI2;
    n_step3 = InitData.stepFMI3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Compute FMI separately for int and ext, then take the semisum %%%%%%%
%%%%% NB. Questa semisomma è quella che viene riportata in figura %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    FMI1(int_count) = 0;
    FMI2(int_count) = 0;
    FMI3(int_count) = 0;
    semi_x = semi_x_int;
    semi_y = semi_y_int;
    ecc_x  = ecc_x_int;
    ecc_y  = ecc_y_int;
    incl_x = incl_x_int;
    incl_y = incl_y_int;   
    FMI_compute
    semi_x = semi_x_ext;
    semi_y = semi_y_ext;
    ecc_x  = ecc_x_ext;
    ecc_y  = ecc_y_ext;
    incl_x = incl_x_ext;
    incl_y = incl_y_ext;
    FMI_compute
    FMI1(int_count) = FMI1(int_count)/2;
    FMI2(int_count) = FMI2(int_count)/2;
    FMI3(int_count) = FMI3(int_count)/2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    View1 = InitData.View1;
    View2 = InitData.View2;
    View3 = InitData.View3;
    View4 = InitData.View4;
    extfrom = InitData.extfrom;
    extto = InitData.extto;
    extstep = InitData.extstep;
    extdelta = (extto - extfrom)/extstep;
    col_str = num2str((ext - extfrom)/extdelta + 1);
    if strcmp(View1, 'on')
        perc = int_count/(intstep + 1)*100;
        fprintf('\n\n')
        if int_count == 1;
            lgt = fprintf(['\b\bColumn ',col_str,' computed at %4.2f%%'],perc);
        else
            fprintf(repmat('\b', 1, lgt));
            lgt = fprintf(['Column ',col_str,' computed at %4.2f%%'],perc) + 2;
        end
    end
    int_count = int_count + 1;    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd ..
fid = fopen('WaitBar.txt','a');
fwrite(fid,'1');
fclose(fid);
fid = fopen('WaitBar.txt','r');
B = fread(fid,'*char');
num = str2num(B);
extstep = InitData.extstep;
total = extstep + 1;
perc = num2str(sum(num)/total*100,'%4.2f');
cd(LaplaceDir)
list = strread(cd, '%s','delimiter',strrep(filesep,'\','\\'));
dim = size(list);
curdir = list{dim(1,1), dim(1,2)};
%%%%%%%%%%%%%%%%% Display completed row/column %%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(View2, 'on')
    disp('    ')
    disp([curdir,': computation completed at ', datestr(now)])
    disp(['|===================== Total progress: ',perc,'% ========================|']);
end

if strcmp(View3, 'on')
    bar = '▓';

    while strlength(bar) < floor(0.44*str2num(perc))
        bar = [bar,'▓'];
    end
    bar = ['|',bar];
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
    Progressbar = waitbar(0,'Please wait..., LAPLACE is calculating.',...
        'Units', 'pixel', 'Position', Pos);
    waitbar(sum(num)/total, Progressbar, update);
end
disp('                                             ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------- Generate output of the function ------------------------
Y = [freq_ext_1; freq_ext_2; freq_ext_3; freq_int_1; freq_int_2; freq_int_3; FMI1; FMI2; FMI3];
delete *.txt
%%%%%%%%%%%%%%%%%%%%%%%%% End of the function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
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
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
compted = str2num(get(app.count,'Value'));
compted = compted + 1;
set(app.count,'Value', num2str(compted));

list = strread(cd, '%s','delimiter',strrep(filesep,'\','\\'));
dim = size(list);
curdir = list{dim(1,1), dim(1,2)};

partial = str2num(get(app.count,'Value'));
extstep = str2num(get(app.edit_extstep,'Value'));
total = extstep + 1;
perc = partial/total;
completed = perc*100;

extfrom = str2num(get(app.edit_extfrom,'Value'));
extto = str2num(get(app.edit_extto,'Value'));
extstep = str2num(get(app.edit_extstep,'Value'));
extdelta = (extto - extfrom)/extstep;
ext_tot = extstep + 1;
col_str = num2str((ext - extfrom)/extdelta + 1);

disp('    ')
display('------------------------------------------------------------')
display([curdir, ' -- Column ',col_str,': computation completed at ', datestr(now)])
%display([curdir, ' -- Total column computed: ', get(app.count,'Value'),...
%        ', equivalent to ',num2str(completed,'%4.2f'),'% of the total'])

%%%%%%%%%%%%%%%% Total progress %%%%%%%%%%%%%%%%%%%%%%%%%%
cd ..
failure = true;
while failure
    try
        fid = fopen('WaitBar.txt','a');
        fwrite(fid,'1');
        fclose(fid);
        failure = false;
    end
end
failure = true;
while failure
    try
        fid = fopen('WaitBar.txt','r');
        A = fread(fid,'*char');
        num = str2num(A);
        failure = false;
    end
end
ext_tot = str2num(get(app.edit_extstep,'Value')) + 1;
perc = num2str(sum(num)/ext_tot*100,'%4.2f');

cd(LaplaceDir)
list = strread(cd, '%s','delimiter',strrep(filesep,'\','\\'));
dim = size(list);
curdir = list{dim(1,1), dim(1,2)};
update = [curdir,' - Total progress: ', perc, '%.',' Starting time: ', begin];

try
    waitbar(sum(num)/ext_tot, Totalbar, update);
catch ME
    % do nothing
end

%--------------------------------------------------------------------------
cd(LaplaceDir)
disp(['|============ Total progress: ',perc,'% =============|']);
%disp('    ')
bar = '%';
while length(bar) < floor(str2num(perc))
    bar = [bar,'%'];
end
bar = ['|',bar,'|'];
cprintf([1,0,0], bar);
disp('    ')
display('------------------------------------------------------------')
%%%%%%%%%%%%%%%%%%%%%% End Total progress %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y = [freq_ext_1; freq_ext_2; freq_ext_3; freq_int_1; freq_int_2; freq_int_3; FMI1; FMI2; FMI3];
delete *.txt
%}