% This is an example from Amos Gilat's Numerical Analysis text
% Here we are modeling a spring under sudden disturbance

% spring constant is k;
% Spring Force is F = kx;
% Net force is zero, meaning right side and left side of each spring
% would feel the same amount of force;

k = [8, 9, 15, 12, 10, 18] * 1000;
l = [0.18, 0.22, 0.26, 0.19, 0.15, 0.30];
L = 1.5;

% Here we have six spring, for which we will device five set of equations
% for five intermediate nodes

% Convention for the sign 
% outgoing force at a node is negative 
% Incoming force to a node is positive

% For first spring
%{  
    First Node: 
    -k(1) * (x1 - l(1)) + k2 * (x2 - x1 - l(2)) = 0;
    Second Node:
    -k(2) * (x2 - x1 - l(2)) + k(3) * (x3 - x2 - l(3)) = 0;
    Third Node:
    -k(3) * (x3 - x2 - l(3)) + k(4) * (x4 - x3 - l(4)) = 0;
    Fourth Node:
    -k(4) * (x4 - x3 - l(4)) + k(5) * (x5 - x4 - l(5)) = 0;
    Fifth Node:
    -k(5) * (x5 - x4 - l(5)) + k(6) * (L - x5 - l(6)) = 0;

%}
% Now we will put this system into Matrix A, which is tridiagonal, and
% vector b
A = zeros(5, 5);
for i = 1 : 5
    A(i, i) = k(i) + k(i + 1);
end
for i = 1 : 4
    A(i, i + 1) = -k(i + 1);
    A(i + 1, i) = -k(i + 1);
end

b = zeros(5, 1);

for i = 1 : 4
    b(i) = k(i) * l(i) - k(i + 1) * l(i + 1);
end
b(end) = k(end -1) * l(end - 1) + k(end) * L - k(end) * l(end);

x = Tridiagonal(A, b)
