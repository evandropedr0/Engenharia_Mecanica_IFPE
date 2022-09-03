function [ x ] = eliminacao_gauss(A,b)
%Fun��o que calcula a solu��o de um sistema linear usando o m�todo da
%Elimina��o de Gauss.
%Par�metros: eliminacao_gauss(A,b)
%A = matriz dos coeficientes (deve ser quadrada e det(A)~=0)
%b = vetor resposta ou vetor das constantes do sistema linear (deve ter o
%mesmo n�mero de elementos que a dimens�o da matriz A)

%valida��o dos par�metros
if size(A,1)~=size(A,2) %testa se o n�mero de linhas � igual ao de colunas.
    disp('Erro. A matriz dos coeficientes n�o � quadrada.');
    return;
elseif det(A)==0 %testa se o determinante de A � igual a 0.
    disp('Erro. O determinante da matriz dos coeficientes � nulo.');
    return;
end
dim = size(A,1);%determina a dimens�o da matriz A e armazena em dim.
if size(b,1)~=1 && size(b,2)~=1%testa se � vetor linha ou coluna
    disp('Erro. O vetor resposta n�o � um vetor linha ou vetor coluna.');
    return;
elseif size(b,1)~=dim && size(b,2)~=dim %testa equival�ncia entre A e b.
    fprintf('Erro. O vetor resposta deve ter o mesmo n�mero de elementos');
    fprintf(' que a dimens�o da matriz dos coeficientes.\n');
    return;
end
if size(b,1)==1 %se b for um vetor linha,
    b = b';     %� transformado em vetor coluna.
end
%fim da valida��o dos par�metros.
%#ok<*NASGU>
m = 0; %constante usada para transforma��o da matriz em Triangular Superior
temp = [];%vetor tempor�rio auxiliar
temp1 = 0;%vari�vel tempor�ria auxiliar
cont = 0;%contador de pivota��es

format short;
disp('Matriz aumentada do sistema linear inicial:');
disp([A b]);
%Transformando matriz dos coeficientes em uma matriz triangular superior
%atrav�s de opera��es elementares em suas linhas
for i = 1:(dim-1) %for para linhas
    
    %O if a seguir evita que exista um piv� nulo
    if(A(i,i)==0)
        for k = (i+1):dim %esse for realiza a pivota��o
            if(A(k,i)~=0)
                cont = cont + 1; %incrementa contador de pivota��es
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
        m = A(j,i)/A(i,i);%const. usada p/ zerar elementos abaixo do piv�
        A(j,:) = A(j,:) - m*A(i,:);%transforma��o em Triangular Superior
        b(j,1) = b(j,1) - m*b(i,1);%Altera��o no vetor das constantes
    end
end
disp('Matriz aumentada do sistema linear ap�s primeira etapa:');
disp([A b]);
fprintf('Foram realizadas %d opera��es de pivota��o.\n\n',cont);
clear temp temp1 m k; %apaga vari�veis auxiliares
x = [];%declara��o da vari�vel de sa�da como um vetor vazio.

%Resolu��o do sistema linear por retrossubstitui��o
for i = dim:-1:1 %for para linhas
    soma = b(i);%constante que ser� somada com os valores j� conhecidos
    for j = dim:-1:1 %for para colunas
        if(j~=i)
            soma = soma-(A(i,j)*x(j));%valores j� descobertos sendo somados
        end
        if(j==i)
            x(i,1) = soma / A(i,j); %c�lculo do valor da inc�gnita
        end
    end
end
disp('Solu��o para o vetor de inc�gnitas:');
format longe;
clear soma i j; %apaga vari�veis auxiliares
end