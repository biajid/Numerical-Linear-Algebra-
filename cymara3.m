% In this program we will evaluate 
% the limit lim {x -> 0} (2 ^ x - 1) / (sin(x));

f = @(x) (2 ^ x - 1) / sin(x);

past = f(1);
current = f(0.1);
curr_x = 0.1;

while abs(past - current) > 1e-6
    past = current;
    current = f(curr_x * 0.1);
    curr_x = curr_x .* 0.1;
end


disp(['Limit is : ', num2str(current)]);