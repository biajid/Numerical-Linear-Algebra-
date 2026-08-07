% Given equation:
%       y''(x) = 4*y(x),   0 <= x <= 1
%
% Boundary conditions:
%       y(0) = 1,   y(1) = 3
%
% Interior collocation approximation:
%
% y_tilda(x) = phi0(x) + c1*psi1(x) + c2*psi2(x) + c3*psi3(x)
%
% phi0 satisfies the nonhomogeneous boundary conditions, while every
% basis function psi_j satisfies psi_j(0) = psi_j(1) = 0.


x = linspace(0, 1, 100);
y_exact = @(x) (exp(2*x)*(3*exp(2) - 1))/(exp(4) - 1) - (exp(-2*x)*(3*exp(2) - exp(4)))/(exp(4) - 1);
x_colloc = [0.25, 0.75]; % collocation points
n = length(x_colloc);

b = zeros(n, 1); % right hand side of the equation is zero

% Help me to choose the basis function for this problem

psi_0 = @(x) 1 + 2*x; % phi0 satisfies the nonhomogeneous boundary conditions
psi = {
    @(x) x .* (1 - x);
    @(x) x .^ 2 .* (1 - x);
};
% put the correct second derivative of the basis functions in the cell array psi_dd
psi_dd = {
    @(x) -2;
    @(x) 2 - 6 .* x;
};

A = zeros(n, n);
b = zeros(n, 1); % right hand side of the equation is zero, will be updated later

for ii = 1 : n % sample points
    b(ii) = 4 * psi_0(x_colloc(ii)); % update the right hand side of the equation
    for jj = 1 : n % evaluate all the functions for each sample points 
        A(ii, jj) = psi_dd{jj}(x_colloc(ii)) - 4 .* psi{jj}(x_colloc(ii));

    end 
end

c = A \ b;

fprintf("c1 = %.4f\n", c(1));
fprintf("c2 = %.4f\n", c(2));

figure("Name", "Collocation Method");
plot(x, y_exact(x), 'k', 'LineWidth', 1, 'DisplayName', 'Exact Solution');
hold on;
plot(x, psi_0(x) + c(1) .* psi{1}(x) + c(2) .* psi{2}(x), 'r--', 'LineWidth', 2, 'DisplayName', 'Collocation Method');

legend('Location', 'best');
xlabel('x');
ylabel('y(x)');
max_error = max(abs(y_exact(x) - psi_0(x) - c(1) .* psi{1}(x) - c(2) .* psi{2}(x)));
norm_error = sqrt(trapz(x, (y_exact(x) - psi_0(x) - c(1) .* psi{1}(x) - c(2) .* psi{2}(x)).^2));

gtext(['Maximum error : ', num2str(max_error)]);
gtext(['L2 error : ', num2str(norm_error)]);
title('Interior Collocation Method');

