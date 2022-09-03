function [ Yint ] = PoliVandermonde(x,y,Xint)
%Fun��o que realiza interpola��o pelo m�todo padr�o, utilizando a matriz de
%Vandermonde.
%Par�metros: Yint = PoliNewton (x,y,Xint) 
% x e y s�o os pontos que pertencem ao conjuto de dados
% Xint � o ponto a ser interpolado
% Yint � a sa�da: valor interpolado

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
    A = ones(length(x));% matriz dos coeficientes inicialmente unit�ria
    for i = 2:length(x) %criando matriz de Vandermonde
        A(:,i) = x.^(i-1);
    end
    
    %resultados
    format long;
    disp('Coeficientes do polin�mio interpolador');
    d = A\y'; %solu��o do sistema linear
    c = d; %criando um vetor do tamanho de d
    j = length(x); %vari�vel auxiliar
    for i = 1:j %invertendo vetor de coeficientes
        c(i) = d(j);
        j = j - 1;
    end
    disp(c);
    %imprimindo polin�mio interpolador com vari�vel simb�lica
    poli = poly2sym(c);
    disp('Polin�mio interpolador:');
    pretty(poli);
    poli = inline(poli);
    
    Yint = poli(Xint); %interpola��o
    
    %plotando gr�fico
    plot(x,y,'o'), grid on, hold on;
    x1 = x(1):0.01:x(length(x));
    y1 = poli(x1);
    plot(x1,y1), hold off;
end

