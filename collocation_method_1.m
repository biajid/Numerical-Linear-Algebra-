% Given Equation: y''(x) + y(x) = x; x in [0, 1] with y(0) = 0 and y(1) = 0;
% We will use the interior collocation method to solve this boundary value problem.
% Chosen basis psi1(x) = x*(1-x) and psi2(x) = x^2*(1-x)
% exact solution: y(x) = x - sin(x)/sin(1);
% guessed solution y_tilda(x) = a1*psi1(x) + a2*psi2(x);

x = linspace(0, 1, 100);
y_exact = @(x) x - sin(x) ./ sin(1);
x_colloc = [0.25, 0.75]; % collocation points
n = length(x_colloc);

b = x_colloc(:);

psi = {
    @(x) x .* (1 - x);
    @(x) x .^ 2 .* (1 - x);
};
psi_dd = {
    @(x) -2;
    @(x) 2 - 6 .* x;
};

A = zeros(n, n);

for ii = 1 : n % sample points
    for jj = 1 : n % evaluate all the functions for each sample points 
        A(ii, jj) = psi_dd{jj}(x_colloc(ii)) + psi{jj}(x_colloc(ii));
    end 
end

c = A \ b;

fprintf("c1 = %.4f\n", c(1));
fprintf("c2 = %.4f\n", c(2));

figure("Name", "Collocation Method");
plot(x, y_exact(x), 'k', 'LineWidth', 1, 'DisplayName', 'Exact Solution');
hold on;
plot(x, c(1) .* psi{1}(x) + c(2) .* psi{2}(x), 'r--', 'LineWidth', 2, 'DisplayName', 'Collocation Method');

legend('Location', 'best');
xlabel('x');
ylabel('y(x)');
max_error = max(abs(y_exact(x) - c(1) .* psi{1}(x) - c(2) .* psi{2}(x)));
err = y_exact(x) - c(1) .* psi{1}(x) - c(2) .* psi{2}(x);
norm_error = sqrt(trapz(x, err.^2));

gtext(['Maximum error : ', num2str(max_error)]);
gtext(['L2 error : ', num2str(norm_error)]);
title('Interior Collocation Method');

