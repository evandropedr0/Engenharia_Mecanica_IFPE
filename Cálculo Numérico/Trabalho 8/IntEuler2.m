function [ I,X,Y ] = IntEuler2(eq_dif,a,b,h,Cix,Ciy)
%Realiza integração numérica de uma equação diferencial pelo método de
%Euler.
%Parâmetros: [ I ] = IntEuler(eq_dif,a,b,h,Cix,Ciy)
%eq_dif: equação diferencial
%a: início do intervalo de integração
%b: fim do intervalo de integração
%h: tamanho do passo
%Cix: condição inicial para x
%Ciy: condição inicial para y
%I: valor da integral no ponto final (saída)
%X: vetor X (saída)
%Y: vetor Y (saída)

    %%%VALIDAÇÃO%%%
    if isa(eq_dif,'sym')==false 
        eq_dif = sym(eq_dif); %transforma em uma função simbólica
    end
    if isnumeric(a)==false||isnumeric(b)==false||isnumeric(h)==false...
            ||isnumeric(Cix)==false||isnumeric(Ciy)==false
        disp('Erro. Parâmetros a, b, h, Cix e Ciy devem ser numéricos.');
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
    i = 1; %contador
    %declaração de vetores com condições iniciais
    X = a:h:b; X = X';
    X(1,1) = Cix;
    Y(1,1) = Ciy;

    for i = 2:length(X)
        %próxima aproximação da integral
        Y(i,1) = Y(i-1,1) + subs(eq_dif,X(i-1,1))*h;
    end

	T = table(X,Y);
    disp('Resultados:');
    disp(T); %tabela com cada valor obtido a cada iteração
    
    %%%SAÍDA%%%
    I = Y(i,1);
end