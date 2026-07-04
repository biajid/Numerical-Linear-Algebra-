clc;
clear;
close all;

m1 = readmatrix('Matrix1.xlsx');
m2 = readmatrix('Matrix2.xlsx');

% First get all the valid index;
valid_idx = ~isnan(m1) & ~isnan(m2);
m1 = m1(valid_idx);
m2 = m2(valid_idx);

% Make a matrix with m1 and m2
movies = [m1 m2];

%get the correlation coefficient
coef = corrcoef(m1, m2);
disp(coef);

coef = corrcoef(movies(:, 1), movies(:, 2));

plot(movies(:, 1), movies(:,2), '.', 'MarkerSize', 24);
xlabel('Matrix 1 Values');
ylabel('Matrix 2 Values');
title('Correlation between Matrix 1 and Matrix 2');
grid on;

%Now let us create two new figure;
figure;
subplot(1, 2, 1);
hold on;
hist(movies(:, 1),  9);
histfit(movies(:, 1), 9);
xlim([0 9]);
title('Matrix 1');

%Now draw the graph for the next movie
subplot(1, 2, 2);
hold on;
hist(movies(:, 2), 9);
histfit(movies(:, 2), 9);
xlim([0 9]);
title('Matrix 2');

%Now let us draw the 3D surface;
mt1 = (movies(:, 1) * 2) + 1;
mt2 = (movies(:, 2) * 2) + 1;

c = zeros(9, 9);

for i = 1:length(movies)
    c(mt1(i), mt2(i)) = c(mt1(i), mt2(i)) + 1;
end

% Create a meshgrid for the 3D surface plot
[x, y] = meshgrid(1:9, 1:9);
% Plot the 3D surface
figure;
surf(x, y, c);
xlabel('Matrix 1 Transformed Values');
ylabel('Matrix 2 Transformed Values');
zlabel('Frequency');
title('3D Surface Plot of Matrix Correlation');
colorbar;