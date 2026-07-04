figure;
n = 15;
sample_var = zeros(1, n);
sample_mean = zeros(1, n);
N = 1 : n;
	
for n = 1 : 15;
	count = 2 ^ n;
	vector = randn(count, 100);
	item = mean(vector);
	sample_var(n) = var(item);
	sample_mean(n) = mean(item);
end

subplot(1,2,1)
scatter(N, sample_var, 'MarkerEdgeColor', 'r', 'LineWidth', 2);

subplot(1,2,2)
scatter(N, sample_mean, 'MarkerEdgeColor', 'k', 'LineWidth', 2);
yline(0, 'LineWidth', 2, 'Color', 'r');

