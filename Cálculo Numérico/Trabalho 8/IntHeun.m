function [ I,X,Y ] = IntHeun(eq_dif,a,b,h,Cix,Ciy,it)
%Realiza integração numérica de uma equação diferencial pelo método de
%Heun.
%Parâmetros: [ I ] = IntEuler(eq_dif,a,b,h,Cix,Ciy)
%eq_dif: equação diferencial
%a: início do intervalo de integração
%b: fim do intervalo de integração
%h: tamanho do passo
%Cix: condição inicial para x
%Ciy: condição inicial para y
%it: número de iterações para cada passo
%I: valor da integral no ponto final (saída)
%X: vetor X (saída)
%Y: vetor Y (saída)

    %%%VALIDAÇÃO%%%
    if isa(eq_dif,'sym')==false 
        eq_dif = sym(eq_dif); %transforma em uma função simbólica
    end
    if isnumeric(a)==false||isnumeric(b)==false||isnumeric(h)==false...
            ||isnumeric(Cix)==false||isnumeric(Ciy)==false...
            isnumeric(it)==false
        disp('Parâmetros a, b, h, Cix, Ciy e it devem ser numéricos.');
        I = 'erro'; X = 'erro'; Y = 'erro'; return;
    end
    if a>b % a deve ser menor que b
        disp('Erro. Parâmetro a deve ser menor que b.');
        I = 'erro'; X = 'erro'; Y = 'erro'; return;
    elseif a==b % a deve ser diferente de b
        disp('Erro. Parâmetros a e b devem ser diferentes.');
        I = 'erro'; X = 'erro'; Y = 'erro'; return;
    end
    
    %%%PROCESSAMENTO%%%
    syms x; %variável simbólica
    syms y; %variável simbólica
    i = 1; %contador
    %declaração de vetores com condições iniciais
    X = Cix;
    Y = Ciy;

    while(X(i,1) <= b)
        if (X(i,1) + h)>b
            break;
        end
        %cálculo do preditor
        Y(i+1,1) = Y(i,1) + subs(eq_dif,{x,y},{X(i,1),Y(i,1)})*h;
        %laço que faz a quantidade de iterações necessárias a cada ponto
        for j = 1:1:it
            %corretor
            Y(i+1,1) = Y(i,1)+((subs(eq_dif,{x,y},{X(i,1),Y(i,1)})+subs(eq_dif,{x,y},{X(i,1)+h,Y(i+1,1)}))*h)/2;
        end
        X(i+1,1) = X(i,1) + h; %incremento do passo em x
        i = i + 1; %incremento do contador
    end

	T = table(X,Y);
    disp('Resultados:');
    disp(T); %tabela com cada valor obtido a cada iteração
    
    %%%SAÍDA%%%
    I = Y(i,1);
end