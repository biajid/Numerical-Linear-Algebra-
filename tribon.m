a = zeros(1, 25);

a(1) = 0;
a(2) = 1;
a(3) = 1;

for index = 4 : length(a)
	a(index) = a(index - 3) + a(index - 2) + a(index - 1);
end

disp('First 25 tribonacci numbers are : ');

disp(a);

