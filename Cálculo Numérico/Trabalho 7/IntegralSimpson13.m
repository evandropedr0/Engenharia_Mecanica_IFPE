function [ I ] = IntegralSimpson13(a,b,f,n)
%Calcula integral numericamente pelo m�todo de 1/3 de Simpson.
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
    if mod(fix(n),n)~=0||n<=0||mod(n,2)~=0
        disp('Erro. N�mero de intervalos deve ser inteiro, positivo e par.');
        I = 'erro';
        return;
    end
    
    %%%PROCESSAMENTO%%%
    h = (b-a)/n; %define tamanho do intervalo
    x = a:h:b; %discretiza��o do dom�nio
    y = f(x); %imagens dos pontos do dom�nio discretizado
    soma = 0; %declara��o da vari�vel do somat�rio
    for i = 2:n %pontos internos
        if mod(i,2)==0
            soma = soma + 4*y(i);
        else
            soma = soma + 2*y(i);
        end
    end
    soma = (h/3)*soma; %fator externo ao somat�rio
    
    %%%SA�DA%%%
    I = soma + (h/3)*(y(1)+y(n+1)); %adiciona pontos das extremidades
end