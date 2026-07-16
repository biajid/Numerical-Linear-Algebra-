function xout = brent(fun, a, b, tolerance)
% This function performs brent method to get 
% the solution of the equation fun(x) = 0, 
% where x lies between [a, b].

% Required parameter: function handle, a, b, tolerance 

% Brent's method applies a combination of : 
% 1. Bisection method
% 2. Secant method.
% 3. IQI method.

fa = fun(a);
fb = fun(b);

% First check whether we could apply bracket method at this interval
if fa * fb > 0
    error('Bracketing method would not work on the given interval.');
end

% Check whether we already have the solution 
if abs(fa) < tolerance
    xout = a;
    return;
end

if abs(fb) < tolerance
    xout = b;
    return;
end

% Initially c would contain previous value of b and d would contain 
% previous value of c.
c = a; 
fc = fa; % in this case previous value of b is actually a as we swapped.
d = c;


% we want to make sure b is always closer to the root.
% and whenever necessary we perform swap.

if abs(fa) < abs(fb)
    temp = a;
    a = b;
    b = temp;

    temp = fb;
    fb = fa;
    fa = temp;
end

% set bsectFlag to track whether the last step was bisection or not
bsectFlag = false;

maxiter = 100;
iter = 0;

while abs(fb) > tolerance && abs(b - a) > tolerance

    iter = iter + 1;
    if (iter > maxiter)
        error('Brent method tried 100 iterations, and then have to stop.');
    end

    % if fa, fb, and fc are distinct, apply IQI, else apply secant method.
    if fa ~= fb && fb ~= fc && fc ~= fa 
        s = InverseQuadraticINT(fun, a, b, c);
    else 
        s = b - (b - a) * fb / (fb - fa);
    end

    % Now the difficult part -> we have to decide whether we would 
    % choose such accelared update or should revert back to bisection
    % First check whether the s is within our interval [a, b], and not 
    % only that s has to be between b and (3*a + b) / 4. 
    flag1 = (s < min(b, (3 * a + b) / 4)) || (s > max(b, (3 * a + b) / 4));
    
    % Now check whether the last procedure was bisection; if yes the
    % current gap has to be less than half of the previous gap for the 
    % accelerated method to work.
    flag2 = bsectFlag && abs(s - b) >= abs(b - c) / 2;
    % Actually if the flag is raised then we revert to bsect

    flag3 = ~bsectFlag && abs(s - b) >= abs(c - d) / 2;
    % if previous method was not bisect, then compare to the older to the
    % previous gap. 

    
    %if those falg is raised we revert to bsect not

    if flag3 || flag2 || flag1 
        s = (a + b) / 2;
        bsectFlag = true;
    else 
        bsectFlag = false;
    end

    % Now we get s;
    % we evaluate the function at this s
    fs = fun(s);
    if abs(fs) < tolerance
        xout = s;
        return;
    end

    % now let us update the history
    d = c;
    c = b;
    fc = fb;

    % now we have to maintain the bracket
    if fa * fs < 0
        b = s;
        fb = fs;
    else
        a = s;
        fa = fs;
    end

    % and we keep b as the parent abcisa of smaller fun value.
    if abs(fa) < abs(fb) 
        temp = b;
        b = a;
        a = temp;

        temp = fb;
        fb = fa;
        fa = temp;
    end


end % this the end of the while maxiter loop

xout = b;
end
    


