%We will test the sq_rt function with various inputs to ensure it is working correctly.

for i = 2500 : -25 : 1
    rt = sq_rt(i);
    %pause(2); % Pause for 2 seconds to simulate a delay in computation
    fprintf('The square root of %d is approximately %.6f\n', i, rt);
end

