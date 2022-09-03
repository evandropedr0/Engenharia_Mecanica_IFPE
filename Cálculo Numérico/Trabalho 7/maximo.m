function [ Ymax ] = maximo(f,a,b)
%Esta função retorna o ponto y máximo de uma função num intervalo [a,b]
%Parâmetros: [ Xmax,Ymax ] = maximo(f,a,b)
%f: função (simbólica)
%a: extremo inferior do intervalo
%b: extremo superior do intervalo
%Ymax: coordenada y do ponto máximo (saída)

    %%%VALIDAÇÃO%%%
    if ischar(f)==true 
        f = sym(f); %transforma string em uma função simbólica
    end
    if isnumeric(a)==false||isnumeric(b)==false
        disp('Erro. Parâmetros a e b devem ser numéricos.');
        Ymax = 'erro';
        return;
    end
    if a>b % a deve ser menor que b
        disp('Erro. Parâmetro a deve ser menor que b.');
        Ymax = 'erro';
        return;
    elseif a==b % a deve ser diferente de b
        disp('Erro. Parâmetros a e b devem ser diferentes.');
        Ymax = 'erro';
        return;
    end
    
    %%%PROCESSAMENTO%%%
    g = -f;%cria função que é a negativa de f
    f = inline(f); %transforma f em inline
    g = inline(g); %transforma g em inline
    Xmax = fminbnd(g,a,b); %calcula o mínimo de g, que é o máximo de f
    
    %%%SAÍDA%%%
    Ymax = f(Xmax); %avalia f no ponto x máximo
end