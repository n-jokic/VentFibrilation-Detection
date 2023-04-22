function rho = rho_relative_mag(sig, lag, max_lag)
    N = length(sig);
    rho = zeros(max_lag - lag, 1);
    normalisation = zeros(max_lag - lag, 1);
    
    for k = lag : max_lag
        rho(k - lag + 1) = 2*sum( max( abs(sig(k+1:N)), abs(sig(1:N-k)) ) ) ...
            .*sum( sign(sig(1:N-k).*sig(k+1:N)).*min(abs(sig(k+1:N)), ...
            abs(sig(1:N-k))) );
        normalisation(k - lag + 1) = sum( max( abs(sig(k+1:N)), abs(sig(1:N-k)) ) )^2 + ...
            sum( sign(sig(1:N-k).*sig(k+1:N)).*min(abs(sig(k+1:N)), ...
            abs(sig(1:N-k))) )^2;
    end
    
    rho = rho./normalisation;
end

