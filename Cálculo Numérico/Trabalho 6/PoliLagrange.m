function Ylag = PoliLagrange (x,y,Xlag)
%fun��o que realiza interpola��o usando o m�todo de lagrange
%Par�metros: Ylag = PoliLagrange (x,y,Xlag) 
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
    soma = 0; % vari�vel que guarda o resultado do produt�rio '(Li)*f(xi)'

    for i = 1:length(x) %la�o que soma os produt�rios
        produto = 1; %vari�vel que soma os produt�rios '(Li)*f(xi)'
        for j = 1:length(x) %la�o que realiza o produt�rio
            if i~=j %se i=j, x(i) n�o entra no denominador do produt�rio
                produto = produto*((a - x(j))/(x(i) - x(j))); %produt�rio
            end
        end
        produto = produto * y(i); % multiplica��o pela 'imagem' da fun��o 
        soma = soma + produto; % somat�rio dos produtos         
    end
    %soma agora � simb�lica e cont�m o polin�mio interpolador
    format long;
    
    disp('Coeficientes do polin�mio interpolador:');
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

    Ylag = sym2poly(subs(soma,a,Xlag)); %interpola��o
    
    %plotando gr�fico
    poli = inline(poli);
    plot(x,y,'o'), grid on, hold on;
    x1 = x(1):0.01:x(length(x));
    y1 = poli(x1);
    plot(x1,y1), hold off;
end