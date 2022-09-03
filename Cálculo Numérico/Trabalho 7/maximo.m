function [ Ymax ] = maximo(f,a,b)
%Esta fun��o retorna o ponto y m�ximo de uma fun��o num intervalo [a,b]
%Par�metros: [ Xmax,Ymax ] = maximo(f,a,b)
%f: fun��o (simb�lica)
%a: extremo inferior do intervalo
%b: extremo superior do intervalo
%Ymax: coordenada y do ponto m�ximo (sa�da)

    %%%VALIDA��O%%%
    if ischar(f)==true 
        f = sym(f); %transforma string em uma fun��o simb�lica
    end
    if isnumeric(a)==false||isnumeric(b)==false
        disp('Erro. Par�metros a e b devem ser num�ricos.');
        Ymax = 'erro';
        return;
    end
    if a>b % a deve ser menor que b
        disp('Erro. Par�metro a deve ser menor que b.');
        Ymax = 'erro';
        return;
    elseif a==b % a deve ser diferente de b
        disp('Erro. Par�metros a e b devem ser diferentes.');
        Ymax = 'erro';
        return;
    end
    
    %%%PROCESSAMENTO%%%
    g = -f;%cria fun��o que � a negativa de f
    f = inline(f); %transforma f em inline
    g = inline(g); %transforma g em inline
    Xmax = fminbnd(g,a,b); %calcula o m�nimo de g, que � o m�ximo de f
    
    %%%SA�DA%%%
    Ymax = f(Xmax); %avalia f no ponto x m�ximo
end