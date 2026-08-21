exponents = 2 : 9;
exponents = sym(1) ./ sym(exponents);
vector = sym(2 : 20);
matrix = sym(zeros(length(exponents) + 1, length(vector)));

matrix(1, :) = vector;

for ii = 1 : length(exponents)
	matrix(ii + 1, :) = sym(vector) .^ exponents(ii);
end

matrix = matrix'

