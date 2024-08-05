  %  if x(1) < -eps
  %      x = x + 360;
  %  end    
    n_tot = size(x,1);
    for k = 1 : n_tot-1
        if x(k+1) - x(k) < -180
            for j = k+1 : n_tot
                x(j) = x(j) + 360;
            end
        elseif x(k+1) - x(k) > 180
            for j = k+1 : n_tot
                x(j) = x(j) - 360;
            end
        else
        % do nothing
        end
    end