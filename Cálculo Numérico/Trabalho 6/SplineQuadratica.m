function [ Yint ] = SplineQuadratica(x,y,Xint)
%SplineQuadratica calcula a interpolação usando splines quadráticas.
%Parâmetros: [ Yint ] = SplineQuadratica(x,y,Xint)
%x: Vetor com as coordenadas x dos pontos dados.
%y: Vetor com as coordenadas y dos pontos dados.
%Xint: Coordenada x do ponto a ser interpolado.
%Yint: O valor interpolado de Xint.

    %validação
    if isnumeric(x)==false||isnumeric(y)==false|| ...
            isnumeric(Xint)==false %um dos parâmetros não é numérico
        disp('Erro. Todos os parâmetros devem ser numéricos.');
        Yint = 'erro';
        return;
    end
    if(((size(x,1)>1)&&(size(x,2)>1))||((size(y,1)>1)&&(size(y,2)>1)))
        disp('Erro! X ou Y não é um vetor.');
        Yint = 'erro';
        return;
    elseif(length(x)~=length(y))%x e y devem ter mesmo número de elementos
        disp('Erro! Dimensões de X e Y não são equivalentes.');
        Yint = 'erro';
        return;
    end
    %processamento
    n = length(x); %número de pontos
    ns = n-1; %número de splines
    nc = 3*ns-1; %número de coeficientes a encontrar (a1 = 0)
    %CRIANDO VETOR RESPOSTA
    b = ones(nc,1); %criando vetor com 3n-1 elementos
    j = 1; %variável auxiliar
    for i = 1:2*ns
        b(i) = y(j);
        if mod(i,2)~=0
            j = j + 1;
        end
    end
    %CRIANDO MATRIZ DOS COEFICIENTES
        %PRIMEIRA ETAPA: EQUAÇÕES DOS EXTREMOS DAS SPLINES
    A = zeros(nc);
    expoente = 2; %variável auxiliar
    i = 1; %variável auxiliar para linhas
    k = 1; %variável auxiliar para índice de x
    for j = 1:nc
        expoente = expoente - 1;
        A(i,j) = x(k)^expoente;
        A(i+1,j) = x(k+1)^expoente;
        if expoente == 0
            expoente = 3;
            i = i + 2; %i pula 2 linhas
            k = k + 1; %k incrementa
        end
    end
        %SEGUNDA ETAPA: EQUAÇÕES DAS DERIVADAS
    j = 1; %variável auxiliar para colunas
    k = 2; %variável auxiliar para índice de x (nós internos)
    for i = 2*ns+1:nc
        if i == 2*ns+1
            A(i,j) = 1;
            A(i,j+2) = -2*x(k+1);
            A(i,j+3) = -1;
            j = j + 2; %j pula 2 colunas
        else
            A(i,j) = 2*x(k);
            A(i,j+1) = 1;
            A(i,j+3) = -2*x(k);
            A(i,j+4) = -1;
            j = j + 3; %j pula 3 colunas
        end
        k = k + 1; %k incrementa
    end
    format long;
    c = A\b; %resolvendo sistema linear
    %agora c contém todos os coeficientes exceto a1
    disp('Coeficientes das splines quadráticas');
    c = [0;c] %adicionando a1 em c
    %encontrando o intervalo de interpolação
    for k = 2:n %k contém o valor final do intervalo de interpolação
        if (Xint<x(k))
            break;
        end
    end
    k = k-1; %k agora é o índice da spline que será usada
    %declarando a spline índice k como um polinômio quadrático simbólico
    spline = poly2sym([c(3*k-2),c(3*k-1),c(3*k)]);
    disp('Spline interpoladora:');
    pretty(spline);%imprimindo spline interpoladora
    %transformando spline em uma função do tipo inline
    spline = inline(spline);
    %avaliando a spline no ponto Xint
    Yint = spline(Xint); %interpolação
    
    %plotando gráfico
    plot(x,y,'o'), grid on, hold on;%plotando dados
    x1 = x(k):0.005:x(k+1);%intervalo em x
    y1 = spline(x1);%cálculo das imagens no intervalo
    plot(x1,y1), hold off;%plotando spline
end