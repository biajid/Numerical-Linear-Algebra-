m = readmatrix('pca_book_dataset');
% Step :1 ---> standardize the data first
x = m - mean(m);

% Step :2 ---> Compute the covariance matrix
c = cov(x);

% Step 3: do the Eigen Decomposition of the 
% Covariance matrix
[v, d] = eig(c);

% step 4: sort the eigen values in descending order
[eigenvalues, idx] = sort(diag(d), 'descend');

v = v(:, idx);
d = diag(eigenvalues);

% Project data into the principal components
z = x * v;

% Now display the results 
disp('Eigenvalues : ');
disp(eigenvalues);

disp('Transformed Data: ');
disp(z);


% As the code is working for now, we will now 
% examine the eigen values with significance

explained_variance = (eigenvalues/sum(eigenvalues)) * 100; 
disp('Explained Variance : ');
disp(explained_variance);

% Now we will only keep those eigenvalues that 
% contributes at least ten percent variations

kept = explained_variance >= 10;

v_kept = v(:, kept);
z = x * v_kept;

disp('Kept eigen vectors: ')
disp(v_kept);

disp('Reformulated Data Sets : ');
disp(z);

writematrix(z, 'zmat')