function [ Yint ] = PoliVandermonde(x,y,Xint)
%Função que realiza interpolação pelo método padrão, utilizando a matriz de
%Vandermonde.
%Parâmetros: Yint = PoliNewton (x,y,Xint) 
% x e y são os pontos que pertencem ao conjuto de dados
% Xint é o ponto a ser interpolado
% Yint é a saída: valor interpolado

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
    A = ones(length(x));% matriz dos coeficientes inicialmente unitária
    for i = 2:length(x) %criando matriz de Vandermonde
        A(:,i) = x.^(i-1);
    end
    
    %resultados
    format long;
    disp('Coeficientes do polinômio interpolador');
    d = A\y'; %solução do sistema linear
    c = d; %criando um vetor do tamanho de d
    j = length(x); %variável auxiliar
    for i = 1:j %invertendo vetor de coeficientes
        c(i) = d(j);
        j = j - 1;
    end
    disp(c);
    %imprimindo polinômio interpolador com variável simbólica
    poli = poly2sym(c);
    disp('Polinômio interpolador:');
    pretty(poli);
    poli = inline(poli);
    
    Yint = poli(Xint); %interpolação
    
    %plotando gráfico
    plot(x,y,'o'), grid on, hold on;
    x1 = x(1):0.01:x(length(x));
    y1 = poli(x1);
    plot(x1,y1), hold off;
end

