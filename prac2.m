clear all; close all; clc;
figure;

for ii = 1 : 9
	subplot(3, 3, ii);
	h = bar(1, 1);
	set(h, 'FaceColor', [0 0 ii/9]);
	pause(0.5);
end

%Done for now;