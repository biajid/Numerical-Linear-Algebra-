% -------------------------------------------------------------------------
% Example 3.5 : Solution of a System of Nonlinear Equations
%               using Newton's Method
%
% The point of intersection between a catenary curve and an ellipse is
% determined by solving the following system of nonlinear equations:
%
%                   x/2     -x/2
%   f1(x,y) = y - (e     + e    )/2 = 0
%
%   f2(x,y) = 9x^2 + 25y^2 - 225 = 0
%
% where
%
%   f1(x,y) = 0 represents the catenary curve, and
%   f2(x,y) = 0 represents the ellipse.
%
% -------------------------------------------------------------------------
% Objective
%
% Use Newton's Method for a system of nonlinear equations to determine the
% point of intersection of the catenary curve and the ellipse that lies in
% the first quadrant of the Cartesian coordinate system.
%
% -------------------------------------------------------------------------
% In this program, Newton's Method is applied iteratively to solve the
% nonlinear system
%
%       f1(x,y) = 0
%       f2(x,y) = 0
%
% by repeatedly updating the estimates of x and y until the successive
% approximations satisfy a prescribed convergence tolerance.
%
% The resulting values of x and y represent the coordinates of the desired
% intersection point in the first quadrant.
% -------------------------------------------------------------------------

clc; clear; close all;
f1 = @(x, y) y - 0.5 .* (exp(x ./ 2) + exp(-x ./ 2));
f2 = @(x, y) 9 .* x .^ 2 + 25 .* y .^ 2 - 225;

f1x = @(x, y) -0.25 .* (exp(x ./ 2) - exp(-x ./ 2));
f1y = @(x, y) 1;
f2x = @(x, y) 18 .* x;
f2y = @(x, y) 50 .* y;

% Now define the Jacobian 
Jacob = @(x, y) -(25 / 2) .* y .* (exp(x ./ 2) - exp(-x ./ 2)) - 18 .* x;

xi = 2;
yi = 2;
tolerance = 0.0001;
maxiter = 100;


for index = 1 : maxiter
    jac = Jacob(xi, yi);
    A = [f1x(xi, yi), f1y(xi, yi); f2x(xi, yi), f2y(xi, yi)];
    delta = A \ [-f1(xi, yi); -f2(xi, yi)];
    xnew = xi + delta(1);
    ynew = yi + delta(2);
    fprintf("Iteration : %d\t, x = %.5f\t, y = %.5f\n", index, xnew, ynew);
    if norm(([xi; yi] - [xnew; ynew]) ./ [xnew; ynew]) < tolerance
        break;
    end
    xi = xnew;
    yi = ynew;
end