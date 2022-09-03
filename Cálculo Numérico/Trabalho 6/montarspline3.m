function [ spline ] = montarspline3(x,y,i,a,h)
%Esta fun��o cria uma spline c�bica.
%Par�metros: [ spline ] = montarspline3(i,a,h)
%x: vetor de pontos x
%y: vetor de pontos y (imagens de x)
%i: ponto inicial do intervalo
%a: vetor de coeficientes
%h: vetor de tamanhos de intervalos

    syms X;
    spline = (a(i)/(6*h(i)))*((x(i+1)-X)^3);%1� parte
    spline = spline + (a(i+1)/(6*h(i)))*((X-x(i))^3);%2� parte
    spline = spline + ((y(i)/h(i))-((a(i)*h(i))/6))*(x(i+1)-X);%3� parte
    spline = spline + ((y(i+1)/h(i))-((a(i+1)*h(i))/6))*(X-x(i));%4� parte
end