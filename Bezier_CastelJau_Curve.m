function points = Bezier_CastelJau_Curve(P, t)
    % This function evaluates point on curve at parameters in t.
    % Input P, t. P --> Matrix of points, where number of the column is the 
    % dimension of the space, and t --> list of parameter.
    
    n = length(t);

    Q = zeros(n, size(P, 2)); % Q will have the evaluated points on the curve at each t.

    for index = 1 : n 
        Q(index, :) = CastelJau_single_point(P, t(index));
    end

    points = Q; 
end