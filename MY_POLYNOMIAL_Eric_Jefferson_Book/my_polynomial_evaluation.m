function out = my_polynomial_evaluation(P, x)
% This function evaluates P(x), where x is a scalar or 
% vector where polynomial would be evaluated. 
% Polynomial is expected to be of descending order of powers. 
out = 0;
xx = 1;

for index = length(P) : -1 : 1
    out = out + P(index) * xx;
    xx = xx * x;
end


