function [IR, out] = Romberg(f, a, b, N, level) 
% This function performs Romberg integration on the given function from [a, b].
% Required arguments: function handle, a, b, N of initial intevals, and
% level required for Romberg integration. 
% The method of Integration : Trapezoidal method.
level = level + 1; % My model was different than the traditional.
IR = zeros(level);

for n = 1 : level 
    IR(n , 1) = trapezoidal_integral(f, a, b, N * (2 ^ (n - 1)));
end



for col = 2 : level 
    term = 4 ^ (col - 1);
    for row = 1 : (level - col + 1)
        
        
        IR(row, col) = (term * IR(row + 1, col - 1) - IR(row, col - 1)) ...
            / (term - 1);
        
        
    end
end

out = IR(1, level);
end

