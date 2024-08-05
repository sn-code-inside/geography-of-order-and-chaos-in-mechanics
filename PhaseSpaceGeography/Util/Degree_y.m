% Add circle to degree number
ticky = get(gca,'YTickLabel');
if ischar(ticky);
    temp = ticky;
    ticky = cell(1,size(temp,1));
    for j=1:size(temp,1);
        ticky{j} = strtrim( temp(j,:) );
    end;
end;
append = char(176);
for j=1:length(ticky);
    ticky{j} = [ticky{j} append];
end;  
set(gca,'YTickLabel',ticky,'FontSize',12);