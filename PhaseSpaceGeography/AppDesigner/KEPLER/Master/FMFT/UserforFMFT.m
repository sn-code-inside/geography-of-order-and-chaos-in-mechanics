%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
KeplerDir = cd;
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputUser.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('FMFT/inputUser.txt', 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau'; (Action.*cos(pi/180*Angl))'; (Action.*sin(pi/180*Angl))']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
