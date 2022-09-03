function [ x ] = eliminacao_gauss(A,b)
%Função que calcula a solução de um sistema linear usando o método da
%Eliminação de Gauss.
%Parâmetros: eliminacao_gauss(A,b)
%A = matriz dos coeficientes (deve ser quadrada e det(A)~=0)
%b = vetor resposta ou vetor das constantes do sistema linear (deve ter o
%mesmo número de elementos que a dimensão da matriz A)

%validação dos parâmetros
if size(A,1)~=size(A,2) %testa se o número de linhas é igual ao de colunas.
    disp('Erro. A matriz dos coeficientes não é quadrada.');
    return;
elseif det(A)==0 %testa se o determinante de A é igual a 0.
    disp('Erro. O determinante da matriz dos coeficientes é nulo.');
    return;
end
dim = size(A,1);%determina a dimensão da matriz A e armazena em dim.
if size(b,1)~=1 && size(b,2)~=1%testa se é vetor linha ou coluna
    disp('Erro. O vetor resposta não é um vetor linha ou vetor coluna.');
    return;
elseif size(b,1)~=dim && size(b,2)~=dim %testa equivalência entre A e b.
    fprintf('Erro. O vetor resposta deve ter o mesmo número de elementos');
    fprintf(' que a dimensão da matriz dos coeficientes.\n');
    return;
end
if size(b,1)==1 %se b for um vetor linha,
    b = b';     %é transformado em vetor coluna.
end
%fim da validação dos parâmetros.
%#ok<*NASGU>
m = 0; %constante usada para transformação da matriz em Triangular Superior
temp = [];%vetor temporário auxiliar
temp1 = 0;%variável temporária auxiliar
cont = 0;%contador de pivotações

format short;
disp('Matriz aumentada do sistema linear inicial:');
disp([A b]);
%Transformando matriz dos coeficientes em uma matriz triangular superior
%através de operações elementares em suas linhas
for i = 1:(dim-1) %for para linhas
    
    %O if a seguir evita que exista um pivô nulo
    if(A(i,i)==0)
        for k = (i+1):dim %esse for realiza a pivotação
            if(A(k,i)~=0)
                cont = cont + 1; %incrementa contador de pivotações
                %permutando linha da matriz dos coeficientes
                temp = A(i,:);
                A(i,:) = A(k,:);
                A(k,:) = temp;
                
                %permutando linha do vetor resposta
                temp1 = b(i);
                b(i) = b(k);
                b(k) = temp1;
                break;
            end
        end
    end
    
    for j = (i+1):dim %for para colunas
        m = A(j,i)/A(i,i);%const. usada p/ zerar elementos abaixo do pivô
        A(j,:) = A(j,:) - m*A(i,:);%transformação em Triangular Superior
        b(j,1) = b(j,1) - m*b(i,1);%Alteração no vetor das constantes
    end
end
disp('Matriz aumentada do sistema linear após primeira etapa:');
disp([A b]);
fprintf('Foram realizadas %d operações de pivotação.\n\n',cont);
clear temp temp1 m k; %apaga variáveis auxiliares
x = [];%declaração da variável de saída como um vetor vazio.

%Resolução do sistema linear por retrossubstituição
for i = dim:-1:1 %for para linhas
    soma = b(i);%constante que será somada com os valores já conhecidos
    for j = dim:-1:1 %for para colunas
        if(j~=i)
            soma = soma-(A(i,j)*x(j));%valores já descobertos sendo somados
        end
        if(j==i)
            x(i,1) = soma / A(i,j); %cálculo do valor da incógnita
        end
    end
end
disp('Solução para o vetor de incógnitas:');
format longe;
clear soma i j; %apaga variáveis auxiliares
end