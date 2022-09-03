%valores calculados analiticamente
for i = 1:12
    Vexato1(i,1) = pi;
    Vexato2(i,1) = -(2*pi)/15;
end

%declaração das funções
syms x;
f1 = x*sin(x);
f2 = x*sin(15*x);

%vetor com nomes dos métodos
metodos = string({'Analítico';'Trapézio 6pt';'Trapézio 12pt';...
    'Simpson 1/3 6pt';'Simpson 1/3 12pt';'Simpson 3/8 6pt';...
    'Simpson 3/8 12pt';'QG-Legendre 2pt';'QG-Legendre 3pt';...
    'QG-Legendre 4pt';'QG-Legendre 5pt';'QG-Legendre 6pt'});
metodos = cellstr(metodos);

%cálculo das integrais
%método do trapézio
I1(1,1) = IntegralTrapezio(0,pi,f1,6);
I1(2,1) = IntegralTrapezio(0,pi,f1,12);
I2(1,1) = IntegralTrapezio(0,2*pi,f2,6);
I2(2,1) = IntegralTrapezio(0,2*pi,f2,12);

%método de 1/3 de Simpson
I1(3,1) = IntegralSimpson13(0,pi,f1,6);
I1(4,1) = IntegralSimpson13(0,pi,f1,12);
I2(3,1) = IntegralSimpson13(0,2*pi,f2,6);
I2(4,1) = IntegralSimpson13(0,2*pi,f2,12);

%método de 3/8 de Simpson
I1(5,1) = IntegralSimpson38(0,pi,f1,6);
I1(6,1) = IntegralSimpson38(0,pi,f1,12);
I2(5,1) = IntegralSimpson38(0,2*pi,f2,6);
I2(6,1) = IntegralSimpson38(0,2*pi,f2,12);

%método da Quadratura de Gauss-Legendre
I1(7,1) = IntegralQuadraturaGauss(0,pi,f1,2);
I1(8,1) = IntegralQuadraturaGauss(0,pi,f1,3);
I1(9,1) = IntegralQuadraturaGauss(0,pi,f1,4);
I1(10,1) = IntegralQuadraturaGauss(0,pi,f1,5);
I1(11,1) = IntegralQuadraturaGauss(0,pi,f1,6);
I2(7,1) = IntegralQuadraturaGauss(0,2*pi,f2,2);
I2(8,1) = IntegralQuadraturaGauss(0,2*pi,f2,3);
I2(9,1) = IntegralQuadraturaGauss(0,2*pi,f2,4);
I2(10,1) = IntegralQuadraturaGauss(0,2*pi,f2,5);
I2(11,1) = IntegralQuadraturaGauss(0,2*pi,f2,6);

%inserindo valores exatos nos vetores dos resultados
I1 = [Vexato1(1);I1];
I2 = [Vexato2(1);I2];

%calculando erro relativo percentual
erro1 = ErroRelativoPercentual(Vexato1,I1);
erro2 = ErroRelativoPercentual(Vexato2,I2);

%criando tabela de saída
nomes = string({'Integral_i' 'Erro_Rel_i' 'Integral_ii','Erro_Rel_ii'});
nomes = cellstr(nomes);
T = table(I1,erro1,I2,erro2,'RowNames',metodos,'VariableNames',nomes)