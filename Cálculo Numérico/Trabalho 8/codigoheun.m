%integra��o pelo m�todo de Heun

format long

syms x; %vari�vel simb�lica
syms y; %vari�vel simb�lica
eq_dif = input('Digite a equa��o diferencial a ser integrada:     ');
%acima ser� recebida a equa��o diferencial a ser integrada

fprintf('\n\n');

intervalo(1) = input('Digite o primeiro limite de integra��o:     ');
intervalo(2) = input('Digite o segundo limite de integra��o:      ');
%usu�rio informa o intervalo de integra��o

fprintf('\n\n');

h = input('Digite o passo:     ');
%passo do m�todo de Heun

fprintf('\n\n');

it = input('Digite o n�mero de itera��es para cada passo:     ');
%� informado o n�mero de itera��es feitas para cada ponto

fprintf('\n\n');

fprintf('Digite as condi��es iniciais:\n');
v(1,1) = input('x:     ');
v(1,2) = input('y:     ');
%condi��es iniciais

i = 1; %contador

while(v(i,1)<intervalo(2)) %la�o que calcula a integral ponto a ponto
    v(i+1,2) = v(i,2) + subs(eq_dif,{x,y},{v(i,1),v(i,2)})*h; %c�lculo do preditor
    for j = 1:1:it %la�o que faz a quantidade de itera��es necess�rias a cada ponto
        v(i+1,2) = v(i,2) + ((subs(eq_dif,{x,y},{v(i,1),v(i,2)})+subs(eq_dif,{x,y},{v(i,1)+h,v(i+1,1)}))*h)/2; %corretor
    end
    v(i+1,1) = v(i,1) + h; %incremento do passo em x
    i = i + 1; %incremento do contador
end

fprintf('\n\n');

fprintf('Abaixo s�o mostrados os valores encontrados em cada ponto:\n');
disp(v);

fprintf('\n\n');
fprintf('o valor da integral �:     ');
disp(v(i,2));