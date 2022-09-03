%#ok<*NOPTS>
clear, clc
%Sistema A
A1 = [4 1 -1;-1 3 1;2 2 5];
b1 = [5;-4;1];
%Sistema B
A2 = [1 0 -1;-0.5 1 -0.25;1 -0.5 1];
b2 = [0.2;-1.425;2];
format longe;

%método direto
disp('4.c) Método direto: linsolve.');
disp('Usando linsolve no sistema A:');
x9 = linsolve(A1,b1)
disp('Usando linsolve no sistema B:');
x10 = linsolve(A2,b2)

%método aberto
tol = 1e-3;
imax = 300;
disp('4.c) Método aberto: Gradientes Biconjugados (bicg).');
disp('Usando bicg no sistema A:');
[x11,flag11,relres11,iter11] = bicg(A1,b1,tol,imax)
disp('Usando bicg no sistema B:');
[x12,flag12,relres12,iter12] = bicg(A2,b2,tol,imax)

resposta_c = [x9 x10 x11 x12]