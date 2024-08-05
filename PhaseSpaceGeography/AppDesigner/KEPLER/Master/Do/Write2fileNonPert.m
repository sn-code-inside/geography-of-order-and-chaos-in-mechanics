%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Write to file (non perturbative)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen( 'Do/DiffEquation.m', 'wt');
fprintf(fid, 'function dotW = DiffEquation(tau,W)\n');
%--------------------------------------------------------------------------
if strcmp(get(app.Waitbars, 'Checked'),'on')
    fprintf(fid, 'global pick tau_total\n');              %%%%%%%%      waitbar
    fprintf(fid, 'if tau > pick + tau_total/100;\n');     %%%%%%%%      waitbar
    fprintf(fid, '    waitbar(tau/tau_total);\n');        %%%%%%%%      waitbar
    fprintf(fid, '    pick = tau;\n');                    %%%%%%%%      waitbar
    fprintf(fid, 'end\n');                                %%%%%%%%      waitbar
end
%--------------------------------------------------------------------------
fprintf(fid, 'dotW = zeros(8,1);\n');
fprintf(fid, '%%\n%% SUBSTITUTIONS\n%%\n');
fprintf(fid, ' tau = tau-floor(tau);\n');
fprintf(fid, ' z1 = W(1);\n z2 = W(2);\n z3 = W(3);\n z4 = W(4);\n w1 = W(5);\n w2 = W(6);\n w3 = W(7);\n w4 = W(8);\n');
%--------------------------------------------------------------------------
fprintf(fid, '%%\n%% EQUATIONS\n%%\n');

fprintf(fid, ' dotW(1) = %s;\n dotW(2) = %s;\n dotW(3) = %s;\n dotW(4) = %s;\n dotW(5) = %s;\n dotW(6) = %s;\n dotW(7) = %s;\n dotW(8) = %s;\n',...
    char(F(1)), char(F(2)), char(F(3)), char(F(4)), char(F(5)), char(F(6)), char(F(7)), char(F(8)));
fclose(fid); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%