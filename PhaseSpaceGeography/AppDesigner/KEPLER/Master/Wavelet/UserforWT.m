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
    
signal = Action.*cos(pi/180*Angl) + i*(Action.*sin(pi/180*Angl)); 
