function x = LUSolve(A, b)
[r, c] = size(A);
if r ~= c
    error('Matrix is not square!');
end
if length(b) ~= r 
    error('Size Mismatch!');
end

[L, U] = LUDecompCrout(A);
y = ForwardSub(L, b);
x = BackwardSub(U, y);
end
