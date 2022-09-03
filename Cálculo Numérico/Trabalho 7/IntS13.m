function [ I ] = IntS13(X,Y)
%Calcula integral numericamente pelo método de 1/3 de Simpson.
%Parâmetros: [ I ] = IntegralTrapezio(a,b,f,n)
%X: ponto inicial do domínio de integração
%Y: ponto final do domínio de integração
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
    if length(X)<=0||mod(length(X),2)~=0
        disp('Erro. Tamanho dos vetores deve ser não nulo e par.');
        I = 'erro'; return;
    end
    aux = X(2)-X(1);
    for i = 2:length(X)-1
        h = X(i+1)-X(i);
        if h~=aux
            disp('Erro. Vetor X deve ser igualmente espaçado.');
            I = 'erro'; return;
        end
    end
    clear aux;
    
    %%%PROCESSAMENTO E SAÍDA%%%
    I = 0; %declaração da variável do somatório
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