function xout = NewtonRoot(fun, funDer, guess, err_tol, imax)
% This function performs Newton's method to get the solution of 
% the equation f(x) = 0.
% Required args : function, function derivative, guess, tolerance, and 
% maximum iteration. 

for index = 1 : imax
    x = guess - fun(guess) / funDer(guess);
    if abs((x - guess) / guess) < err_tol
        xout = x;
        return
    end
    guess = x;
end

fprintf("Solution was not achieved in %d iteration.\n", imax);
xout = ('No Solution!');
end
