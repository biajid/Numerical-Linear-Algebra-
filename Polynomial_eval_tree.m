function y = Polynomial_eval_tree(P, x)
% This function evaluates polynomial P at points X using even/odd recursive tree
%
% Inputs:
%   P - Coefficients from LOWEST power to HIGHEST power
%       e.g., [3, 2, 5, 4] for P(x) = 3 + 2x + 5x^2 + 4x^3
%   X - Array of sample points (must have length equal to length of P)
%
% Output:
%   Y - Evaluated values of P(x) for each x in X.
% This recursive function has cost of O(n1 * log(n2)), 
% where n1 = length(x), and n2 = degree of the polynomial.

    n = length(P);

    if n == 1
        y = P(1) .* ones(1, n);
        return;
    end

    p_even = P(1 : 2 : end);
    p_odd = P(2 : 2 : end);

    y = Polynomial_eval_tree(p_even, x .^ 2) + x .* Polynomial_eval_tree(p_odd, x .^ 2);
end
