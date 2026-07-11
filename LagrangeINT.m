function yint = LagrangeINT(x, y, xint)
% This function sets up a naive Lagrange Polynomial between the given set 
% of data points (x(i), y(i)) and evaluates polynomial on xint.
% Function returns the output yint.
if length(x) ~= length(y) 
    error("Size mismatch in the input vector.");
end

n = length(x);
xint = xint(:);
L = ones(length(xint), n);

for i = 1 : n 
    

    for j = 1 : n 
        if j == i 
            continue;
        else 
            L(: , i) = L(: , i) .* ((xint - x(j)) ./ (x(i) - x(j)));
        end
    end
end
y = y(:);
yint = L * y;
yint = yint(:)';
end

