function [ I,erro ] = IntegralPontoMedio(a,b,f,n)
%Calcula integral numericamente pelo m�todo do Ponto M�dio
%Par�metros: [ I,erro ] = IntegralTrapezio(a,b,f,n)
%a: ponto inicial do dom�nio de integra��o
%b: ponto final do dom�nio de integra��o
%f: fun��o do integrando 
%n: n�mero de intervalos
%I: valor da integral (sa�da)
%erro: estimativa de erro de truncamento (sa�da)

    %%%VALIDA��O%%%
    if isa(f,'sym')==false 
        f = sym(f); %transforma string em uma fun��o simb�lica
    end
    if isnumeric(a)==false||isnumeric(b)==false||isnumeric(n)==false
        disp('Erro. Par�metros a, b e n devem ser num�ricos.');
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
    if mod(fix(n),n)~=0||n<=0
        disp('Erro. N�mero de intervalos deve ser um inteiro positivo.');
        I = 'erro'; erro = I;
        return;
    end
    
    %%%PROCESSAMENTO%%%
    h = (b-a)/n; %define tamanho do intervalo
    x = a:h:b; %discretiza��o do dom�nio
    g = inline(f); %cria fun��o inline a partir de f    
    soma = 0; %declara��o da vari�vel do somat�rio
    for i = 1:n
        %calcula imagem de cada ponto m�dio e acrescenta � soma
        soma = soma + g((x(i)+x(i+1))/2);
    end
    
    %%%SA�DA%%%
    I = h*soma; %c�lculo da integral
    
    %c�lculo do erro
    erro = ((b-a)/24)*maximo(diff(f,2),a,b)*h^2;
end