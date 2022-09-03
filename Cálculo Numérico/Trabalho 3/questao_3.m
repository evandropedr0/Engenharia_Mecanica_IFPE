A = [4 1 1 1;1 3 0 -1;1 0 2 1;1 -1 1 4];
b = [2 2 1 1]';
x = cholesky(A,b) %#ok<*NOPTS>