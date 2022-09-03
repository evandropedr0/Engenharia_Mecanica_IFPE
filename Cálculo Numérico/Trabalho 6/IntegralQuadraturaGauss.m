function [ I,erro ] = IntegralQuadraturaGauss(a,b,f,n)
%Calcula integral numericamente pelo m�todo da Quadratura de Gauss
%utilizando de 2 at� 6 pontos no dom�nio.
%Par�metros: [ I,erro ] = IntegralTrapezio(a,b,f,n)
%a: ponto inicial do dom�nio de integra��o
%b: ponto final do dom�nio de integra��o
%f: fun��o do integrando 
%n: n�mero de pontos
%I: valor da integral (sa�da)
%erro: estimativa de erro de truncamento (sa�da)

    %%%VALIDA��O%%%
    if isa(f,'sym')==false 
        f = sym(f); %transforma string em uma fun��o simb�lica
    end
    if isnumeric(a)==false||isnumeric(b)==false||isnumeric(n)==false
        disp('Erro. Par�metros a, b e tol devem ser num�ricos.');
        I = 'erro'; erro = I;
        return;
    end
    if a>b % a deve ser menor que b
        disp('Erro. Par�metro a deve ser menor que b.');
        I = 'erro'; erro = I;
        return;
    elseif a==b % a deve ser diferente de b
        disp('Erro. Par�metros a e b devem ser diferentes.');
        I = 'erro'; erro = I;
        return;
    end
    if mod(fix(n),n)~=0||n<2||n>6
        disp('Erro. N�mero de pontos deve ser um inteiro entre 2 e 6.');
        I = 'erro'; erro = I;
        return;
    end
        
    %%%PROCESSAMENTO%%%
    %definindo pontos e pesos
    if n==2
        %coeficientes (pesos)
        c = [1 1];
        %pontos do dom�nio
        x = [-0.577350269 0.577350269];
        df = diff(f,4); %calcula derivada de 4� ordem de f
    elseif n==3
        %coeficientes (pesos)
        c = [0.5555556 0.8888889 0.5555556];
        %pontos do dom�nio
        x = [-0.774596669 0 0.774596669];
        df = diff(f,6); %calcula derivada de 6� ordem de f
    elseif n==4
        %coeficientes (pesos)
        c = [0.3478548 0.6521452 0.6521452 0.3478548];
        %pontos do dom�nio
        x = [-0.861136312 -0.339981044 0.339981044 0.861136312];
        df = diff(f,8); %calcula derivada de 8� ordem de f
    elseif n==5
        %coeficientes (pesos)
        c = [0.2369269 0.4786287 0.5688889 0.4786287 0.2369269];
        %pontos do dom�nio
        x = [-0.906179846 -0.538469310 0 0.538469310 0.906179846];
        df = diff(f,10); %calcula derivada de 10� ordem de f
    elseif n==6
        %coeficientes (pesos)
        c = [0.1713245 0.3607616 0.4679139 0.4679139 0.3607616 0.1713245];
        %pontos do dom�nio
        x = [-0.932469514 -0.661209386 -0.238619186 0.238619186];
        x = [x  0.661209386 0.932469514];
        df = diff(f,12); %calcula derivada de 12� ordem de f
    end
    
    %mudan�a de vari�vel
    g = inline('(t*(b-a)+a+b)/2'); %cria fun��o de mudan�a de vari�vel
    dt = (b-a)/2; %termo jacobiano da mudan�a de vari�vel
    f = inline(f); %transforma f de simb�lica para inline
    
    %%%SA�DA%%%
    %c�lculo da integral
    I = 0; %declara��o de vari�vel de sa�da inicialmente nula
    for i = 1:n
        I = I + c(i)*f(g(a,b,x(i)))*dt;
    end
    %c�lculo do erro
    erro = ((2^(2*n+3))*(factorial(n+1))^4)/((2*n+3)*(factorial(2*n+2))^3);
    erro = erro*(maximo(df,a,b));
end