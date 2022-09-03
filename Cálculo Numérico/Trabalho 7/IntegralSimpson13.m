function [ I ] = IntegralSimpson13(a,b,f,n)
%Calcula integral numericamente pelo método de 1/3 de Simpson.
%Parâmetros: [ I ] = IntegralTrapezio(a,b,f,n)
%a: ponto inicial do domínio de integração
%b: ponto final do domínio de integração
%f: função do integrando
%n: número de intervalos
%I: valor da integral (saída)

    %%%VALIDAÇÃO%%%
    if isa(f,'inline')==false 
        f = inline(f); %transforma string em uma função inline
    end
    if isnumeric(a)==false||isnumeric(b)==false||isnumeric(n)==false
        disp('Erro. Parâmetros a, b e tol devem ser numéricos.');
        I = 'erro';
        return;
    end
    if a>b % a deve ser menor que b
        disp('Erro. Parâmetro a deve ser menor que b.');
        I = 'erro';
        return;
    elseif a==b % a deve ser diferente de b
        disp('Erro. Parâmetros a e b devem ser diferentes.');
        I = 'erro';
        return;
    end
    if mod(fix(n),n)~=0||n<=0||mod(n,2)~=0
        disp('Erro. Número de intervalos deve ser inteiro, positivo e par.');
        I = 'erro';
        return;
    end
    
    %%%PROCESSAMENTO%%%
    h = (b-a)/n; %define tamanho do intervalo
    x = a:h:b; %discretização do domínio
    y = f(x); %imagens dos pontos do domínio discretizado
    soma = 0; %declaração da variável do somatório
    for i = 2:n %pontos internos
        if mod(i,2)==0
            soma = soma + 4*y(i);
        else
            soma = soma + 2*y(i);
        end
    end
    soma = (h/3)*soma; %fator externo ao somatório
    
    %%%SAÍDA%%%
    I = soma + (h/3)*(y(1)+y(n+1)); %adiciona pontos das extremidades
end