%integra��o pelo m�todo do Ponto M�dio

format long

syms x; %vari�veis simb�licas
syms y;
eq_dif = input('Digite a equa��o diferencial a ser integrada:     ');
%acima � recebida a equa��o diferencial a ser integrada

fprintf('\n\n');

intervalo(1) = input('Digite o primeiro limite de integra��o     ');
intervalo(2) = input('Digite o segundo limite de integra��o     ');
%usu�rio informa o intervalo de integra��o

fprintf('\n\n');

h = input('Digite o passo:     '); %passo do m�todo de Euler

fprintf('\n\n');

fprintf('Digite as condi��es iniciais:\n');
v(1,1) = input('X:     ');
v(1,2) = input('Y:     ');
%condi��es iniciais

i = 1; %contador
while(v(i,1)<intervalo(2)) %la�o que calcula a integral a cada ponto
    
    y_meio = v(i,2) + (subs(eq_dif ,{x,y}, {v(i,1),v(i,2)})*h/2); %c�lculo do y m�dio
    
    v(i+1,2) = v(i,2) + subs(eq_dif,{x,y}, {v(i,1)+h/2, y_meio})*h; %c�lculo no ponto m�dio
    
    v(i+1,1) = v(i,1) + h; %incremento do passo
    
    i = i + 1; %incremento do contador
end

fprintf('\n\n');

fprintf('Abaixo s�o mostrados os valores encontrados a cada ponto:\n');

disp(v);

fprintf('\n\n O valor da integral �:     ');
disp(v(i,2));