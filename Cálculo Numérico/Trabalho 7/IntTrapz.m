function [ I ] = IntTrapz(X,Y)
%Calcula integral numericamente pelo método do Trapézio
%Parâmetros: [ I ] = IntTrapz(X,Y)
%X: vetor do domínio
%Y: vetor de imagens
%I: valor da integral (saída)

    %%%VALIDAÇÃO%%%
    if isnumeric(X)==false||isnumeric(Y)==false
        disp('Erro. Parâmetros devem ser numéricos.');
        I = 'erro'; return;
    end
    if(((size(X,1)>1)&&(size(X,2)>1))||((size(Y,1)>1)&&(size(Y,2)>1)))
        disp('Erro! X ou Y não é um vetor.');
        I = 'erro'; return;
    elseif(length(X)~=length(Y))%x e y devem ter mesmo número de elementos
        disp('Erro! Dimensões de X e Y não são equivalentes.');
        I = 'erro'; return;
    end
    if length(X)<=1
        disp('Erro. Vetores devem ter ao menos 2 elementos.');
        I = 'erro'; return;
    end
    
    %%%PROCESSAMENTO E SAÍDA%%%
    I = 0;
    for i = 1:length(X)-1
        %calcula a interpolação do ponto médio e multiplica pelo tamanho do
        %intervalo
        I = I + ((Y(i+1)+Y(i))*(X(i+1)-X(i)))/2;
    end
end