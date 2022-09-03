%#ok<*NOPTS>
clear, clc
%matriz dos coeficientes
A = [0,1,5,-7,23,-1,7,8,1,-5];
A = [A;17,0,-24,-75,100,-18,10,-8,9,-50];
A = [A;3,-2,15,0,-78,-90,-70,18,-75,1];
A = [A;5,5,-10,0,-72,-1,80,-3,10,-18];
A = [A;100,-4,-75,-8,0,83,-10,-75,3,-8];
A = [A;70,85,-4,-9,2,0,3,-17,-1,-21];
A = [A;1,15,100,-4,-23,13,0,7,-3,17];
A = [A;16,2,-7,89,-17,11,-73,0,-8,-23];
A = [A;51,47,-3,5,-10,18,-99,-18,0,12];
A = [A;1,1,1,1,1,1,1,1,1,0];
b = [10;-40;-17;43;-53;12;-60;100;0;100];%vetor resposta

%7.a) Método direto: Eliminação de Gauss
disp('Resolvendo sistema por Eliminação de Gauss:');
x1 = eliminacao_gauss(A,b)
%7.a) Método iterativo: Gauss-Seidel
disp('Resolvendo sistema por Gauss-Seidel:');
x0 = zeros(size(A,1),1);%vetor de estimativa inicial nulo
x2 = gauss_seidel(A,b,x0,1e-5,100)
%7.b) Método direto: linsolve (decomposição LU)
disp('Resolvendo sistema por Decomposição LU:');
x3 = linsolve(A,b)
%7.a) Método iterativo: bicg (Gradiente Biconjugado)
disp('Resolvendo sistema por Gradiente Biconjugado:');
[x4,flag4,relres4,iter4] = bicg(A,b,1e-5,100)

disp('Vetor com todas as respostas em ordem de execução:');
respostas = [x1,x2,x3,x4]