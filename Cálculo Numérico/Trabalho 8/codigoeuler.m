%integração pelo método de Euler

syms x; %variável simbólica
eq_dif = input('Digite a equação diferencial a ser integrada:     ');
%acima é recebida a equação diferencial que será integrada

fprintf('\n\n');

intervalo(1) = input('Digite o primeiro limite de integração     ');
intervalo(2) = input('Digite o segundo limite de integração     ');
%usuário informa o intervalo de integração

fprintf('\n\n');

h = input('Digite o passo:     '); %passo do método de Euler

fprintf('\n\n');

valores = []; %matriz que guarda os valores da integral a cada iteração

fprintf('Condição inicial:\n');
valores(1,1) = input('X:     ');
valores(1,2) = input('Y:     ');
%condições iniciais

i = 1; %contador

while(valores(i,1) <= intervalo(2))
    valores(i+1,1) = valores(i,1) + h; %próximo valor de x
    %próxima aproximação da integral
    valores(i+1,2) = valores(i,2) + subs(eq_dif,valores(i,1))*h 
    i = i+1; %incremento do contador
end

fprintf('\n\n');

fprintf('Abaixo são mostrados os valores a cada iteração:\n');
disp(valores); %matriz com cada valor obtido a cada iteração

fprintf('o valor da integral é:');
disp(valores(i,2)); %valor aproximado da integral