% we need the function to send to ode45;
% this function evaluates the derivatives;
function dydx = auxiliary1(~, Y)
    y1 = Y(1);
    y2 = Y(2);
    eta1 = Y(3);
    eta2 = Y(4);

    dy1_dx = y2;
    dy2_dx = y1;

    deta1_dx = eta2;
    deta2_dx = eta1;

    dydx = [dy1_dx; dy2_dx; deta1_dx; deta2_dx];
end

