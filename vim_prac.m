%Sat Apr 25 07:00:20 PM EDT 2026
s = zeros(1, 100);
s(1) = 1;
for i = 2 : 100
	s(i) = s(i-1) + i;
end

disp(['Sum of 1 + 2 + 3 + 4 + ...... + n = ', num2str(s(end))]);



% I am inserting a dummyline
% I am adding another line
plot(1:100, s, 'LineWidth', 2, 'Color', 'r');
xlabel('Index');
ylabel('Sum');
title('A graph of the sum of the natural numbers');

%Sat Apr 25 07:00:20 PM EDT 2026


