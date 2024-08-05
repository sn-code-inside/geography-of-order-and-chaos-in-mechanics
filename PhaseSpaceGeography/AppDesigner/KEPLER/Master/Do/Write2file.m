%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Write to file (perturbative)
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
if strcmp(get(app.singularity, 'Checked'),'on')
    fprintf(fid, 'if abs(W(1)*W(5)+W(2)*W(6)+W(3)*W(7)+W(4)*W(8)) > 1e-04 & abs(W(1)^2+W(2)^2+W(3)^2+W(4)^2-W(5)^2-W(6)^2-W(7)^2-W(8)^2) > 1e-04\n');
    fprintf(fid, '    close all\n');
    fprintf(fid, '    warndlg({''Sorry, PROBABLY either the problem is singular or the point is escaping to infinity (but I am a bit paranoic).'';''Compare with Integrate of the Standard method and, in case, disable the Watch falling into singularities in Window menu.'';''           KEPLER stops here.''})\n');
    fprintf(fid, '    clear DiffEquation\n');
    fprintf(fid, '    return\n');
    fprintf(fid, 'end\n');
end
%--------------------------------------------------------------------------
fprintf(fid, 'dotW = zeros(8,1);\n');
fprintf(fid, '%%\n%% SUBSTITUTIONS\n%%\n');
fprintf(fid, ' tau = tau-floor(tau);\n');
fprintf(fid, ' U1 = W(1);\n U2 = W(2);\n U3 = W(3);\n U4 = W(4);\n V1 = W(5);\n V2 = W(6);\n V3 = W(7);\n V4 = W(8);\n');
fprintf(fid, ' Ko  = 1/2*(sqrt(U1^2+U2^2+U3^2+U4^2)+sqrt(V1^2+V2^2+V3^2+V4^2));\n');
fprintf(fid, ' G1 = (U2*V3-U3*V2)/Ko;\n');
fprintf(fid, ' G2 = (U3*V1-U1*V3)/Ko;\n');
fprintf(fid, ' G3 = (U1*V2-U2*V1)/Ko;\n');
fprintf(fid, ' A1 = (U4*V1-U1*V4)/Ko;\n');
fprintf(fid, ' A2 = (U4*V2-U2*V4)/Ko;\n');
fprintf(fid, ' A3 = (U4*V3-U3*V4)/Ko;\n');
fprintf(fid, '  x = (Ko-U4*sin(2*pi*tau)+V4*cos(2*pi*tau));\n');
fprintf(fid, ' x1 = (U1*cos(2*pi*tau)+V1*sin(2*pi*tau)-A1);\n');
fprintf(fid, ' x2 = (U2*cos(2*pi*tau)+V2*sin(2*pi*tau)-A2);\n');
fprintf(fid, ' x3 = (U3*cos(2*pi*tau)+V3*sin(2*pi*tau)-A3);\n');
fprintf(fid, ' y1 = (-U1*sin(2*pi*tau)+V1*cos(2*pi*tau))/x;\n');
fprintf(fid, ' y2 = (-U2*sin(2*pi*tau)+V2*cos(2*pi*tau))/x;\n');
fprintf(fid, ' y3 = (-U3*sin(2*pi*tau)+V3*cos(2*pi*tau))/x;\n');
fprintf(fid, ' PI = pi;\n');
%--------------------------------------------------------------------------
if strcmp(get(app.watch, 'Checked'),'on')
    fprintf(fid, 'x_vec = [x1 x2 x3];\n');
    fprintf(fid, 'y_vec = [y1 y2 y3];\n');   
    fprintf(fid, 'if abs(x*((y1^2+y2^2+y3^2+1)/2+Kp(x_vec,y_vec))-1) > 1e-02;\n');
    fprintf(fid, '    warndlg({''Sorry, large numerical error, output not reliable''})\n');
    fprintf(fid, '    clear DiffEquation\n');
    fprintf(fid, '    return\n');
    fprintf(fid, 'end\n');
end
%--------------------------------------------------------------------------
fprintf(fid, '%%\n%% EQUATIONS\n%%\n');
fprintf(fid, ' dotW(1) = %s; \n dotW(2) = %s; \n dotW(3) = %s;\n dotW(4) = %s;\n dotW(5) = %s;\n dotW(6) = %s;\n dotW(7) = %s;\n dotW(8) = %s;\n',...
        char(F(1)), char(F(2)), char(F(3)), char(F(4)), char(F(5)), char(F(6)), char(F(7)), char(F(8)));
fclose(fid);

