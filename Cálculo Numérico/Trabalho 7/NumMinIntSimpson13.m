function [ n ] = NumMinIntSimpson13(a,b,f,tol)
%Esta fun��o calcula o n�mero m�nimo de intervalos para garantir uma
%exatid�o definida no processo de integra��o num�rica pelo m�todo de
%Simpson de 1/3.
%Par�metros: [ n ] = NumMinIntSimpson13(a,b,f,tol)
%a: extremo esquerdo do dom�nio de integra��o
%b: extremo direito do dom�nio de integra��o
%f: fun��o do integrando
%tol: toler�ncia de exatid�o.

    %%%VALIDA��O%%%
    if isa(f,'sym')==false 
        f = sym(f); %transforma string em uma fun��o simb�lica
    end
    if isnumeric(a)==false||isnumeric(b)==false||isnumeric(tol)==false
        disp('Erro. Par�metros a, b e tol devem ser num�ricos.');
        n = 'erro';
        return;
    end
    if a>b % a deve ser menor que b
        disp('Erro. Par�metro a deve ser menor que b.');
        n = 'erro';
        return;
    elseif a==b % a deve ser diferente de b
        disp('Erro. Par�metros a e b devem ser diferentes.');
        n = 'erro';
        return;
    end
    
    %%%PROCESSAMENTO%%%
    d4f = diff(f,4); %calcula segunda derivada de f
    ymax = maximo(d4f,a,b); %calcula ponto m�ximo de d4f
    
    %calcula tamanho do passo de acordo com f�rmula de estimativa de erro
    %do m�todo do trap�zio
    h = ((180*abs(tol))/(abs(b-a)*abs(ymax)))^(1/4);
    
    %%%SA�DA%%%
    n = ceil((b-a)/h); %calcula o n�mero de passos no intervalo
    if mod(n,2)~=0 %se n for impar, acrescenta mais uma unidade
        n = n+1;
    end
end