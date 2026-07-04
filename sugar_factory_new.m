clear all; close all; clc;

target = 12000;
numMonths = 24;
prevProd = 6000;
month0 = 0;
intialworkers = 300;

%column1 = month;
%column2 = workers chosen;
%column3 = production obtained;

history = [month0, intialworkers, prevProd];
workers = intialworkers;
figure;
plot(history(:, 1), history(:, 3), 'ko-', 'LineWidth', 2, 'MarkerSize', 8);
hold on;
yline(target, 'r--', 'Target = 12000');
xlim([0 numMonths]);
xlabel("Month");
ylabel('Sugar Production');
title('Sugar Factory Control Simulation');
grid on;
% = input('How many workers to begin with?')
for ii = 1 : numMonths;

	fprintf("Months : %d\n", ii)
	fprintf("Previous Months Production: %.2f\n", prevProd);

	%get the worker needed from the manager: 
	%workers = input('How many workers you want to hire? : ');
	currentProd = 20 * workers - prevProd;

	%Store the result 
	history(end+1, :) = [ii, workers, currentProd];

	%Now update the graph 
	plot(history(:, 1), history(:, 3), 'ko-', 'LineWidth', 2, 'MarkerSize', 8);
	%Force to draw the graph now;
	drawnow;
	pause(.5);

	%display some message with some numbers;
	fprintf("Workers chosen : %d\n", workers);
	fprintf("Current Month Production : %.2f\n", currentProd);
	fprintf("Distance from the target prodcution: %.2f\n", currentProd-target);
	prevProd = currentProd;
	%correct the worker for this month 
	workers = (target + currentProd) / 20;
end


pause(2);
%display the final history table;
disp('Final History: [Months, Workers, Production]');
disp(history);