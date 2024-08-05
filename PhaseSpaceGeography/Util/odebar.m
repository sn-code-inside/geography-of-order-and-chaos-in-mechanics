function status = odebar(tau,W,flag)
global tau_total

if isempty(flag)
    status=0;
end

if strcmp(flag,'done')
    waitbar(1);
else
    if length(tau) > 2
        waitbar(tau(length(tau))/tau_total);
    end
end