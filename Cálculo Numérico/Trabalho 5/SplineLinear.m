function [ Yint ] = SplineLinear(x,y,Xint)
%SplineLinear calcula a interpolação usando splines lineares.
%Parâmetros: [ Yint ] = SplineLinear(x,y,Xint)
%x: Vetor com as coordenadas x dos pontos dados.
%y: Vetor com as coordenadas y dos pontos dados.
%Xint: Coordenada x do ponto a ser interpolado.
%Yint: O valor interpolado de Xint.
    
    %VALIDAÇÃO
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
    
    %PROCESSAMENTO
    n = length(x);
    for i = 2:n %i contém o valor final do intervalo de interpolação
        if (Xint<x(i))
            break;
        end
    end

    %CRIANDO SPLINE E IMPRIMINDO EXPRESSÃO
    syms X;%declarando variável simbólica
    spline = (X - x(i))*y(i-1)/(x(i-1)-x(i)) + ...
        (X - x(i-1))*y(i)/(x(i)-x(i-1));%declarando spline simbólica
    disp('Spline Linear:');
    pretty(spline);%imprimindo expressão da spline
    
    %INTERPOLAÇÂO
    spline = inline(spline); %transformando spline em função inline
    Yint = spline(Xint); %realizando interpolação
    
    %PLOTANDO GRÁFICO
    k = i-1; %ponto inicial da spline
    plot(x,y,'o'), grid on, hold on;%plotando dados
    x1 = x(k):0.005:x(i);%intervalo em x
    y1 = spline(x1);%cálculo das imagens no intervalo
    plot(x1,y1), hold off;%plotando spline
end