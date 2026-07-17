function xout = FixedPointIteration(f, guess, tol, Max_Iter)
% This function performs fixed point iteration method to get the solution
% of the equation x = f(x). 
% Required Arguments: f, guess, tolerance, and Max_Iteration.
xold = guess;
for index = 1 : Max_Iter
    xnew = f(xold);
    if abs((xnew - xold) / xold) < tol
        xout = xnew;
        return;
    end
    xold = xnew;
end

fprintf("Max Iteration % has been reached but no solution was found.\n", Max_Iter);
xout = ('No Solution');
end
