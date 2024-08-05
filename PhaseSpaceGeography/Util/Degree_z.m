% Add circle to degree number
tickz = get(gca,'ZTickLabel');
if ischar(tickz);
    temp = tickz;
    tickz = cell(1,size(temp,1));
    for j=1:size(temp,1);
        tickz{j} = strtrim( temp(j,:) );
    end;
end;
append = char(176);
for j=1:length(tickz);
    tickz{j} = [tickz{j} append];
end;  
set(gca,'ZTickLabel',tickz,'FontSize',10);