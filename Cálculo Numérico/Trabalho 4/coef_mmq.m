function [ Coef ] = coef_mmq( x, y, g )
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

for i=1:g*2;
       somax(i)=sum(x.^(i));
end
    
A(1,1)=n;
b(1,1)=sum(y);
for j=2:g+1;
        A(1,j)=somax(j-1);
end
for i=2:g+1;
    for j=1:g+1;
        A(i,j)=somax(j+i-2);
        b(i,1)=sum(x.^(i-1).*y);
    end
end
    
Coef=(A\b)';

end
