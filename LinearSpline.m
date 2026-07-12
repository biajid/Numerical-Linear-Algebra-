function yint = LinearSpline(x, y, xint)
% This function linear spline on x and y vector, and evaluates 
% the spline on xint to return yint.
n = length(x);

if n ~= length(y)
    error("Size Mismatch!");
end
x = x(:)';
y = y(:)';
xint = xint(:)';
yint = zeros(1, length(xint));

[x, index] = sort(x);
y = y(index);


for m = 1 : length(xint)
    if xint(m) < x(1) || xint(m) > x(n)
        error("The interpolation point is outside the data range.");
    end
    
    for i = 1 : n 
        if(xint(m) < x(i))
            yint(m) = LagrangeINT([x(i - 1 : i)], [y(i - 1 : i)], xint(m));
            break;
        else 
            continue;
        end
    end
end

