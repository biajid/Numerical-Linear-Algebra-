function xns = bisection(fun, a, b, tolerance)
% This function performs bisection to get the solution 
% of the equation fun(x) = 0.
% Parameters are fun : function handle, a = left boundary, b = right
% boundary, and tolerance is for stopping criteria 
xa = fun(a);
xb = fun(b);

if xa * xb > 0
    error('Bracketing method would not work because both guess is in the same side!');
end

xns = (a + b) / 2;
c = fun(xns);


toli = (b - a) / 2;

while toli > tolerance
    if xa * c > 0
        a = xns;
        xa = fun(a);
    else 
        b = xns;
        xb = fun(b);
    end

    xns = (a + b) / 2;
    c = fun(xns);

    

    toli = (b - a) / 2;
end

end



    






