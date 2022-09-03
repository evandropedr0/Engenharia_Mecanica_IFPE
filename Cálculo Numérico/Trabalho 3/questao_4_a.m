%#ok<*NOPTS>
clear, clc
%Sistema A
A1 = [4 1 -1;-1 3 1;2 2 5];
b1 = [5;-4;1];
%Sistema B
A2 = [1 0 -1;-0.5 1 -0.25;1 -0.5 1];
b2 = [0.2;-1.425;2];

%4.a)
x0 = zeros(3,1);
tol = 1e-3;
imax = 300;
disp('4.a) Métodos abertos Jacobi e Gauss-Seidel no Sistema A.');
disp('Usando Jacobi no sistema A:');
x1 = jacobi(A1,b1,x0,tol,imax)
disp('Usando Gauss-Seidel no sistema A:');
x2 = gauss_seidel(A1,b1,x0,tol,imax)
disp('4.a) Métodos abertos Jacobi e Gauss-Seidel no Sistema B.');
disp('Usando Jacobi no sistema B:');
x3 = jacobi(A2,b2,x0,tol,imax)
disp('Usando Gauss-Seidel no sistema B:');
x4 = gauss_seidel(A2,b2,x0,tol,imax)

resposta_a = [x1 x2 x3 x4]