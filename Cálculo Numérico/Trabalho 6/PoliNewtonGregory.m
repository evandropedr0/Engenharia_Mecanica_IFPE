function Yint = PoliNewtonGregory(x,y,Xint)
%Fun��o que realiza interpola��o pelo m�todo de Newton-Gregory
%Par�metros: Yint = PoliNewton (x,y,Xint) 
% x e y s�o os pontos que pertencem ao conjuto de dados
% Xint � o ponto a ser interpolado
% Yint � a sa�da: valor interpolado

    %valida��o
    if isnumeric(x)==false||isnumeric(y)==false|| ...
            isnumeric(Xint)==false %um dos par�metros n�o � num�rico
        disp('Erro. Todos os par�metros devem ser num�ricos.');
        Yint = 'erro';
        return;
    end
    if(((size(x,1)>1)&&(size(x,2)>1))||((size(y,1)>1)&&(size(y,2)>1)))
        disp('Erro! X ou Y n�o � um vetor.');
        Yint = 'erro';
        return;
    elseif(length(x)~=length(y))%x e y devem ter mesmo n�mero de elementos
        disp('Erro! Dimens�es de X e Y n�o s�o equivalentes.');
        Yint = 'erro';
        return;
    end
    if length(x)>2
        anterior = abs(x(2)-x(1));
        for i = 2:length(x)-1
            atual = abs(x(i+1)-x(i));
            if atual~=anterior
                disp('Erro! Vetor x deve ser igualmente espa�ado.');
                Yint = 'erro';
                return;
            end
        end
    end
    syms a;%vari�vel simb�lica usada no c�lculo do polin�mio interpolador
    diford = zeros(length(y));%matriz que armazena as diferen�as ordin�rias
    diford(:,1) = y; %1� coluna da matriz � o pr�prio vetor y
    for j = 2:length(y) %colunas
        for i = 1:(length(y)+1-j) %linhas
            diford(i,j) = diford(i+1,j-1)-diford(i,j-1);
        end
    end

    soma = diford(1,1); %polin�mio interpolador com valor inicial
    %#ok<*NASGU>
    produtorio = 1; %vari�vel que guarda os produt�rios
    h = x(2)-x(1); %tamanho do espa�amento
    for i = 2:length(x) %la�o que constr�i o polin�mio interpolador
        produtorio = produtorio * (a - x(i-1));
        soma = soma + (diford(1,i)/(factorial(i-1)*h^(i-1)))*produtorio;
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
    
    disp('Diferen�as ordin�rias:');
    disp(diford);
    
    Yint = sym2poly(subs(soma,a,Xint)); %interpola��o
    
    %plotando gr�fico
    poli = inline(poli);
    plot(x,y,'o'), grid on, hold on;
    x1 = x(1):0.01:x(length(x));
    y1 = poli(x1);
    plot(x1,y1), hold off;
end