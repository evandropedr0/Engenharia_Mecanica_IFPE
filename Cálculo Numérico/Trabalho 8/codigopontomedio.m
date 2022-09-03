%integração pelo método do Ponto Médio

format long

syms x; %variáveis simbólicas
syms y;
eq_dif = input('Digite a equação diferencial a ser integrada:     ');
%acima é recebida a equação diferencial a ser integrada

fprintf('\n\n');

intervalo(1) = input('Digite o primeiro limite de integração     ');
intervalo(2) = input('Digite o segundo limite de integração     ');
%usuário informa o intervalo de integração

fprintf('\n\n');

h = input('Digite o passo:     '); %passo do método de Euler

fprintf('\n\n');

fprintf('Digite as condições iniciais:\n');
v(1,1) = input('X:     ');
v(1,2) = input('Y:     ');
%condições iniciais

i = 1; %contador
while(v(i,1)<intervalo(2)) %laço que calcula a integral a cada ponto
    
    y_meio = v(i,2) + (subs(eq_dif ,{x,y}, {v(i,1),v(i,2)})*h/2); %cálculo do y médio
    
    v(i+1,2) = v(i,2) + subs(eq_dif,{x,y}, {v(i,1)+h/2, y_meio})*h; %cálculo no ponto médio
    
    v(i+1,1) = v(i,1) + h; %incremento do passo
    
    i = i + 1; %incremento do contador
end

fprintf('\n\n');

fprintf('Abaixo são mostrados os valores encontrados a cada ponto:\n');

disp(v);

fprintf('\n\n O valor da integral é:     ');
disp(v(i,2));