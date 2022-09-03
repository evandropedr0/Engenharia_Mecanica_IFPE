%#ok<*NOPTS>
%letra A)
disp('Resolvendo Sistema A pela Eliminação de Gauss:');
A1 = [1.19 2.11 -100 1;14.2 -0.122 12.2 -1;0 100 -99.9 1;15.3 0.11 -13.1 -1];
b1 = [1.12 3.44 2.15 4.16];
x1 = eliminacao_gauss(A1,b1) 

%letra B)
disp('Resolvendo Sistema B pela Eliminação de Gauss:');
A2 = [2.12 -2.12 51.3 100;0.333 -0.333 -12.2 19.7;6.19 8.20 -1.00 -2.01;-5.73 6.12 1 -1];
b2 = [pi sqrt(2) 0 -1];
x2 = eliminacao_gauss(A2,b2)