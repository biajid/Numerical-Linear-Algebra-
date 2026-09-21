function tf = isperfect(n)
% This function checks whether the passed 
% integer n is perfect. It's a boolean function.
% usage tf = isperfect(n) ; 1 for true, 0 for false

if n <= 0
    error('We need positive integer');
end

divisors = 1 : n - 1;

a = divisors(~rem(n, divisors));
tf = sum(a) == n;
end
