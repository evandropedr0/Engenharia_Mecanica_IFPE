function [ Erro ] = erro_mmq( x, y, p )
%A fun��o coef_mmq calcula os coeficientes de polin�mio no m�ximo de 3� grau
%   Os coeficientes s�o calculados atrav�s da regress�o linear por m�nimos
%   m�ltiplos quadrados
%Argumentos de entrada:
%   xi = vetor linha contendo os valores de xi;
%   yi = vetor linha contendo os valores de yi;
%   g = grau do polin�mio;
%Argumentos de sa�da:
%   Coef = matriz dos coeficientes;

format longe

tam_x=size(x);
tam_y=size(y);

if (tam_x(1)~=1)
    disp('xi n�o � vetor linha')
    an='erro';
    return
end

if (tam_y(1)~=1)
    disp('yi n�o � vetor linha')
    an='erro';
    return
end

if (tam_x(2)~=tam_y(2))
    disp('xi e yi n�o tem o mesmo tamanho')
    an='erro';
    return
end

%fim da valida��o dos dados de entrada
  
n=tam_x(2);
P=inline(p);
Erro=0;

for j=1:n
    Erro=Erro+((y(j)-P(x(j)))^2);
end
