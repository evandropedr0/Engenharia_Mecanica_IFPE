function [ Erro ] = erro_mmq( x, y, p )
%A função coef_mmq calcula os coeficientes de polinômio no máximo de 3º grau
%   Os coeficientes são calculados através da regressão linear por mínimos
%   múltiplos quadrados
%Argumentos de entrada:
%   xi = vetor linha contendo os valores de xi;
%   yi = vetor linha contendo os valores de yi;
%   g = grau do polinômio;
%Argumentos de saída:
%   Coef = matriz dos coeficientes;

format longe

tam_x=size(x);
tam_y=size(y);

if (tam_x(1)~=1)
    disp('xi não é vetor linha')
    an='erro';
    return
end

if (tam_y(1)~=1)
    disp('yi não é vetor linha')
    an='erro';
    return
end

if (tam_x(2)~=tam_y(2))
    disp('xi e yi não tem o mesmo tamanho')
    an='erro';
    return
end

%fim da validação dos dados de entrada
  
n=tam_x(2);
P=inline(p);
Erro=0;

for j=1:n
    Erro=Erro+((y(j)-P(x(j)))^2);
end
