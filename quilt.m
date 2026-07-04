figure;
grid on;

x = 0 : 0.1 : 20;
y = sin(x);
x;
k = 1;

while k < 3
	quilt1(1, :) = x;
	quilt2(1, :) = y;

	quilt1(2, :) = x;
	quilt2(2, :) = -y;
 
	quilt1(3, :) = -x;
	quilt2(3, :) = y;

	quilt1(4, :) = -x;
	quilt2(4, :) = -y;

	hold on;
	for ii = 1 : 4
		plot(quilt1(ii, :), quilt2(ii, :), 'LineWidth', 1.5);
		pause(0.5);
	end

	for ii = 1 : 4
		plot(quilt2(ii, :), quilt1(ii, :), 'LineWidth', 1.5);
		pause(0.5);
	end

	%Shift the y by 19;
	y = y + 5;
	k = k + 1;

end

title('Quilt Pattern Formed by the Reflected Sine Curves.');
xlabel('x');
ylabel('y = sin(x)');


hold off;
figure;
plot(quilt1(1, :), quilt2(1, :), 'LineWidth', 2, 'color', 'red');
