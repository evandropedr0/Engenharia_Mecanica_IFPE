function [ I ] = IntS13(X,Y)
%Calcula integral numericamente pelo m�todo de 1/3 de Simpson.
%Par�metros: [ I ] = IntegralTrapezio(a,b,f,n)
%X: ponto inicial do dom�nio de integra��o
%Y: ponto final do dom�nio de integra��o
%I: valor da integral (sa�da)

    %%%VALIDA��O%%%
    if isnumeric(X)==false||isnumeric(Y)==false
        disp('Erro. Par�metros devem ser num�ricos.');
        I = 'erro'; return;
    end
    if(((size(X,1)>1)&&(size(X,2)>1))||((size(Y,1)>1)&&(size(Y,2)>1)))
        disp('Erro! X ou Y n�o � um vetor.');
        I = 'erro'; return;
    elseif(length(X)~=length(Y))%x e y devem ter mesmo n�mero de elementos
        disp('Erro! Dimens�es de X e Y n�o s�o equivalentes.');
        I = 'erro'; return;
    end
    if length(X)<=0||mod(length(X),2)~=0
        disp('Erro. Tamanho dos vetores deve ser n�o nulo e par.');
        I = 'erro'; return;
    end
    aux = X(2)-X(1);
    for i = 2:length(X)-1
        h = X(i+1)-X(i);
        if h~=aux
            disp('Erro. Vetor X deve ser igualmente espa�ado.');
            I = 'erro'; return;
        end
    end
    clear aux;
    
    %%%PROCESSAMENTO E SA�DA%%%
    I = 0; %declara��o da vari�vel do somat�rio
    for i = 1:length(X)
        if i==1 || i==lentgh(X)
            I = I + Y(i);
        elseif mod(i,2)==0
            I = I + 4*Y(i);
        else
            I = I + 2*Y(i);
        end
    end
    I = (h/3)*I;
end