function Ylag = PoliNewton(x,y,Xlag)
%Fun��o que realiza interpola��o pelo m�todo de Newton
%Par�metros: Ylag = PoliNewton (x,y,Xlag) 
% x e y s�o os pontos que pertencem ao conjuto de dados
% Xlag � o ponto a ser interpolado
% Ylag � a sa�da: valor interpolado

    %valida��o
    if isnumeric(x)==false||isnumeric(y)==false|| ...
            isnumeric(Xlag)==false %um dos par�metros n�o � num�rico
        disp('Erro. Todos os par�metros devem ser num�ricos.');
        Ylag = 'erro';
        return;
    end
    if(((size(x,1)>1)&&(size(x,2)>1))||((size(y,1)>1)&&(size(y,2)>1)))
        disp('Erro! X ou Y n�o � um vetor.');
        Ylag = 'erro';
        return;
    elseif(length(x)~=length(y))%x e y devem ter mesmo n�mero de elementos
        disp('Erro! Dimens�es de X e Y n�o s�o equivalentes.');
        Ylag = 'erro';
        return;
    end

    syms a;%vari�vel simb�lica usada no c�lculo do polin�mio interpolador
    difdiv = zeros(length(y)); %matriz que armazena as diferen�as divididas
    difdiv(:,1) = y; %1� coluna da matriz � o pr�prio vetor y
    aux = 1; %vari�vel auxiliar
    for j = 2:length(y) %colunas
        for i = 1:(length(y)+1-j) %linhas
            difdiv(i,j) = (difdiv(i,j-1)-difdiv(i+1,j-1))/(x(i)-x(i+aux));
        end
        aux = aux + 1;
    end

    soma = difdiv(1,1); %polin�mio interpolador com valor inicial
    %#ok<*NASGU>
    produtorio = 1; %vari�vel que guarda os produt�rios
    for i = 2:length(x) %la�o que constr�i o polin�mio interpolador
        produtorio = produtorio * (a - x(i-1));
        soma = soma + difdiv(1,i)*produtorio;
    end
    %soma agora � simb�lica e cont�m o polin�mio interpolador
    format long;
    
    disp('Coeficientes do polin�mio interpolador');
    %disp('(do menor ao maior grau):');
    c = sym2poly(soma);
    disp(c'); %imprime coeficientes
    
    %imprimindo polin�mio interpolador com vari�vel simb�lica
    poli = 0;
    j = 0;
    for i = length(c):-1:1
        poli = poli + c(i)*a^(j);
        j = j + 1;
    end
    disp('Polin�mio interpolador:');
    pretty(poli);
    
    disp('Diferen�as divididas:');
    disp(difdiv);
    
    Ylag = sym2poly(subs(soma,a,Xlag)); %interpola��o
    
    %plotando gr�fico
    poli = inline(poli);
    plot(x,y,'o'), grid on, hold on;
    x1 = x(1):0.01:x(length(x));
    y1 = poli(x1);
    plot(x1,y1), hold off;
end