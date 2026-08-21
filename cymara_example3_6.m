%{
Example 6: In this next example we will use a for loop to get MATLAB to draw the
picture shown below that illustrates the right hand rule with 20 intervals to evaluate
∫ sin(x) dx on [0, pi];
%}

x = 0 : pi / 20 : pi;
y = sin(x);
figure('Name', 'Right Point Method')
plot(x, y, 'color', 'r', 'LineWidth', 1.5);
hold on;

% We will use Right point rule to draw the rectangle.
% Our target is to draw three lines on each interval
% One left vertical line
% One right vertical line;
% and one horizontal line connecting left and right 
% vertical line from top. 

for ii = 1 : length(x) - 1
	left_x = x(ii);
	right_x = x(ii + 1);
	current_y = y(ii + 1);

	% Draw the left vertical line
	plot([left_x, left_x], [0, current_y], 'k', 'LineWidth', 2);
	% Draw the right vertical line
	plot([right_x, right_x], [0, current_y], 'k', 'LineWidth', 2);
	% Connect the left and right from top to top
	plot([left_x, right_x], [current_y, current_y], 'k', 'LineWidth', 2);
end

hold off;

% Put some labelling 
xlabel('x');
ylabel('y = sin(x)');
title('Plot of y = sin(x) on [0, pi]');


% Now let us do the midpoint
figure('Name', 'Midpoint Method')


plot(x, y, 'color', 'r', 'LineWidth', 1.5);
hold on;

for ii = 1 : length(x) - 1
	left_x = x(ii);
	right_x = x(ii + 1);
	current_y = sin((left_x + right_x) / 2);

	% Draw the left vertical line
	plot([left_x, left_x], [0, current_y], 'k', 'LineWidth', 2);
	% Draw the right vertical line
	plot([right_x, right_x], [0, current_y], 'k', 'LineWidth', 2);
	% Connect the left and right from top to top
	plot([left_x, right_x], [current_y, current_y], 'k', 'LineWidth', 2);
end

xlabel('x');
ylabel('y = sin(x)');
title('Plot of y = sin(x) on [0, pi]');

hold off;

