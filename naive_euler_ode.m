function [t, y] = naive_euler_ode(f, t0, tN, y0, h) 
    % This function performs naive Euler method to get the solution 
    % of the differential equation dy/dt = f(t, y);
    % Required inputs: f(derivative of the function), t0, tN, y0, and h
    % output [t, y];

    n = (tN - t0) / h;
    n = floor(n);
    % update the h
    h = (tN - t0) / n;

    t = zeros(1, n + 1);
    y = zeros(1, n + 1);

    t(1) = t0;
    y(1) = y0;

    for index = 2 : n + 1 
        t(index) = t(index - 1) + h;
        y(index) = y(index - 1) + h * f(t(index - 1), y(index - 1));
    end

end