%%%PLOTANDO FIGURA%%%
a = [0 0 1 1]; b = [6.5 0 0 1]; %segmentos de reta da esquerda
plot(a,b,'r','LineWidth',3);
grid on; hold on;
a = [4 4 5 5]; b = [1 0 0 6.5]; %segmentos de reta da direita
plot(a,b,'r','LineWidth',3);

%Pontos da curva de baixo
x = [1,1.2,1.5,2,2.5,3,3.5,3.8,4];
y = [1,2,2.5,2.8,3,2.8,2.5,2,1];

CurvaDeBaixo = SplineCubica(x,y); %interponaldo com spline cúbica
plotarspline3(CurvaDeBaixo,x); %plotando

%calculando integral da curva de baixo
Ibaixo = 0;
for i = 1:length(CurvaDeBaixo)
    Ibaixo = Ibaixo + quad(inline(CurvaDeBaixo(i)),x(i),x(i+1));
end

%Pontos da curva de cima
x = [0 0.2 1 1.4 2 2.5 3 3.6 4 4.8 5];
y = [6.5 7 8.5 9 9.7 10 9.7 9 8.5 7 6.5];

CurvaDeCima = SplineCubica(x,y); %interponaldo com spline cúbica
plotarspline3(CurvaDeCima,x); %plotando

%calculando integral da curva de cima
Icima = 0;
for i = 1:length(CurvaDeCima)
    Icima = Icima + quad(inline(CurvaDeCima(i)),x(i),x(i+1));
end

%Pontos da curva do meio (parte superior)
x = [1 1.3 1.8 2 2.2 2.5 2.8 3 3.2 3.7 4];
y = [5.5 6 6.5 7 7.5 8 7.5 7 6.5 6 5.5];

MeioSuperior = SplineCubica(x,y); %interponaldo com spline cúbica
plotarspline3(MeioSuperior,x); %plotando

%calculando integral da curva do meio superior
Imeiosup = 0;
for i = 1:length(MeioSuperior)
    Imeiosup = Imeiosup + quad(inline(MeioSuperior(i)),x(i),x(i+1));
end

%Pontos da curva do meio (parte inferior)
x = [1 2.5 4];
y = [5.5 4.9 5.5];

MeioInferior = SplineCubica(x,y); %interponaldo com spline cúbica
plotarspline3(MeioInferior,x); %plotando

%calculando integral da curva do meio inferior
Imeioinf = 0;
for i = 1:length(MeioInferior)
    Imeioinf = Imeioinf + quad(inline(MeioInferior(i)),x(i),x(i+1));
end

axis equal tight %torna os eixos de igual tamanho e envolvendo somente a
                 %área da figura

PlotarGraficoImpar;

%%%CALCULANDO VOLUME%%%
Volume = Icima - Ibaixo - (Imeiosup - Imeioinf);
fprintf('O volume da figura suavizada é: %f\n',Volume);
clear;