tic
a = [4,6,-4;6,18,-3;-4,-3,21]; % matriz dos coeficientes
b = [35;60;-75]; % vetor das constantes
incognitas = [0;0;0]; % chute inicial para as ic�gnitas
residuos = []; %res�duo a cada itera��o


dim = 3; % dimens�o da matriz dos coeficientes

cont = 0; % contador ultilizado para verificar a converg�ncia do m�todo iterativo
soma = 0; % ultilizada para guardar a soma dos elementos fora da diagonal principal

for(i=1:1:dim) % percorre todas as linhas
    for(j=1:1:dim)% percorre as colunas
        if(i~=j)% soma apenas os que est�o fora da diagonal principal
            soma = soma + abs(a(i,j));
        end
    end
    if(a(i,i) >= soma) % se o elemento da diagonal principal � maior que a soma dos m�dulos dos outros
        % elementos, ent�o o contador � incrementado
        cont = cont + 1;
    end
end

if(cont == dim) % em todas as linhas o elemento da diagonal principal � maior que a soma dos outros elementos
    % ent�o a matriz � diagonalmente dominante
    fprintf('A matriz converge ao ser ultilizado o m�todo iterativo, pois � diagonalmente dominante\n\n');
else
    fprintf('N�o se pode afirmar que o m�todo ir� convergir\n\n\n')
end

for(i=1:1:4)
    incognitas(1,1) = (b(1,1) - (incognitas(2,1)*a(1,2)) - (incognitas(3,1)*a(1,3)))/ a(1,1);
    incognitas(2,1) = (b(2,1) - (incognitas(1,1)*a(2,1)) - (incognitas(3,1)*a(2,3)))/ a(2,2);
    incognitas(3,1) = (b(3,1) - (incognitas(1,1)*a(3,1)) - (incognitas(2,1)*a(3,2)))/ a(3,3);
    %c�lculo das incognitas. Note que o valor que foi descoberto que uma j�
    %� utilizado no c�lculo da pr�xima
    residuos(i,1) = (b(1,1)) - (incognitas(1,1)*a(1,1)) - (incognitas(2,1)*a(1,2))-(incognitas(3,1)*a(1,3));
    residuos(i,2) = (b(2,1)) - ((incognitas(1,1)*a(2,1)) + (incognitas(2,1)*a(2,2))+(incognitas(3,1)*a(2,3)));
    residuos(i,3) = (b(3,1)) - ((incognitas(1,1)*a(3,1)) + (incognitas(2,1)*a(3,2))+(incognitas(3,1)*a(3,3)));
    % c�lculo do res�duo
end


fprintf('Os resultados ap�s 4 itera��es foram:\n\n X1 = %f\n X2 = %f\n X3 = %f', incognitas(1,1), incognitas(2,1), incognitas(3,1))

fprintf('\n\n')
fprintf('Os res�duos obtidos a cada itera��o s�o mostrados abaixo:\n')

fprintf('                 1� equa��o      2� equa��o       3� equa��o\n')
for(i=1:1:4)
    fprintf('%d� itera��o :     %f       %f        %f\n', i,residuos(i,1),residuos(i,2), residuos(i,3));
end


fprintf('\n');
toc