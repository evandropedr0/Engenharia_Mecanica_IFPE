function [ Yint ] = SplineQuadratica(x,y,Xint)
%SplineQuadratica calcula a interpola��o usando splines quadr�ticas.
%Par�metros: [ Yint ] = SplineQuadratica(x,y,Xint)
%x: Vetor com as coordenadas x dos pontos dados.
%y: Vetor com as coordenadas y dos pontos dados.
%Xint: Coordenada x do ponto a ser interpolado.
%Yint: O valor interpolado de Xint.

    %valida��o
    if isnumeric(x)==false||isnumeric(y)==false|| ...
            isnumeric(Xint)==false %um dos par�metros n�o � num�rico
        disp('Erro. Todos os par�metros devem ser num�ricos.');
        Yint = 'erro';
        return;
    end
    if(((size(x,1)>1)&&(size(x,2)>1))||((size(y,1)>1)&&(size(y,2)>1)))
        disp('Erro! X ou Y n�o � um vetor.');
        Yint = 'erro';
        return;
    elseif(length(x)~=length(y))%x e y devem ter mesmo n�mero de elementos
        disp('Erro! Dimens�es de X e Y n�o s�o equivalentes.');
        Yint = 'erro';
        return;
    end
    %processamento
    n = length(x); %n�mero de pontos
    ns = n-1; %n�mero de splines
    nc = 3*ns-1; %n�mero de coeficientes a encontrar (a1 = 0)
    %CRIANDO VETOR RESPOSTA
    b = ones(nc,1); %criando vetor com 3n-1 elementos
    j = 1; %vari�vel auxiliar
    for i = 1:2*ns
        b(i) = y(j);
        if mod(i,2)~=0
            j = j + 1;
        end
    end
    %CRIANDO MATRIZ DOS COEFICIENTES
        %PRIMEIRA ETAPA: EQUA��ES DOS EXTREMOS DAS SPLINES
    A = zeros(nc);
    expoente = 2; %vari�vel auxiliar
    i = 1; %vari�vel auxiliar para linhas
    k = 1; %vari�vel auxiliar para �ndice de x
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
        %SEGUNDA ETAPA: EQUA��ES DAS DERIVADAS
    j = 1; %vari�vel auxiliar para colunas
    k = 2; %vari�vel auxiliar para �ndice de x (n�s internos)
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
    %agora c cont�m todos os coeficientes exceto a1
    disp('Coeficientes das splines quadr�ticas');
    c = [0;c] %adicionando a1 em c
    %encontrando o intervalo de interpola��o
    for k = 2:n %k cont�m o valor final do intervalo de interpola��o
        if (Xint<x(k))
            break;
        end
    end
    k = k-1; %k agora � o �ndice da spline que ser� usada
    %declarando a spline �ndice k como um polin�mio quadr�tico simb�lico
    spline = poly2sym([c(3*k-2),c(3*k-1),c(3*k)]);
    disp('Spline interpoladora:');
    pretty(spline);%imprimindo spline interpoladora
    %transformando spline em uma fun��o do tipo inline
    spline = inline(spline);
    %avaliando a spline no ponto Xint
    Yint = spline(Xint); %interpola��o
    
    %plotando gr�fico
    plot(x,y,'o'), grid on, hold on;%plotando dados
    x1 = x(k):0.005:x(k+1);%intervalo em x
    y1 = spline(x1);%c�lculo das imagens no intervalo
    plot(x1,y1), hold off;%plotando spline
end