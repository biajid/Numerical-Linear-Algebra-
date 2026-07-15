function xns = pegasus(fun, a, b, tolerance)
% This function performs Pegasus method to get the solution 
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

xaold = xa;
xbold = xb;

while toli > tolerance
    if c > 0
       a = xns;
       xaold = xa;
       xa = c;
       xb = xb * xaold / (xaold + c);

       
    else
       b = xns;
       xbold = xb;
       xb = c;
       xa = xa * xbold / (xbold + c); 

    end

    



    xns = (a * xb - b * xa) / (xb - xa);
    c = fun(xns);
    
    if c == 0
        return;
    end

    

    toli = abs(c);
end

end



    






