mu = 0;
sigma = 1;
num = 10000;
nbins = 100;
% add label and other stuff on all four graphs
y = lognrnd(mu, sigma, num);

subplot(221);
histogram(y, nbins);


y2 = 0.5 * (1 + erf(log(y) - mu) / sqrt(2 * sigma));

subplot(222);
histogram(y2, nbins);

y3 = exprnd(3, num, 1);
subplot(223);
histogram(y3, nbins);

y4 = 1 - exp(-y3 / 3);
subplot(224);
histogram(y4, nbins);
xlabel('Transformed Variable y4');
ylabel('Frequency');
title('Histogram of y4');