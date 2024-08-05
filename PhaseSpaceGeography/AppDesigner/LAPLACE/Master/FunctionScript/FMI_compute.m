    if n_step1 > 0
        delta_step = floor((d - FMFT_pick)/n_step1);
        for rr = 1:n_step1 + 1
            fid = fopen(['input_semi_',num2str(rr),'.txt'], 'wt');
            fprintf(fid, '%14.10f %14.10f %14.10f\n',...
                [time(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
            semi_x(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
            semi_y(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)']);
            fclose(fid);
        end
    end

    if n_step2 > 0
        delta_step = floor((d - FMFT_pick)/n_step2);
        for rr = 1:n_step2 + 1
            fid = fopen(['input_ecc_',num2str(rr),'.txt'], 'wt');
            fprintf(fid, '%14.10f %14.10f %14.10f\n',...
                [time(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
            ecc_x(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
            ecc_y(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)']);
            fclose(fid);
        end
    end

    if n_step3 > 0
        delta_step = floor((d - FMFT_pick)/n_step3);
        for rr = 1:n_step3 + 1
            fid = fopen(['input_incl_',num2str(rr),'.txt'], 'wt');
            fprintf(fid, '%14.10f %14.10f %14.10f\n',...
                [time(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
            incl_x(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)';...
            incl_y(((rr - 1)*delta_step + 1) : (rr - 1)*delta_step + FMFT_pick)']);
            fclose(fid);
        end
    end
%----------------- Delete files--------------------------------------------
    delete *.dat *.dmp *.tmp *.out
%---------------------- FMI -----------------------------------------------
    str_FMFT_pick = num2str(FMFT_pick);

    if n_step1 > 0
        min_f = InitData.minfreq1;
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = InitData.maxfreq1;
        max_f = num2str(1000*max_f,'%6.12f');

        for rr = 1:n_step1 + 1
            cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                data_sep,' ',str_FMFT_pick,' ','<input_semi_',num2str(rr),'.txt',' ','>FMFT_of_semi_',num2str(rr),'.txt'];  
            eval(cmd_string)
            try
                freq(rr) = textread(['FMFT_of_semi_',num2str(rr),'.txt'], '%f %*f %*f', 'headerlines', 4);
            catch
                warndlg('Some error occurred: the corresponding FMI 1 value will be left blank.')
                freq = NaN*ones(1,n_step1 + 1);
                break
            end
        end

        freq_min = min(freq);
        freq_max = max(freq);

        if abs((freq_max - freq_min)/(freq_max + freq_min)) > 1e-12
            FMI1(int_count) = FMI1(int_count) + log10(abs((freq_max - freq_min)./(freq_max + freq_min)));
        elseif (isnan(freq_min) | isnan(freq_max))
            FMI1(int_count) = NaN;
        else          
            FMI1(int_count) = FMI1(int_count) - 12;
        end
    end

    if n_step2 > 0
        min_f = InitData.minfreq2;
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = InitData.maxfreq2;
        max_f = num2str(1000*max_f,'%6.12f'); 

        for rr = 1:n_step2 + 1
            cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                data_sep,' ',str_FMFT_pick,' ','<input_ecc_',num2str(rr),'.txt',' ','>FMFT_of_ecc_',num2str(rr),'.txt'];  
            eval(cmd_string)
            try
                freq(rr) = textread(['FMFT_of_ecc_',num2str(rr),'.txt'], '%f %*f %*f', 'headerlines', 4);
            catch
                warndlg('Some error occurred: the corresponding FMI 2 value will be left blank.')
                freq = NaN*ones(1,n_step1 + 1);
                break
            end
        end

        freq_min = min(freq);
        freq_max = max(freq);

        if abs((freq_max - freq_min)/(freq_max + freq_min)) > 1e-12
            FMI2(int_count) = FMI2(int_count) + log10(abs((freq_max - freq_min)./(freq_max + freq_min)));
        elseif (isnan(freq_min) | isnan(freq_max))
            FMI2(int_count) = NaN;
        else          
            FMI2(int_count) = FMI2(int_count) - 12;
        end
    end

    if n_step3 > 0
        min_f = InitData.minfreq3;
        min_f = num2str(1000*min_f,'%6.12f');
        max_f = InitData.maxfreq3;
        max_f = num2str(1000*max_f,'%6.12f');    

        for rr = 1:n_step3 + 1
            cmd_string = ['!',PhSpGeoDir,'/AddedODEsolver/bin/main_fmft ',min_f,' ',max_f,' ',flag_FMFT,' ',nfreq,' ',...
                data_sep,' ',str_FMFT_pick,' ','<input_incl_',num2str(rr),'.txt',' ','>FMFT_of_incl_',num2str(rr),'.txt'];  
            eval(cmd_string)
            try
                freq(rr) = textread(['FMFT_of_incl_',num2str(rr),'.txt'], '%f %*f %*f', 'headerlines', 4);
            catch
                warndlg('Some error occurred: the corresponding FMI 3 value will be left blank.')
                freq = NaN*ones(1,n_step1 + 1);
                break
            end                
        end

        freq_min = min(freq);
        freq_max = max(freq);

        if abs((freq_max - freq_min)/(freq_max + freq_min)) > 1e-12
            FMI3(int_count) = FMI3(int_count) + log10(abs((freq_max - freq_min)./(freq_max + freq_min)));
        elseif (isnan(freq_min) | isnan(freq_max))
            FMI3(int_count) = NaN;
        else          
            FMI3(int_count) = FMI3(int_count) - 12;
        end
    end
    delete *.txt