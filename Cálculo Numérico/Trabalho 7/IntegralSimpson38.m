function [ I ] = IntegralSimpson38(a,b,f,n)
%Calcula integral numericamente pelo m�todo de 3/8 de Simpson.
%Par�metros: [ I ] = IntegralTrapezio(a,b,f,n)
%a: ponto inicial do dom�nio de integra��o
%b: ponto final do dom�nio de integra��o
%f: fun��o do integrando
%n: n�mero de intervalos
%I: valor da integral (sa�da)

    %%%VALIDA��O%%%
    if isa(f,'inline')==false 
        f = inline(f); %transforma string em uma fun��o inline
    end
    if isnumeric(a)==false||isnumeric(b)==false||isnumeric(n)==false
        disp('Erro. Par�metros a, b e tol devem ser num�ricos.');
        I = 'erro';
        return;
    end
    if a>b % a deve ser menor que b
        disp('Erro. Par�metro a deve ser menor que b.');
        I = 'erro';
        return;
    elseif a==b % a deve ser diferente de b
        disp('Erro. Par�metros a e b devem ser diferentes.');
        I = 'erro';
        return;
    end
    if mod(fix(n),n)~=0||n<=0||mod(n,3)~=0
        disp('Erro. N�mero de intervalos deve ser inteiro, positivo e divis�vel por 3.');
        I = 'erro';
        return;
    end
    
    %%%PROCESSAMENTO%%%
    h = (b-a)/n; %define tamanho do intervalo
    x = a:h:b; %discretiza��o do dom�nio
    y = f(x); %imagens dos pontos do dom�nio discretizado
    soma = 0; %declara��o da vari�vel do somat�rio
    j = 1; %vari�vel auxiliar
    for i = 2:n %pontos internos
        if mod(j,3)==0 %entra nessa condi��o a cada 3 itera��es
            soma = soma + 2*y(i);
            j = 0; %restaura valor de j
        else
            soma = soma + 3*y(i);
        end
        j = j + 1; %incrementa j
    end
    soma = (3*h/8)*soma; %fator externo ao somat�rio
    
    %%%SA�DA%%%
    I = soma + (3*h/8)*(y(1)+y(n+1)); %adiciona pontos das extremidades
end