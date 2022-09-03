%integra��o pelo m�todo de Euler

syms x; %vari�vel simb�lica
eq_dif = input('Digite a equa��o diferencial a ser integrada:     ');
%acima � recebida a equa��o diferencial que ser� integrada

fprintf('\n\n');

intervalo(1) = input('Digite o primeiro limite de integra��o     ');
intervalo(2) = input('Digite o segundo limite de integra��o     ');
%usu�rio informa o intervalo de integra��o

fprintf('\n\n');

h = input('Digite o passo:     '); %passo do m�todo de Euler

fprintf('\n\n');

valores = []; %matriz que guarda os valores da integral a cada itera��o

fprintf('Condi��o inicial:\n');
valores(1,1) = input('X:     ');
valores(1,2) = input('Y:     ');
%condi��es iniciais

i = 1; %contador

while(valores(i,1) <= intervalo(2))
    valores(i+1,1) = valores(i,1) + h; %pr�ximo valor de x
    %pr�xima aproxima��o da integral
    valores(i+1,2) = valores(i,2) + subs(eq_dif,valores(i,1))*h 
    i = i+1; %incremento do contador
end

fprintf('\n\n');

fprintf('Abaixo s�o mostrados os valores a cada itera��o:\n');
disp(valores); %matriz com cada valor obtido a cada itera��o

fprintf('o valor da integral �:');
disp(valores(i,2)); %valor aproximado da integral