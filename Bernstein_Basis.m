function B = Bernstein_Basis(k, n, t)
    % This function evaluates B_{k, n}(t) = nchoosek(n, k) .* t .^ k .* (1 - t) .^ (n - k);
    weight = nchoosek(n, k);

    B = weight .* (t .^ k) .* (1 - t) .^ (n - k);
end
