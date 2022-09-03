function [ Yint ] = SplineLinear(x,y,Xint)
%SplineLinear calcula a interpola��o usando splines lineares.
%Par�metros: [ Yint ] = SplineLinear(x,y,Xint)
%x: Vetor com as coordenadas x dos pontos dados.
%y: Vetor com as coordenadas y dos pontos dados.
%Xint: Coordenada x do ponto a ser interpolado.
%Yint: O valor interpolado de Xint.
    
    %VALIDA��O
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
    
    %PROCESSAMENTO
    n = length(x);
    for i = 2:n %i cont�m o valor final do intervalo de interpola��o
        if (Xint<x(i))
            break;
        end
    end

    %CRIANDO SPLINE E IMPRIMINDO EXPRESS�O
    syms X;%declarando vari�vel simb�lica
    spline = (X - x(i))*y(i-1)/(x(i-1)-x(i)) + ...
        (X - x(i-1))*y(i)/(x(i)-x(i-1));%declarando spline simb�lica
    disp('Spline Linear:');
    pretty(spline);%imprimindo express�o da spline
    
    %INTERPOLA��O
    spline = inline(spline); %transformando spline em fun��o inline
    Yint = spline(Xint); %realizando interpola��o
    
    %PLOTANDO GR�FICO
    k = i-1; %ponto inicial da spline
    plot(x,y,'o'), grid on, hold on;%plotando dados
    x1 = x(k):0.005:x(i);%intervalo em x
    y1 = spline(x1);%c�lculo das imagens no intervalo
    plot(x1,y1), hold off;%plotando spline
end