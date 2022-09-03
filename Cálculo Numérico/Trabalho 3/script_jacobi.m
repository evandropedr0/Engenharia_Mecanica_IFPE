tic
a = [4,6,-4;6,18,-3;-4,-3,21]; % matriz dos coeficientes
icognitas_1 = [0;0;0]; % vetor das icógnitas iniciais
icognitas_2 = [];% valor das incognitas encontradas a cada iteração
b = [35;60;-75]; % vetor das constantes
residuo = []; % matriz que guarda os resíduos de cada iteração

dim = 3; % dimensão da matriz dos coeficientes

cont = 0; % contador ultilizado para verificar a convergência do método iterativo
soma = 0; % ultilizada para guardar a soma dos elementos fora da diagonal principal

for(i=1:1:dim) % percorre todas as linhas
    for(j=1:1:dim)% percorre as colunas
        if(i~=j)% soma apenas os que estão fora da diagonal principal
            soma = soma + abs(a(i,j));
        end
    end
    if(a(i,i) >= soma) % se o elemento da diagonal principal é maior que a soma dos módulos dos outros
        % elementos, então o contador é incrementado
        cont = cont + 1;
    end
end

if(cont == dim) % em todas as linhas o elemento da diagonal principal é maior que a soma dos outros elementos
    % então a matriz é diagonalmente dominante
    fprintf('A matriz converge ao ser ultilizado o método iterativo, pois é diagonalmente dominante\n\n');
else
    fprintf('Não se pode afirmar que o método irá convergir\n\n\n')
end

residuo(1,1) = 35;
residuo(1,2) = 60;
residuo(1,3) = -75;
%resíduos iniciais

for(i=1:1:4)
    icognitas_2(1,1) = (b(1,1) - (icognitas_1(2,1)*a(1,2)) - (icognitas_1(3,1)*a(1,3)))/ a(1,1);
    icognitas_2(2,1) = (b(2,1) - (icognitas_1(1,1)*a(2,1)) - (icognitas_1(3,1)*a(2,3)))/ a(2,2);
    icognitas_2(3,1) = (b(3,1) - (icognitas_1(1,1)*a(3,1)) - (icognitas_1(2,1)*a(3,2)))/ a(3,3);
    % atualização dos valores das icognitas 
    residuo(i+1,1) = b(1,1) - ((icognitas_2(1,1)*a(1,1)) + (icognitas_2(2,1)*a(1,2))+(icognitas_2(3,1)*a(1,3)));
    residuo(i+1,2) = b(2,1) - ((icognitas_2(1,1)*a(2,1)) + (icognitas_2(2,1)*a(2,2))+(icognitas_2(3,1)*a(2,3)));
    residuo(i+1,3) = b(3,1) - ((icognitas_2(1,1)*a(3,1)) + (icognitas_2(2,1)*a(3,2))+(icognitas_2(3,1)*a(3,3)));
    %cálculo do resíduo
    icognitas_1 = icognitas_2;
end

fprintf('Os resultados após 4 iterações foram:\n\n X1 = %f\n X2 = %f\n X3 = %f', icognitas_2(1,1), icognitas_2(2,1), icognitas_2(3,1))

fprintf('\n\n')
fprintf('Os resíduos obtidos a cada iteração são mostrados abaixo:\n')

fprintf('                 1º equação      2º equação       3º equação\n')
for(i=1:1:5)
    fprintf('%dº iteração :     %f       %f        %f\n', i,residuo(i,1),residuo(i,2), residuo(i,3));
end

fprintf('\n');
toc



