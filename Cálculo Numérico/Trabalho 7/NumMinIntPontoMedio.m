function [ n ] = NumMinIntPontoMedio(a,b,f,tol)
%Esta fun��o calcula o n�mero m�nimo de intervalos para garantir uma
%exatid�o definida no processo de integra��o num�rica pelo m�todo do
%ponto m�dio.
%Par�metros: [ n ] = NumMinIntTrapezio(a,b,f,tol)
%a: extremo inferior do dom�nio de integra��o
%b: extremo superior do dom�nio de integra��o
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
    d2f = diff(f,2); %calcula segunda derivada de f
    ymax = maximo(d2f,a,b); %calcula ponto m�ximo de d2f
    
    %calcula tamanho do passo de acordo com f�rmula de estimativa de erro
    %do m�todo do trap�zio
    h = sqrt((24*abs(tol))/(abs(b-a)*abs(ymax)));
    
    %%%SA�DA%%%
    n = ceil((b-a)/h); %calcula o n�mero de passos no intervalo e arredonda
                       %para cima
end