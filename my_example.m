%% Introduction to Matlab
clc
disp("Hello World\n")
x = 1 + 2
x = x ^ 2
y = x ^ 3

%Matrices
%help sin
%help sin
%%Matrices
% Generate Matrix
A = [1, 2, 3, 4, 5]
B = [1 2 3 4 5]

%Colon notation
C = 1 : 5;
D = 1 : 1 : 5;
E = 1 : 0.5 : 5;
% linspace
x = linspace(1, 10, 20);
x2 = linspace(1, 10);
% one dimensional line of numbers is called vectors

%Generate matrix
A = [1 2 3;
     4 5 6;
     7 8 9]

%Referencing Individual Entries
A(2, 1);
A(2 : 3, 3);
A(2, :);
B = [2 3 5;
      4 5 7;
      1 9 2]

A + B
D = A * B
%% Element by element operation
E = A .* B
F = A .^ 2;
disp(F)
A = [1 2 3;
     4 5 6;
     7 8 9]
A1 = A^3;
A;
L = A .^ 3;
F = 1 : 6
x = 0 : 5
k = 0.5
U = k * F .* x .^ 2
x = linspace(0, 10);
y = x .^ 2
plot(x, y)
figure
z = x .^ 3
plot(x, z)

xlabel("x")
ylabel("y")
title("x vs y")
legend("y = x^2")
grid on

x = linspace(0, 10);
y1 = sin(x);
y2 = cos(x);
figure
hold on
plot(x, y1, "r-")
plot(x, y2, "b.-")
xlabel("x")
ylabel("y")
title("x vs y")
legend("y = sin(x)", "y = cos(x)")
grid on
hold off

x2 = linspace(0, 10, 20);
y2 = 2 * x2;
z2 = 0.5 * x2 .^ 2;
hold on
subplot(2, 1, 1)
plot(x2, y2, "r-")
xlabel("x")
ylabel("y")
title("x vs y")
legend("y = 2x")
subplot(2, 1, 2)
plot(x2, z2, "b.-")
xlabel("x")
ylabel("y")
title("x vs y")
legend("y = 0.5x^2")
grid on
hold off



