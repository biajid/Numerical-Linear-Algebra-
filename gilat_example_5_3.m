% Example 6-3: Using polynomial regression for curve fitting of a
% stress-strain curve.
%
% A tension test is conducted for determining the stress-strain
% behavior of rubber. The data points from the test are given below.
% Determine the fourth-order polynomial that best fits the data
% points. Make a plot of the data points and the curve that
% corresponds to the polynomial.
%
%   Strain e        0    0.4   0.8   1.2   1.6   2.0   2.4
%   Stress s (MPa)  0    3.0   4.5   5.8   5.9   5.8   6.2
%
%   Strain e        2.8   3.2   3.6   4.0   4.4   4.8   5.2   5.6   6.0
%   Stress s (MPa)  7.4   9.6  15.6  20.7  26.7  31.1  35.6  39.3  41.5
%
% Determine the fourth-order polynomial that best fits the data
% points, and plot both original data points and the fitted
% polynomial curve.

Strain = 0 : 0.4 : 6;
Stress = [0 3 4.5 5.8 5.9 5.8 6.2 7.4 9.6 15.6 20.7 26.7 31.1 35.6 39.3 41.5];

C = least_sq_regression_poly(Strain, Stress, 4);

x_strain = 0 : 0.01 : 6;
y_stress = polyval(C(end : -1 : 1), x_strain);

plot(Strain, Stress, 'r*', x_strain, y_stress, 'k', 'LineWidth', 2);
xlabel('Strain', 'FontSize', 20);
ylabel('Stress (MPa)', FontSize= 20);
title('Strain vs Stress');