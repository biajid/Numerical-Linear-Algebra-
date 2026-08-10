function [curve_pts, B] = Bezier_Curve_eval(P, t)
    % Bezier_Curve_eval generates points on a Bezier curve of arbitrary 
    % degree n. 
    % Inputs : P : Matrix with control points having size n X d;
    % n : number of points, and d is the dimension of the space (2 for 2D, 3 for 3D);
    % t : column or row vector of the parameter values in [0, 1];

    % Output : [curve_pts, B] , curve_pts has (x, y) on each row.
    % and B carries the coefficient for each poitns. 

    % make t as row vector 
    t = t(:)';
    num_t = length(t);

    [n1, d] = size(P); % n1 is the number of points. 

    n = n1 - 1; % n is the degree of the polynomial.    

    B = zeros(n1, num_t); % so n1 here represents number of terms in degree
    % n polynomial, and and we evaluate weight for each grid point, so column
    % number is length(t). 
    % first row of B contains weight 0 for all grid points and so on.
    % during evaluation, we will Transpose(B) so that every power of t gets full range of points. 

    for k = 0 : n 
        B(k + 1, :) = Bernstein_Basis(k, n, t);
    end
    
    % Now we gotta be very careful. 
    % Every row of B has [nCk * t .^k * (1 - t) .^ (n - k)];
    % % we want to point for curve at each t. 
    % So for all every t  will get all point and be multiplied by different 
    % weight. 
    curve_pts = P' * B; % P is d X n1, B is n1 X num_t, so curve_pts is d X num_t.



