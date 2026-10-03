function y = my_polynomial_addition(p, q)
    % This function performs addition of two 
    % polynomials p and q.
    % It returns the resultant polynomial of appropriate degree.
    % Polynomial is expected to be of descending order of powers. 
    % for example: p = [1, 2, 3, 4] would imply 
    % x^3 + 2 * x ^ 2 + 3 * x + 4;

    ap = length(p);
    aq = length(q);
    maxLen = max(ap, aq);
    
    newP = zeros(1, maxLen);
    newQ = zeros(1, maxLen);
    newP(end : -1 : (maxLen - ap + 1)) = p(end : -1 : 1);
    newQ(end : -1 : (maxLen -aq + 1)) = q(end : -1 : 1);

    y = newP + newQ;
end

    