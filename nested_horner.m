function y = nested_horner(p, x)
    % Evaluates a polynomial at a given point x using nested Horner's method.
    % p is a vector of polynomial coefficients in descending order.
    % x is the point at which to evaluate the polynomial.
    % y is the resulting value of the polynomial at x.
    % polynomial is given similar as Matlab polyval
    % for example, if p = [2 3 4] and x = 5, the polynomial is 2*x^2 + 3*x + 4 and the function evaluates it at x = 5.
    
    n = length(p);

    if n == 1
        y = p(1);
        return
    end
    
    start = p(1);
    for ii = 2 : n 
        start = start * x + p(ii);
    end

    y = start;