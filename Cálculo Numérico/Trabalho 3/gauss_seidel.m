function [ x ] = gauss_seidel(A,b,x0,tol,imax)
%Função que calcula a solução de um sistema linear usando o método
%iterativo de Gauss-Seidel.
%Parâmetros: x = gauss_seidel(A,b,x0,tol,imax)
%A = matriz dos coeficientes (deve ser quadrada e det(A)~=0)
%b = vetor resposta ou vetor das constantes do sistema linear (deve ter o
%mesmo número de elementos que a dimensão da matriz A)
%x0 = vetor de estimativa inicial
%tol = tolerância para convergência do método
%imax = número máximo de iterações

%validação dos parâmetros
if isnumeric(tol)==false || isnumeric(imax)==false || ...
    isnumeric(x0)==false || isnumeric(A)==false || isnumeric(b)==false
    disp('Erro. Algum dos parâmetros não é numérico.');
    x = 0; return;
end
if size(A,1)~=size(A,2) %testa se o número de linhas é igual ao de colunas.
    disp('Erro. A matriz dos coeficientes não é quadrada.');
    x = 0; return;
elseif det(A)==0 %testa se o determinante de A é igual a 0.
    disp('Erro. O determinante da matriz dos coeficientes é nulo.');
    x = 0; return;
end
dim = size(A,1);%determina a dimensão da matriz A e armazena em dim.
if (size(b,1)~=1 && size(b,2)~=1) || ...%testa se é vetor linha ou coluna
        (size(x0,1)~=1 && size(x0,2)~=1)
    disp('Erro. Vetor b ou vetor x0 não é um vetor linha ou coluna.');
    x = 0; return;
elseif (size(b,1)~=dim && size(b,2)~=dim)||... %testa equivalência entre A,
        (size(x0,1)~=dim && size(x0,2)~=dim)   %b e x0.
    fprintf('Erro. Vetor b ou vetor x0 não tem quantidade de elementos');
    fprintf(' compatível com a matriz dos coeficientes.\n');
    x = 0; return;
end
if size(b,1)==1 %se b for um vetor linha,
    b = b';     %é transformado em vetor coluna.
end
if size(x0,1)==1 %se x0 for um vetor linha,
    x0 = x0';    %é transformado em vetor coluna.
end
soma = 0; cont = 0; %variáveis auxiliares
for i = 1:dim %for para linhas
    for j = 1:dim %for para colunas
        if i~=j %soma apenas os que estão fora da diagonal principal
            soma = soma + abs(A(i,j));
        end
    end
    if(A(i,i) >= soma)  %se o elemento da diagonal principal é maior que a 
        cont = cont + 1;%soma dos módulos dos outros elementos, então o
    else                %contador é incrementado
        break;
    end                 
    soma = 0; %restaura o valor de soma
end
if(cont ~= dim) %matriz dos coeficientes não é diagonalmente dominante.
    disp('A matriz dos coeficientes não é diagonalmente dominante,');
    disp('ou seja, existe a possibilidade do método não convergir.');
else
    disp('A matriz dos coeficientes é diagonalmente dominante e o');
    disp('método converge.');
end
%fim da validação dos parâmetros.

    %processamento
    format longe;%formato longo com notação exponencial
    x = zeros(dim,1); %declarando vetor x como vetor nulo.
    for k=1:imax
        soma = b; %variável auxiliar
        xaux = x0; %vetor auxiliar que recebe o valor de x0.
        %cálculo da estimativa atual
        for i = 1:dim %for para linhas
            for j = 1:dim %for para colunas
                if i~=j
                    soma(i,1) = soma(i,1) - A(i,j)*x0(j,1);
                end
            end
            x(i,1) = soma(i,1)/A(i,i); %cálculo de x da iteração k
            x0(i,1) = x(i,1); %atualiza estimativa anterior no índice i
        end
        erro = max(abs(x-xaux))/max(abs(x)); %cálculo de erro
        %quando o erro relativo da estimativa atual com a anterior é menor
        %que a tolerância, temos o resultado da raíz.
        if erro<tol
            break; %finaliza laço de repetição
        end
    end
    if k==imax %núemro máximo de iterações atingido
       disp('Função finalizada por atingir o número máximo de iterações.');
    end
    fprintf('\nNúmero total de iterações: %d\n',k);
end