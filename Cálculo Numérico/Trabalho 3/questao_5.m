%#ok<*NOPTS>
clear, clc
%declara��o do sistema linear
A = [1 -1 0 0 0;-1 2 -1 0 0;0 -1 2.001 -1 0;0 0 -1 2 -1;0 0 0 1 -1];
b = [1 1 1 1 1]';

%letra a
disp('5.a) Usando Elimina��o de Gauss:');
x1 = eliminacao_gauss(A,b)

%letra b
disp('5.b) Usando o M�todo de Jacobi:');
x2 = jacobi(A,b,zeros(5,1),1e-3,300)

%letra c
disp('5.c) Usando o M�todo de Gauss-Seidel:');
x3 = gauss_seidel(A,b,zeros(5,1),1e-3,300)

solucao_5 = [x1 x2 x3]