%integração pelo método de Heun

format long

syms x; %variável simbólica
syms y; %variável simbólica
eq_dif = input('Digite a equação diferencial a ser integrada:     ');
%acima será recebida a equação diferencial a ser integrada

fprintf('\n\n');

intervalo(1) = input('Digite o primeiro limite de integração:     ');
intervalo(2) = input('Digite o segundo limite de integração:      ');
%usuário informa o intervalo de integração

fprintf('\n\n');

h = input('Digite o passo:     ');
%passo do método de Heun

fprintf('\n\n');

it = input('Digite o número de iterações para cada passo:     ');
%é informado o número de iterações feitas para cada ponto

fprintf('\n\n');

fprintf('Digite as condições iniciais:\n');
v(1,1) = input('x:     ');
v(1,2) = input('y:     ');
%condições iniciais

i = 1; %contador

while(v(i,1)<intervalo(2)) %laço que calcula a integral ponto a ponto
    v(i+1,2) = v(i,2) + subs(eq_dif,{x,y},{v(i,1),v(i,2)})*h; %cálculo do preditor
    for j = 1:1:it %laço que faz a quantidade de iterações necessárias a cada ponto
        v(i+1,2) = v(i,2) + ((subs(eq_dif,{x,y},{v(i,1),v(i,2)})+subs(eq_dif,{x,y},{v(i,1)+h,v(i+1,1)}))*h)/2; %corretor
    end
    v(i+1,1) = v(i,1) + h; %incremento do passo em x
    i = i + 1; %incremento do contador
end

fprintf('\n\n');

fprintf('Abaixo são mostrados os valores encontrados em cada ponto:\n');
disp(v);

fprintf('\n\n');
fprintf('o valor da integral é:     ');
disp(v(i,2));