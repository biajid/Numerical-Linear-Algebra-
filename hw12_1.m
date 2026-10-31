% Homework 12, Problem 1 - Congruential generator

a = 69069; M = 2^32;
x = 41286183253;

for i = 1 : 10000
  x = mod(a * x, M);
  r(i) = x / M;
end

subplot(1,2,1);
set(gca,'fontsize', 13);
hist(r,20);
title('Histogram of 10000 pseudorandom values');
xlabel('Random value'); ylabel('Frequency');

subplot(1,2,2);
set(gca,'fontsize', 13);
X = r(1:4000);
Y = r(2:4001);
plot(X,Y,'.');
title('Correlation between pseudorandom numbers');
xlabel('r_k'); ylabel('r_{k+1}');
