function y = my_fft_recursive(x, forward)
    % This function performs Fast Fourier Transform (Forward and Inverse).
    % It ccepts two arguments:
    %   x       - Input array (signal or coefficients, length must be a power of 2)
    %   forward - Logical flag (true/false, default = true).
    %
    % If forward = true (default):
    %   Performs FORWARD transform to compute Fourier coefficients c from signal x:
    %   c = F * x  (using negative twiddle exponent e^(-i*2*pi*k/n))
    %
    % If forward = false:
    %   Performs INVERSE transform to reconstruct signal x from coefficients c:
    %   x = (1/n) * F' * c  (using positive twiddle exponent e^(+i*2*pi*k/n) and 1/n scaling) 

    if nargin < 2
        forward = true;
    end

    n = length(x);
    y = fft_core(x, forward);

    % Divide by n when doing the Inverse Transform
    if ~forward 
        y = y / n;
    end
end

function y = fft_core(x, forward)
    n = length(x);

    if n == 1
        y = x;
        return;
    end

    even_x = x(1 : 2 : end);
    odd_x  = x(2 : 2 : end);

    even_y = fft_core(even_x, forward);
    odd_y  = fft_core(odd_x, forward);

    y = zeros(1, n);

    % Forward FFT uses e^(-i*2*pi/n); Inverse FFT uses e^(+i*2*pi/n)
    if forward
        signfactor = -1;
    else
        signfactor = 1;
    end

    m = n / 2 - 1;
    w_n = exp(signfactor * 2 * pi * 1i / n);
    tau = w_n .^ (0 : m);

    y(1 : m + 1)   = even_y + tau .* odd_y;
    y(m + 2 : end) = even_y - tau .* odd_y;
end