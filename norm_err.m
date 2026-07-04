n = 10000;
num_exp = 1000;

means = zeros(1, num_exp);

for ii = 1 : num_exp
	sample = rand(1, n);
	means(ii) = mean(sample);
end

d = std(means);
disp(d);

e = 1/sqrt(n);
disp(e);