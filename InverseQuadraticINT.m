function xnew = InverseQuadraticINT(fun, x0, x1, x2)
% This function performs one step inverse quadratic interpolation 
% on the three guess x0, x1, x2 to get an approximate solution
% of the fun(x) = 0 equation
y0 = fun(x0);
y1 = fun(x1);
y2 = fun(x2);

if y0 == y1 || y1 == y2 || y2 == y0 
    error("IQI requires three different y values.");
end

xnew = LagrangeINT([y0, y1, y2], [x0, x1, x2], 0);
end
