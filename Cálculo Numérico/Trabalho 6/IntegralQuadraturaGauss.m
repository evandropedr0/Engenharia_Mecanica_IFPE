function [ I,erro ] = IntegralQuadraturaGauss(a,b,f,n)
%Calcula integral numericamente pelo método da Quadratura de Gauss
%utilizando de 2 até 6 pontos no domínio.
%Parâmetros: [ I,erro ] = IntegralTrapezio(a,b,f,n)
%a: ponto inicial do domínio de integração
%b: ponto final do domínio de integração
%f: função do integrando 
%n: número de pontos
%I: valor da integral (saída)
%erro: estimativa de erro de truncamento (saída)

    %%%VALIDAÇÃO%%%
    if isa(f,'sym')==false 
        f = sym(f); %transforma string em uma função simbólica
    end
    if isnumeric(a)==false||isnumeric(b)==false||isnumeric(n)==false
        disp('Erro. Parâmetros a, b e tol devem ser numéricos.');
        I = 'erro'; erro = I;
        return;
    end
    if a>b % a deve ser menor que b
        disp('Erro. Parâmetro a deve ser menor que b.');
        I = 'erro'; erro = I;
        return;
    elseif a==b % a deve ser diferente de b
        disp('Erro. Parâmetros a e b devem ser diferentes.');
        I = 'erro'; erro = I;
        return;
    end
    if mod(fix(n),n)~=0||n<2||n>6
        disp('Erro. Número de pontos deve ser um inteiro entre 2 e 6.');
        I = 'erro'; erro = I;
        return;
    end
        
    %%%PROCESSAMENTO%%%
    %definindo pontos e pesos
    if n==2
        %coeficientes (pesos)
        c = [1 1];
        %pontos do domínio
        x = [-0.577350269 0.577350269];
        df = diff(f,4); %calcula derivada de 4ª ordem de f
    elseif n==3
        %coeficientes (pesos)
        c = [0.5555556 0.8888889 0.5555556];
        %pontos do domínio
        x = [-0.774596669 0 0.774596669];
        df = diff(f,6); %calcula derivada de 6ª ordem de f
    elseif n==4
        %coeficientes (pesos)
        c = [0.3478548 0.6521452 0.6521452 0.3478548];
        %pontos do domínio
        x = [-0.861136312 -0.339981044 0.339981044 0.861136312];
        df = diff(f,8); %calcula derivada de 8ª ordem de f
    elseif n==5
        %coeficientes (pesos)
        c = [0.2369269 0.4786287 0.5688889 0.4786287 0.2369269];
        %pontos do domínio
        x = [-0.906179846 -0.538469310 0 0.538469310 0.906179846];
        df = diff(f,10); %calcula derivada de 10ª ordem de f
    elseif n==6
        %coeficientes (pesos)
        c = [0.1713245 0.3607616 0.4679139 0.4679139 0.3607616 0.1713245];
        %pontos do domínio
        x = [-0.932469514 -0.661209386 -0.238619186 0.238619186];
        x = [x  0.661209386 0.932469514];
        df = diff(f,12); %calcula derivada de 12ª ordem de f
    end
    
    %mudança de variável
    g = inline('(t*(b-a)+a+b)/2'); %cria função de mudança de variável
    dt = (b-a)/2; %termo jacobiano da mudança de variável
    f = inline(f); %transforma f de simbólica para inline
    
    %%%SAÍDA%%%
    %cálculo da integral
    I = 0; %declaração de variável de saída inicialmente nula
    for i = 1:n
        I = I + c(i)*f(g(a,b,x(i)))*dt;
    end
    %cálculo do erro
    erro = ((2^(2*n+3))*(factorial(n+1))^4)/((2*n+3)*(factorial(2*n+2))^3);
    erro = erro*(maximo(df,a,b));
end