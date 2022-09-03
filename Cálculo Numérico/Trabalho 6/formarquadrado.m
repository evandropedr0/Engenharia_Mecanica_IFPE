function [ X,Y ] = formarquadrado(x,y)
%Esta função recebe um par ordenado (x,y) que representa o ponto inferior
%esquerdo de um quadrado unitário e retorna dois vetores contendo os
%vértices do quadrado.

    %%%VALIDAÇÃO%%%
    if isnumeric(x)==false||isnumeric(y)==false
        disp('Erro! Todos os parâmetros devem ser numéricos.');
        X = 'erro';
        Y = 'erro';
        return;
    end
    if size(x,1)~=1||size(x,2)~=1||size(y,1)~=1||size(y,2)~=1
        disp('Erro! Parâmetros não podem ser vetores ou matrizes.');
        X = 'erro';
        Y = 'erro';
        return;
    end
    
    %%%PROCESSAMENTO E SAÍDA%%%
    %declarando vetores de saída
    X = zeros(4,1);
    Y = zeros(4,1);
    %preenchendo vetores de saída
    X(1) = x; X(2) = x;
    X(3) = x+1; X(4) = x+1;
    Y(1) = y; Y(2) = y+1;
    Y(3) = y+1; Y(4) = y;
end