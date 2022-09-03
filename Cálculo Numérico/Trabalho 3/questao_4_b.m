%#ok<*NOPTS>
clear, clc
%Sistema A
A1 = [4 1 -1;-1 3 1;2 2 5];
b1 = [5;-4;1];
%Sistema B
A2 = [1 0 -1;-0.5 1 -0.25;1 -0.5 1];
b2 = [0.2;-1.425;2];

%4.b)
tol = 1e-3;
imax = 300;
x0 = [1;0;1];
disp('4.b) Métodos abertos Jacobi e Gauss-Seidel no Sistema A.');
disp('Usando Jacobi no sistema A:');
x5 = jacobi(A1,b1,x0,tol,imax)
disp('Usando Gauss-Seidel no sistema A:');
x6 = gauss_seidel(A1,b1,x0,tol,imax)
disp('4.b) Métodos abertos Jacobi e Gauss-Seidel no Sistema B.');
disp('Usando Jacobi no sistema B:');
x7 = jacobi(A2,b2,x0,tol,imax)
disp('Usando Gauss-Seidel no sistema B:');
x8 = gauss_seidel(A2,b2,x0,tol,imax)

resposta_b = [x5 x6 x7 x8]