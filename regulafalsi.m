function xns = regulafalsi(fun, a, b, tolerance)
% This function performs Regula Flasi method to get the solution 
% of the equation fun(x) = 0.
% Parameters are fun : function handle, a = left boundary, b = right
% boundary, and tolerance is for stopping criteria 
xa = fun(a);
xb = fun(b);

if xa * xb > 0
    error('Bracketing method would not work because both guess is in the same side!');
end

if (xa < 0)
    dummy = b;
    b = a;
    a = dummy;

    dummy = xb;
    xb = xa;
    xa = dummy;
end


xns = (a * xb - b * xa) / (xb - xa);
c = fun(xns);


toli = abs(c);

while toli > tolerance
    if c > 0
       a = xns;
       xa = c;
    else
       b = xns;
       xb = c;
    end

    xns = (a * xb - b * xa) / (xb - xa);
    c = fun(xns);
    
    if c == 0
        return;
    end

    

    toli = abs(c);
end

end



    






