format compact; 
format long;

N = 100000

f = zeros(1, N);
tic;
f(1) = 1;

for i = 2 : N 
	f(i) = f(i - 1) + 1;
end

elapsed = toc;

fprintf("The result is f(%d) = %g, and it took %g seconds\n", N, f(N), elapsed);
