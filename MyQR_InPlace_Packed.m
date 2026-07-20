
function [Q, R] = MyQR_InPlace_Packed(A)
% This function performs QR factorization on the matrix A 
% It does so first putting all the elements of Q and R on A, and then 
% regenerates Q and R. It's just for practice!

[m, n] = size(A);
k = min(m, n);
tau = zeros(k, 1);

for j = 1 : k 
    normx = norm(A(j : end, j));
    x = A(j : end, j);
    s = -sign(A(j, j));

    if normx == 0
        continue;
    end

    if s == 0
        s = -1;
    end

    u1 = x(1) - s * normx;
    tau(j) = -s * u1 / normx;
    
    
    w = [1; x(2 : end) / u1];

    if j < n 
        A(j : end, j + 1 : end) = A(j : end, j + 1 : end) - (tau(j) * w) * (w' * A(j : end, j + 1 : end));
    end
    A(j, j) = s * normx;
    A(j + 1 : end, j) = w(2 : end);

end

% Now generate Q and R.
Q = eye(m);
R = triu(A);

for j = k : -1 : 1
    if tau(j) ~= 0
        w = [1; A(j + 1 : m, j)];
        Q(j : end, j : end) = Q(j : end, j : end) - (tau(j) * w) * (w' * Q(j : end, j : end));
    end

end
end

%{
function [Q, R] = MyQR_InPlace_Packed(A)
% This function performs QR factorization on the matrix A 
% It does so first putting all the elements of Q and R on A, and then 
% regenerates Q and R. It's just for practice!
[m, n] = size(A);
k = min(m, n);
tau = zeros(k, 1);

for j = 1 : k 
    normx = norm(A(j : end, j));
    if normx == 0
        continue;
    end
    
    x = A(j : end, j);
    s = -sign(A(j, j));
    if s == 0
        s = -1;
    end
    
    u1 = x(1) - s * normx;
    tau(j) = -s * u1 / normx; % FIX 1: Proper tau calculation
    
    w = [1; x(2 : end) / u1];
    if j < n 
        A(j : end, j + 1 : end) = A(j : end, j + 1 : end) - (tau(j) * w) * (w' * A(j : end, j + 1 : end));
    end
    A(j, j) = s * normx;
    A(j + 1 : end, j) = w(2 : end);
end

% Now generate Q and R.
Q = eye(m);
R = triu(A);

for j = k : -1 : 1
    if tau(j) ~= 0
        w = [1; A(j + 1 : m, j)]; % FIX 2: Explicit bound to row m
        % FIX 3: Multiply H_j from the left onto rows j:m of Q
        Q(j : m, :) = Q(j : m, :) - (tau(j) * w) * (w' * Q(j : m, :));
    end
end
end
%}