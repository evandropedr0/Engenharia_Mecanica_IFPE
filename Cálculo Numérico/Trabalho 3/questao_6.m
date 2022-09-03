%#ok<*NOPTS>
clear, clc
%Matriz dos coeficientes do sistema A
A1 = [1 2;1.0001 2];
%Matriz dos coeficientes do sistema B
A2 = [1 2;0.9999 2];
%vetor resposta (igual para ambos os sistemas)
b = [3;3.0001];

%resolvendo por eliminação de gauss
disp('Resolvendo Sistema A por matriz inversa:');
x1 = A1\b 
disp('Resolvendo Sistema B por matriz inversa:');
x2 = A2\b
respostas_6 = [x1 x2]
disp('Condicionamento das matrizes A1 (c1) e A2 (c2):');
c1 = cond(A1), c2 = cond(A2)