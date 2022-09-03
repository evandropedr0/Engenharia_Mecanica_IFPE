function [ x ] = decomposicaolu(A,b)
%Função que calcula a solução de um sistema linear usando o método da
%Decomposição LU.
%Obs.: Esse algoritmo não faz pivoteamento parcial. Caso seja necessário,
%as permutações na matriz dos coeficientes devem ser feitas antes de usar
%essa função.
%Parâmetros: x = decomposicaolu(A,b)
%A = matriz dos coeficientes (deve ser quadrada e det(A)~=0)
%b = vetor resposta ou vetor das constantes do sistema linear (deve ter o
%mesmo número de elementos que a dimensão da matriz A)
%x = vetor de saída.

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

%transformação de A para LU
%#ok<*NASGU>
m = 0; %constante usada para transformação da matriz em Triangular Superior
temp = [];%vetor temporário auxiliar
temp1 = 0;%variável temporária auxiliar
U = A; %matriz triangular superior
L = zeros(dim); %matriz triangular inferior
    for i=1:dim %preenchendo a diagonal principal de L com 1
        L(i,i)=1;
    end
    format short;
    %Transformando a matriz U em uma matriz triangular superior
    %através de operações elementares em suas linhas
    for i = 1:(dim-1)
        %O if a seguir evita que exista um pivô nulo
        if(U(i,i)==0)
            disp('Erro. É necessário permutar as linhas da matriz dos');
            disp('coeficientes para prosseguir com o método. Esse');
            disp('algoritmo não realiza pivoteamento parcial.');
            x = 0;
            return;
        end
        for j = (i+1):dim
            m = U(j,i)/U(i,i);%const. usada p/ zerar elem. abaixo do pivô
            U(j,:) = U(j,:) - m*U(i,:);%transf. em Triangular Superior
            L(j,i) = m; %adiciona multiplicador à matriz L na posição (j,i)
        end
    end
    disp('A matriz A foi decomposta em LxU. Onde');
    disp('L = '); disp(L);
    disp('e U = '); disp(U);    
    disp('Resolvendo inicialmente Ly = b, por substituições sucessivas,');
    disp('temos y =');
    format longe;
    for i=1:dim %preenchendo vetores y e x com zeros
        %#ok<*AGROW>
        y(i,1)=0;
        x(i,1)=0;
    end
    for i = 1:dim %for para linhas
        soma = b(i,1);%const. que será somada com os valores já conhecidos
        for j = 1:dim %for para colunas
            if(j~=i)
                soma = soma-(L(i,j)*y(j,1));
            end
            if(j==i)
                y(i,1) = soma / L(i,j); %cálculo do valor da incógnita
            end
        end
    end
    disp(y);
    disp('Resolvendo agora Ux = y, por retrossubstituição,');
    disp('temos a solução para o vetor de incógnitas:');
    for i = dim:-1:1 %for para linhas
        soma = y(i,1);%const. que será somada com os valores já conhecidos
        for j = dim:-1:1 %for para colunas
            if(j~=i)
                soma = soma-(U(i,j)*x(j,1));
            end
            if(j==i)
                x(i,1) = soma / U(i,j); %cálculo do valor da incógnita
            end
        end
    end
end