function plotarfuncaoepontos(f,a,b,x,y)
%Plota fun��o f no intervalo [a,b] e pontos (x,y)

    %%%VALIDA��O
    if isa(f,'inline')==false
        f = inline(f);
    end
    if isnumeric(a)==false||isnumeric(b)==false||isnumeric(x)==false||...
            isnumeric(y)==false
        disp('a, b, x e y devem ser num�ricos.');
        return;
    end
    if a>b % a deve ser menor que b
        disp('Erro. Par�metro a deve ser menor que b.');
        return;
    elseif a==b % a deve ser diferente de b
        disp('Erro. Par�metros a e b devem ser diferentes.');
        return;
    end

    %%%PROCESSAMENTO E SA�DA
    X = a:0.01:b;
    Y = f(X);
    plot(X,Y,'b');
    grid on; hold on;
    plot(x,y,'r*');
end