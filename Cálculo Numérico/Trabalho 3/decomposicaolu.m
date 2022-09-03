function [ x ] = decomposicaolu(A,b)
%Fun��o que calcula a solu��o de um sistema linear usando o m�todo da
%Decomposi��o LU.
%Obs.: Esse algoritmo n�o faz pivoteamento parcial. Caso seja necess�rio,
%as permuta��es na matriz dos coeficientes devem ser feitas antes de usar
%essa fun��o.
%Par�metros: x = decomposicaolu(A,b)
%A = matriz dos coeficientes (deve ser quadrada e det(A)~=0)
%b = vetor resposta ou vetor das constantes do sistema linear (deve ter o
%mesmo n�mero de elementos que a dimens�o da matriz A)
%x = vetor de sa�da.

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

%transforma��o de A para LU
%#ok<*NASGU>
m = 0; %constante usada para transforma��o da matriz em Triangular Superior
temp = [];%vetor tempor�rio auxiliar
temp1 = 0;%vari�vel tempor�ria auxiliar
U = A; %matriz triangular superior
L = zeros(dim); %matriz triangular inferior
    for i=1:dim %preenchendo a diagonal principal de L com 1
        L(i,i)=1;
    end
    format short;
    %Transformando a matriz U em uma matriz triangular superior
    %atrav�s de opera��es elementares em suas linhas
    for i = 1:(dim-1)
        %O if a seguir evita que exista um piv� nulo
        if(U(i,i)==0)
            disp('Erro. � necess�rio permutar as linhas da matriz dos');
            disp('coeficientes para prosseguir com o m�todo. Esse');
            disp('algoritmo n�o realiza pivoteamento parcial.');
            x = 0;
            return;
        end
        for j = (i+1):dim
            m = U(j,i)/U(i,i);%const. usada p/ zerar elem. abaixo do piv�
            U(j,:) = U(j,:) - m*U(i,:);%transf. em Triangular Superior
            L(j,i) = m; %adiciona multiplicador � matriz L na posi��o (j,i)
        end
    end
    disp('A matriz A foi decomposta em LxU. Onde');
    disp('L = '); disp(L);
    disp('e U = '); disp(U);    
    disp('Resolvendo inicialmente Ly = b, por substitui��es sucessivas,');
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
                soma = soma-(L(i,j)*y(j,1));
            end
            if(j==i)
                y(i,1) = soma / L(i,j); %c�lculo do valor da inc�gnita
            end
        end
    end
    disp(y);
    disp('Resolvendo agora Ux = y, por retrossubstitui��o,');
    disp('temos a solu��o para o vetor de inc�gnitas:');
    for i = dim:-1:1 %for para linhas
        soma = y(i,1);%const. que ser� somada com os valores j� conhecidos
        for j = dim:-1:1 %for para colunas
            if(j~=i)
                soma = soma-(U(i,j)*x(j,1));
            end
            if(j==i)
                x(i,1) = soma / U(i,j); %c�lculo do valor da inc�gnita
            end
        end
    end
end