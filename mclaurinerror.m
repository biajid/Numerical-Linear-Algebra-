a = [2, 0.2, 0.02, 0.002, 0.0002];
out_error = [];
for i = 1 : length(a)
	[~, ~, ~, error] = mclaurinexp(a(i), 5);
	out_error = [out_error, error];
end

loglog(a, out_error, "LineWidth", 2, "Color", "red");
xlabel("Values");
ylabel("Error..");
title("Error Visualization and Quantification.");

