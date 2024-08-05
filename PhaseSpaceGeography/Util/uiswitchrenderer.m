function uiswitchrenderer(hFig)
% UISWITCHRENDERER adds a pushtool to the figure toolbar for the direct renderer choosing.
%
% UISWITCHRENDERER 
%     adds the pushtool to the current figure.
%
% UISWITCHRENDERER(hFig)
%     adds the pushtool to the figure with handle hFig.
%
% UISWITCHRENDERER('auto')
%     adds the pushtool to the each new created figure automatically.
%
% UISWITCHRENDERER('remove')
%     remove the automatically adding of pushtools for new figures.
%
% Two reasons to set the renderer yourself are
%  * To make your printed or exported figure look the same as it did on the 
%    screen. The rendering method used for printing and exporting the figure 
%    is not always the same method used to display the figure.
%
%  * To avoid unintentionally exporting your figure as a bitmap within a vector 
%    format. For example, high-complexity MATLAB plots typically render using 
%    OpenGL or Z-buffer. If you export a high-complexity figure to the EPS or 
%    EMF vector formats without specifying a rendering method, either OpenGL or 
%    Z-buffer might be used, each of which creates bitmap graphics. Storing a 
%    bitmap in a vector file can generate a very large file that takes a long 
%    time to print. If you use one of these formats and want to make sure that 
%    your figure is saved as a vector file, be sure to set the rendering method
%    to Painter's.
%
%
% Version v1.03
% last update: 26-Mar-2008
% Author: Elmar Tarajan [MCommander@gmx.de]

if nargin==0
   hFig = gcf;
else
   switch hFig
      case 'auto'
         setappdata(0,'myListener',handle.listener(0,'ObjectChildAdded','try;uiswitchrenderer;end'))
      case 'remove'
         if isappdata(0,'myListener')
            rmappdata(0,'myListener')
         end% if
   end% switch
   return
end% if
%
hToolbar = findall(hFig,'Type','uitoolbar');
if ~isempty(hToolbar) && isempty(findall(hFig,'Type','uipushtool','Tag','uiswitchrenderer'))
   %
   hPush = uipushtool('parent',hToolbar, ...
                      'separator','on', ...
                      'HandleVisibility','off', ...
                      'TooltipString','Current Renderer', ...
                      'tag','uiswitchrenderer');
   update_pushtool([],[],hFig,hPush)
   %
   addmylistener(hFig,'Renderer','PropertyPostSet',{@update_pushtool,hFig,hPush})
   %
end% if


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function update_pushtool(cnc1,cnc2,hFig,hPush)
%-------------------------------------------------------------------------------
if ~ishandle(hPush)
   return
