% Add circle to degree number
tickx = get(gca,'XTickLabel');
if ischar(tickx);
    temp = tickx;
    tickx = cell(1,size(temp,1));
    for j=1:size(temp,1);
        tickx{j} = strtrim( temp(j,:) );
    end;
end;
for j=1:length(tickx);
    tickx{j} = [tickx{j} char(176)];
end;  
set(gca,'XTickLabel',tickx,'FontSize',12);
    