function largestEigenvalue = largestEigenValue(inputMatrixSize)
%LARGESTEIGENVALUE Summary of this function goes here
%   Detailed explanation goes here

% Generate a random symmetric matrix
A = randn(inputMatrixSize);
symmetricMatrix = (A + A') / 2;

% Calculate the eigenvalues
eigenvalues = eig(symmetricMatrix);

% Find the largest eigenvalue
largestEigenvalue = max(eigenvalues);


end

