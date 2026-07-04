% We will use Heron's method to find the square root of a number.

function rt = sq_rt(x, guess, maxit, tolerance)

    if (nargin < 4)
        tolerance =  1e-6; % Default tolerance
    end

    if (nargin < 3)
        maxit = 1000; % Default maximum iterations
    end

    if (nargin < 2)
        guess = x / 2; % Default initial guess
    end

    old = guess;
    
    new = 0;

    for i = 1 : maxit
        new = (old + x / old) / 2;
        if (abs(new - old) < tolerance)
            rt = new;
            break;
        end
        old = new;

    end

    if (i >= maxit)
        error('Maximum iterations reached without convergence');
    end
end




