% In this program we will evaluate the reciprocal fibonacci series, where eachnumber psi is given by, 
% psi = \sum{1, n} 1/fibonacci(n);
%
% we will take the input n from the user;
%

n = input('Please enter the integer : ');

shy = zeros(1, n);
first = 0;
for index = 1 : n
	first = first + (1 / fibonacci(index));
	shy(index) = first;
end

disp(shy);



