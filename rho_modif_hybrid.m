function rho = rho_modif_hybrid(sig, lag, max_lag)
    N = length(sig);
    rho = zeros(max_lag - lag, 1);
    normalisation = zeros(max_lag - lag, 1);
    
    for k = lag : max_lag
        rho(k - lag + 1) = sum((abs(sig(k+1:N)) + abs(sig(1:N-k))) ...
            .*sign(sig(1:N-k).*sig(k+1:N)));
        normalisation(k - lag + 1) = sum(abs(sig(k+1:N)) + abs(sig(1:N-k)));
    end
    
    rho = rho./normalisation;
end

