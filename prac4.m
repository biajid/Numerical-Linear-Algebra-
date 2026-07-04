figure;
hold on;
xlim([0 1]);
ylim([0 1]);

for ii = 1 : 5
	[a, b] = ginput(1);
	pause(0.5);
	[c, d] = ginput(1);
	plot([a, c], [b, d] , 'LineWidth', 2);
	pause(.5);
end