function [ I ] = IntTrapz(X,Y)
%Calcula integral numericamente pelo m�todo do Trap�zio
%Par�metros: [ I ] = IntTrapz(X,Y)
%X: vetor do dom�nio
%Y: vetor de imagens
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
    if length(X)<=1
        disp('Erro. Vetores devem ter ao menos 2 elementos.');
        I = 'erro'; return;
    end
    
    %%%PROCESSAMENTO E SA�DA%%%
    I = 0;
    for i = 1:length(X)-1
        %calcula a interpola��o do ponto m�dio e multiplica pelo tamanho do
        %intervalo
        I = I + ((Y(i+1)+Y(i))*(X(i+1)-X(i)))/2;
    end
end