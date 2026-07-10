% Example 6.2 - Gilat, Numerical Analysis (3rd Edition)
%
% Curve Fitting with an Exponential Function
%
% An experiment is performed using an RC circuit to determine the
% capacitance of an unknown capacitor. A 5-MΩ resistor is connected
% in series with the unknown capacitor and a battery.
%
% After the switch is closed, the voltage across the resistor is
% measured every 2 seconds for a total of 30 seconds.
%
% The experimental data are:
%
%   t (s):      2    4    6    8   10   12   14   16   18
%   vR (V):   9.7  8.1  6.6  5.1  4.4  3.7  2.8  2.4  2.0
%
%   t (s):     20   22   24   26   28   30
%   vR (V):   1.6  1.4  1.1  0.85 0.69 0.60
%
% The voltage across the resistor is theoretically modeled by
%
%           vR(t) = V * exp(-t / (R*C))
%
% where
%       V : battery voltage
%       R : resistance (5 MΩ)
%       C : unknown capacitance
%
% Write a MATLAB program that determines the best-fit exponential
% function by converting the model into a linear form and applying
% the least-squares method.
%
% Using the fitted equation, determine the capacitance C of the
% unknown capacitor.
%
% (Hint: Take the natural logarithm of both sides to obtain a linear
% equation suitable for linear regression.)

t = 2 : 2 : 30;
vR = [9.7, 8.1, 6.6, 5.1, 4.4, 3.7, 2.8, 2.4, 2.0, 1.6, 1.4, 1.1, 0.85, 0.69, 0.60];

% We are fitting this equation : 
% log(vR) = (-1/(RC)) * t + log(V) ;
logvR = log(vR);

[c, d] = LinearRegression(t, logvR);

% Now a1 = -(1/(RC));
% Here in our experiment R = 5 Mohm = 5 * 10^6 ohm;
% so RC = - 1/a1; C = -1 / (a1 * R)

R = 5e6;
C = -1 / (R * c);

fprintf('Capacitance is : %.3e micro-faraday\n', C * 1e6);

% Now we will do plotting 
% Plot the original data and the fitted exponential curve
loga_V = d;
V = exp(loga_V);

vfit = V * exp(-t ./ (R * C));

figure;
plot(t, vR, '*r', t, vfit, 'k', 'LineWidth', 2);
xlabel('Time (second)');
ylabel('Voltage (volt)');
title('Voltage in a Resistor while capacitor is charging.')