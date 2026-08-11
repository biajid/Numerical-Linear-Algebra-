function p = CastelJau_single_point(P, t)
    % This function evaluates/estimate points on a curve 
    % using parameter value t through the application 
    % of CastelJau algorithm on Bezier Curve with Bernstein basis.
    % Input P -> Matrix of points where each points x1, y1, z1 etc on the same row
    % and number of column in P is the dimension of the space that we are dealing with
    [n, d] = size(P);

    % This algorithm does linear approximation on two neighber and make them 1
    % so for n points it will make (n - 1) points on the first run, 
    % (n - 2) points on the second run etc. 
    % so for n points it will run (n - 1) times.
    Q = P; % At the end of the loop Q will have a single point
    for index = 1 : n - 1
        Q = (1 - t) * P(1 : end - 1, :) + t * P(2 : end, :);
        P = Q;
    end

    p = Q(1, :);
end
