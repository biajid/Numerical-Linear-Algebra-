function [f_emp, x_emp] = my_ecdf(x)
% This function computes empirical cumulative distribution
% on the given data x.

if ~isvector(x)
    error('x must be a vector.');
end

% first make sure that x is a column vector. 
x = x(:);

% Make sure that x is not empty
if isempty(x)
    error('x should not be empty.');
end

n = length(x);

% Now get the unique x;
x_emp = unique(x);

f = x <= x_emp.';
f_emp = sum(f, 1);

f_emp = f_emp / n;

% return as column vectors 
f_emp = f_emp(:); 
end
