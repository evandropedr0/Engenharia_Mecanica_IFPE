function [ I,X,Y ] = IntHeun(eq_dif,a,b,h,Cix,Ciy,it)
%Realiza integra��o num�rica de uma equa��o diferencial pelo m�todo de
%Heun.
%Par�metros: [ I ] = IntEuler(eq_dif,a,b,h,Cix,Ciy)
%eq_dif: equa��o diferencial
%a: in�cio do intervalo de integra��o
%b: fim do intervalo de integra��o
%h: tamanho do passo
%Cix: condi��o inicial para x
%Ciy: condi��o inicial para y
%it: n�mero de itera��es para cada passo
%I: valor da integral no ponto final (sa�da)
%X: vetor X (sa�da)
%Y: vetor Y (sa�da)

    %%%VALIDA��O%%%
    if isa(eq_dif,'sym')==false 
        eq_dif = sym(eq_dif); %transforma em uma fun��o simb�lica
    end
    if isnumeric(a)==false||isnumeric(b)==false||isnumeric(h)==false...
            ||isnumeric(Cix)==false||isnumeric(Ciy)==false...
            isnumeric(it)==false
        disp('Par�metros a, b, h, Cix, Ciy e it devem ser num�ricos.');
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
    syms x; %vari�vel simb�lica
    syms y; %vari�vel simb�lica
    i = 1; %contador
    %declara��o de vetores com condi��es iniciais
    X = Cix;
    Y = Ciy;

    while(X(i,1) <= b)
        if (X(i,1) + h)>b
            break;
        end
        %c�lculo do preditor
        Y(i+1,1) = Y(i,1) + subs(eq_dif,{x,y},{X(i,1),Y(i,1)})*h;
        %la�o que faz a quantidade de itera��es necess�rias a cada ponto
        for j = 1:1:it
            %corretor
            Y(i+1,1) = Y(i,1)+((subs(eq_dif,{x,y},{X(i,1),Y(i,1)})+subs(eq_dif,{x,y},{X(i,1)+h,Y(i+1,1)}))*h)/2;
        end
        X(i+1,1) = X(i,1) + h; %incremento do passo em x
        i = i + 1; %incremento do contador
    end

	T = table(X,Y);
    disp('Resultados:');
    disp(T); %tabela com cada valor obtido a cada itera��o
    
    %%%SA�DA%%%
    I = Y(i,1);
end