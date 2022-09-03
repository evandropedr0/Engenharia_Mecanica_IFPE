function [ x ] = cholesky(A,b)
%Fun��o que calcula a solu��o de um sistema linear usando o m�todo da
%Decomposi��o de Cholesky.
%Par�metros: x = cholesky(A,b)
%A = matriz dos coeficientes (deve ser quadrada e det(A)>0)
%b = vetor resposta ou vetor das constantes do sistema linear (deve ter o
%mesmo n�mero de elementos que a ordem da matriz A)
%x = vetor de sa�da.

%valida��o dos par�metros
if size(A,1)~=size(A,2) %testa se o n�mero de linhas � igual ao de colunas.
    disp('Erro. A matriz dos coeficientes n�o � quadrada.');
    x = 0; return;
elseif det(A)==0 %testa se o determinante de A � igual a 0.
    disp('Erro. O determinante da matriz dos coeficientes � nulo.');
    x = 0; return;
end
dim = size(A,1);%determina a dimens�o da matriz A e armazena em dim.
if size(b,1)~=1 && size(b,2)~=1%testa se � vetor linha ou coluna
    disp('Erro. O vetor resposta n�o � um vetor linha ou vetor coluna.');
    x = 0; return;
elseif size(b,1)~=dim && size(b,2)~=dim %testa equival�ncia entre A e b.
    fprintf('Erro. O vetor resposta deve ter o mesmo n�mero de elementos');
    fprintf(' que a dimens�o da matriz dos coeficientes.\n');
    x = 0; return;
end
if size(b,1)==1 %se b for um vetor linha,
    b = b';     %� transformado em vetor coluna.
end
At = A'; %At recebe a transposta de A
for i=1:dim %linhas
    for j=1:dim %colunas
        if A(i,j)~=At(i,j) %compara elemento a elemento
            disp('Erro. A matriz dos coeficientes n�o � sim�trica.');
            x = 0; return;
        end
    end
end
clear At;
AA = []; %#ok<*AGROW> %matriz auxiliar 
for i = 1:dim %for para ordem da matriz auxiliar
    for j = 1:i %for para linhas da matriz auxiliar
        for k = 1:i %for para colunas da matriz auxiliar
            AA(j,k) = A(j,k); %preenche matriz auxiliar com dados de A
        end
    end
    if det(AA)<=0 %testa se � definida positiva
        disp('Erro. A matriz dos coeficientes n�o � definida positiva.');
        x = 0; return;
    end
end
clear AA;
%fim da valida��o dos par�metros.

    %transforma��o de A para GxGt
    %#ok<*NASGU>
    G = zeros(dim);%declara��o da matriz G como matriz nula
    format short;
    %Transformando a matriz A em uma matriz triangular inferior G
    %atrav�s do m�todo da decomposi��o de Cholesky
    soma = 0; %vari�vel auxiliar
    for j = 1:dim %for para colunas
        for i = j:dim %for para linhas a partir da diagonal principal
            if i==j %G(i,j) � um elemento da diagonal principal
                soma = A(i,i);
                for k = 1:i
                    if i~=k
                       soma = soma - (G(i,k)^2);
                    else
                        G(i,i) = sqrt(soma);
                    end
                end
            else %G(i,j) n�o � um elemento da diagonal principal
                soma = A(i,j);
                for k = 1:j
                   if k<j
                       soma = soma - G(i,k)*G(i-1,k);
                   else
                       G(i,k) = soma/G(k,k);
                   end
                end
            end
        end
    end
    Gt = G';
    disp('A matriz A foi decomposta em GxGt. Onde');
    disp('G = '); disp(G);
    disp('e Gt = '); disp(Gt);
    %disp('GxGt = '); disp(G*Gt);
    disp('Resolvendo inicialmente Gy = b, por substitui��es sucessivas,');
    disp('temos y =');
    format longe;
    for i=1:dim %preenchendo vetores y e x com zeros
        %#ok<*AGROW>
        y(i,1)=0;
        x(i,1)=0;
    end
    for i = 1:dim %for para linhas
        soma = b(i,1);%const. que ser� somada com os valores j� conhecidos
        for j = 1:dim %for para colunas
            if(j~=i)
                soma = soma-(G(i,j)*y(j,1));
            end
            if(j==i)
                y(i,1) = soma / G(i,j); %c�lculo do valor da inc�gnita
            end
        end
    end
    disp(y);
    disp('Resolvendo agora Gtx = y, por retrossubstitui��o,');
    disp('temos a solu��o para o vetor de inc�gnitas:');
    for i = dim:-1:1 %for para linhas
        soma = y(i,1);%const. que ser� somada com os valores j� conhecidos
        for j = dim:-1:1 %for para colunas
            if(j~=i)
                soma = soma-(Gt(i,j)*x(j,1));
            end
            if(j==i)
                x(i,1) = soma / Gt(i,j); %c�lculo do valor da inc�gnita
            end
        end
    end
end