end% if
%
switch lower(get(hFig,'renderer'))
   case 'opengl'
      img = repmat([ ...
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN 0.3 0.3 0.4 NaN 0.3 0.3 0.4 NaN 0.3 0.3 0.4 0.3 NaN NaN 0.3
         0.3 0.7 NaN 0.3 0.4 0.3 0.7 0.3 0.4 0.3 0.7 0.7 0.3 0.3 NaN 0.3
         0.3 0.7 NaN 0.3 0.4 0.3 0.7 0.3 0.4 0.3 0.3 0.4 0.3 0.7 0.3 0.3
         0.3 0.7 NaN 0.3 0.4 0.3 0.3 0.4 0.7 0.3 0.7 0.7 0.3 0.7 0.7 0.3
         0.7 0.3 0.3 0.4 0.7 0.3 0.7 0.7 0.7 0.3 0.3 0.4 0.3 0.7 NaN 0.3
         NaN 0.7 0.7 0.7 NaN 0.7 0.7 NaN NaN NaN 0.7 0.7 0.7 0.7 NaN 0.7
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN 0.3 0.3 0.3 0.3 0.3 0.3 0.3 NaN 0.3 0.3 0.3 NaN NaN NaN NaN
         0.3 0.3 0.3 0.7 0.7 0.7 0.7 0.7 0.7 0.3 0.3 0.3 0.7 NaN NaN NaN
         0.3 0.3 0.3 0.7 NaN 0.3 0.3 0.3 NaN 0.3 0.3 0.3 0.7 NaN NaN NaN
         0.3 0.3 0.3 0.7 NaN NaN 0.3 0.3 0.7 0.3 0.3 0.3 0.7 NaN NaN NaN
         0.3 0.3 0.3 0.7 NaN NaN 0.3 0.3 0.7 0.3 0.3 0.3 0.7 NaN 0.3 0.3
         0.7 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.7 0.3 0.3 0.3 0.3 0.3 0.3 0.3
         NaN 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 NaN 0.7 0.7 0.7 0.7 0.7 0.7
         ],[1 1 3]);
      next = 'zbuffer';      
      %
   case 'zbuffer'
      img = repmat([ ...
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.7 NaN NaN NaN
         NaN NaN NaN NaN 0.3 0.3 0.7 0.7 0.3 0.3 0.3 0.7 NaN NaN NaN NaN
         NaN NaN NaN NaN NaN 0.7 0.7 0.3 0.3 0.3 0.7 NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN 0.3 0.3 0.3 0.7 NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN 0.3 0.3 0.3 0.7 NaN 0.3 0.3 NaN NaN NaN NaN
         NaN NaN NaN NaN 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.7 NaN NaN NaN
         NaN NaN NaN NaN NaN 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         0.4 0.3 0.3 0.4 NaN 0.3 0.4 0.0 0.4 0.3 0.4 0.3 0.3 0.4 0.3 0.3
         0.4 0.7 0.3 0.4 0.7 0.3 0.4 0.7 0.4 0.7 0.4 0.7 NaN 0.4 0.7 0.3
         0.4 0.3 0.7 0.4 0.7 0.3 0.4 0.0 0.4 0.3 0.4 0.3 NaN 0.4 0.3 0.3
         0.4 0.7 0.3 0.4 0.4 0.3 0.4 0.7 0.4 0.7 0.4 0.7 0.7 0.4 0.3 0.7
         0.4 0.3 0.3 0.7 0.3 0.7 0.3 0.7 0.3 0.7 0.3 0.3 0.3 0.4 0.7 0.3
         NaN 0.7 0.7 NaN 0.7 NaN 0.7 NaN 0.7 NaN 0.7 0.7 0.7 0.7 NaN 0.7
         ],[1 1 3]);
      next = 'painters';      
      %
   case 'painters'
      img = repmat([ ...
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN 0.3 NaN NaN NaN NaN NaN NaN
         0.0 0.3 0.3 NaN NaN 0.3 0.3 NaN 0.6 0.7 0.6 0.3 NaN NaN 0.3 NaN
         0.0 0.7 NaN 0.4 0.3 0.7 0.7 0.3 NaN 0.3 0.6 0.3 0.3 NaN 0.3 0.7
         0.0 0.7 NaN 0.4 0.3 0.7 NaN 0.3 0.7 0.3 0.7 0.3 0.7 0.3 0.3 0.7
         0.0 0.3 0.3 0.7 0.3 0.3 0.3 0.3 0.7 0.3 0.7 0.3 0.7 0.7 0.3 0.7
         0.0 0.7 0.7 NaN 0.3 0.7 NaN 0.3 0.6 0.3 0.6 0.3 0.7 NaN 0.3 0.7
         NaN 0.7 NaN NaN NaN 0.7 NaN NaN 0.7 0.7 0.7 0.7 0.7 NaN NaN 0.7
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.4 0.3 0.3 0.3 NaN NaN 0.3 0.3 0.3
         NaN 0.7 0.3 0.7 0.4 0.7 0.7 0.7 0.3 0.7 0.7 0.3 0.4 0.7 0.7 0.7
         NaN NaN 0.3 0.7 0.4 0.3 0.3 NaN 0.3 0.7 NaN 0.3 0.7 0.3 0.3 NaN
         NaN NaN 0.3 0.7 0.4 0.7 0.7 0.7 0.3 0.3 0.3 0.7 NaN 0.7 0.7 0.3
         NaN NaN 0.3 0.7 0.4 0.3 0.3 0.4 0.3 0.7 0.5 0.3 0.6 0.3 0.3 0.7
         NaN NaN NaN 0.7 NaN 0.7 0.7 0.7 0.7 0.7 NaN 0.7 0.7 0.7 0.7 NaN
         ],[1 1 3]);      
      next = 'opengl';
      %
   case 'none'
      img = repmat([ ...
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         0.3 NaN NaN 0.3 NaN 0.3 0.3 0.3 NaN 0.4 NaN NaN 0.3 0.4 0.3 0.3
         0.3 0.3 NaN 0.3 0.4 0.7 0.7 0.7 0.3 0.4 0.3 NaN 0.3 0.4 0.7 0.7
         0.3 0.7 0.3 0.3 0.4 0.7 NaN NaN 0.3 0.4 0.7 0.3 0.3 0.4 0.3 NaN
         0.3 0.7 0.7 0.3 0.4 0.7 NaN 0.7 0.3 0.4 0.7 0.7 0.3 0.4 0.7 0.7
         0.3 0.7 NaN 0.3 0.7 0.3 0.3 0.3 0.7 0.4 0.7 NaN 0.3 0.4 0.3 0.3
         NaN 0.7 NaN NaN 0.7 0.7 0.7 0.7 NaN 0.7 0.7 NaN 0.7 0.7 0.7 0.7
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         ],[1 1 3]);
      next = 'opengl';
      %
end% switch
%
set(hPush,'cdata',img,'clickedcallback',sprintf('set(gcbf,''renderer'',''%s'')',next))
  %
  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function addmylistener(hObj,feature,action,callback)
%-------------------------------------------------------------------------------
% The code below has been adapted from the undocumented and unsupported 
% ADDLISTENER function which is located in the uitools folder.
hContainer = handle(hObj);
hSrc = hContainer.findprop(feature);
hl = handle.listener(hContainer,hSrc,action,callback);
%
hC = hContainer;
p = findprop(hC, 'Listeners__');
if (isempty(p))
   p = schema.prop(hC, 'Listeners__', 'handle vector');
   % Hide this property and make it non-serializable and
   % non copy-able.
   set(p,'AccessFlags.Serialize','off', ...
         'AccessFlags.Copy','off',...
         'FactoryValue',[],'Visible','off');
end% if
% filter out any non-handles
hC.Listeners__ = hC.Listeners__(ishandle(hC.Listeners__));
hC.Listeners__ = [hC.Listeners__; hl];
  %
  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% I LOVE MATLAB! You too? :) %%%