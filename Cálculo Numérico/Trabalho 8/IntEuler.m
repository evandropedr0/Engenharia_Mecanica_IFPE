function [ I,X,Y ] = IntEuler(eq_dif,a,b,h,Cix,Ciy)
%Realiza integra��o num�rica de uma equa��o diferencial pelo m�todo de
%Euler.
%Par�metros: [ I ] = IntEuler(eq_dif,a,b,h,Cix,Ciy)
%eq_dif: equa��o diferencial
%a: in�cio do intervalo de integra��o
%b: fim do intervalo de integra��o
%h: tamanho do passo
%Cix: condi��o inicial para x
%Ciy: condi��o inicial para y
%I: valor da integral no ponto final (sa�da)
%X: vetor X (sa�da)
%Y: vetor Y (sa�da)

    %%%VALIDA��O%%%
    if isa(eq_dif,'sym')==false 
        eq_dif = sym(eq_dif); %transforma em uma fun��o simb�lica
    end
    if isnumeric(a)==false||isnumeric(b)==false||isnumeric(h)==false...
            ||isnumeric(Cix)==false||isnumeric(Ciy)==false
        disp('Erro. Par�metros a, b, h, Cix e Ciy devem ser num�ricos.');
        I = 'erro'; X = 'erro'; Y = 'erro'; return;
    end
    if a>b % a deve ser menor que b
        disp('Erro. Par�metro a deve ser menor que b.');
        I = 'erro'; X = 'erro'; Y = 'erro'; return;
    elseif a==b % a deve ser diferente de b
        disp('Erro. Par�metros a e b devem ser diferentes.');
        I = 'erro'; X = 'erro'; Y = 'erro'; return;
    end
    
    %%%PROCESSAMENTO%%%
    i = 1; %contador
    %declara��o de vetores com condi��es iniciais
    X = Cix;
    Y = Ciy;

    while(X(i,1) <= b)
        if (X(i,1) + h)>b
            break;
        end
        X(i+1,1) = X(i,1) + h; %pr�ximo valor de x
        %pr�xima aproxima��o da integral
        Y(i+1,1) = Y(i,1) + subs(eq_dif,X(i,1))*h;
        i = i+1; %incremento do contador
    end

	T = table(X,Y);
    disp('Resultados:');
    disp(T); %tabela com cada valor obtido a cada itera��o
    
    %%%SA�DA%%%
    I = Y(i,1);
end