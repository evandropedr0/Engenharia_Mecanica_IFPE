function [ x ] = gauss_seidel(A,b,x0,tol,imax)
%Fun��o que calcula a solu��o de um sistema linear usando o m�todo
%iterativo de Gauss-Seidel.
%Par�metros: x = gauss_seidel(A,b,x0,tol,imax)
%A = matriz dos coeficientes (deve ser quadrada e det(A)~=0)
%b = vetor resposta ou vetor das constantes do sistema linear (deve ter o
%mesmo n�mero de elementos que a dimens�o da matriz A)
%x0 = vetor de estimativa inicial
%tol = toler�ncia para converg�ncia do m�todo
%imax = n�mero m�ximo de itera��es

%valida��o dos par�metros
if isnumeric(tol)==false || isnumeric(imax)==false || ...
    isnumeric(x0)==false || isnumeric(A)==false || isnumeric(b)==false
    disp('Erro. Algum dos par�metros n�o � num�rico.');
    x = 0; return;
end
if size(A,1)~=size(A,2) %testa se o n�mero de linhas � igual ao de colunas.
    disp('Erro. A matriz dos coeficientes n�o � quadrada.');
    x = 0; return;
elseif det(A)==0 %testa se o determinante de A � igual a 0.
    disp('Erro. O determinante da matriz dos coeficientes � nulo.');
    x = 0; return;
end
dim = size(A,1);%determina a dimens�o da matriz A e armazena em dim.
if (size(b,1)~=1 && size(b,2)~=1) || ...%testa se � vetor linha ou coluna
        (size(x0,1)~=1 && size(x0,2)~=1)
    disp('Erro. Vetor b ou vetor x0 n�o � um vetor linha ou coluna.');
    x = 0; return;
elseif (size(b,1)~=dim && size(b,2)~=dim)||... %testa equival�ncia entre A,
        (size(x0,1)~=dim && size(x0,2)~=dim)   %b e x0.
    fprintf('Erro. Vetor b ou vetor x0 n�o tem quantidade de elementos');
    fprintf(' compat�vel com a matriz dos coeficientes.\n');
    x = 0; return;
end
if size(b,1)==1 %se b for um vetor linha,
    b = b';     %� transformado em vetor coluna.
end
if size(x0,1)==1 %se x0 for um vetor linha,
    x0 = x0';    %� transformado em vetor coluna.
end
soma = 0; cont = 0; %vari�veis auxiliares
for i = 1:dim %for para linhas
    for j = 1:dim %for para colunas
        if i~=j %soma apenas os que est�o fora da diagonal principal
            soma = soma + abs(A(i,j));
        end
    end
    if(A(i,i) >= soma)  %se o elemento da diagonal principal � maior que a 
        cont = cont + 1;%soma dos m�dulos dos outros elementos, ent�o o
    else                %contador � incrementado
        break;
    end                 
    soma = 0; %restaura o valor de soma
end
if(cont ~= dim) %matriz dos coeficientes n�o � diagonalmente dominante.
    disp('A matriz dos coeficientes n�o � diagonalmente dominante,');
    disp('ou seja, existe a possibilidade do m�todo n�o convergir.');
else
    disp('A matriz dos coeficientes � diagonalmente dominante e o');
    disp('m�todo converge.');
end
%fim da valida��o dos par�metros.

    %processamento
    format longe;%formato longo com nota��o exponencial
    x = zeros(dim,1); %declarando vetor x como vetor nulo.
    for k=1:imax
        soma = b; %vari�vel auxiliar
        xaux = x0; %vetor auxiliar que recebe o valor de x0.
        %c�lculo da estimativa atual
        for i = 1:dim %for para linhas
            for j = 1:dim %for para colunas
                if i~=j
                    soma(i,1) = soma(i,1) - A(i,j)*x0(j,1);
                end
            end
            x(i,1) = soma(i,1)/A(i,i); %c�lculo de x da itera��o k
            x0(i,1) = x(i,1); %atualiza estimativa anterior no �ndice i
        end
        erro = max(abs(x-xaux))/max(abs(x)); %c�lculo de erro
        %quando o erro relativo da estimativa atual com a anterior � menor
        %que a toler�ncia, temos o resultado da ra�z.
        if erro<tol
            break; %finaliza la�o de repeti��o
        end
    end
    if k==imax %n�emro m�ximo de itera��es atingido
       disp('Fun��o finalizada por atingir o n�mero m�ximo de itera��es.');
    end
    fprintf('\nN�mero total de itera��es: %d\n',k);
end