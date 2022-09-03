function Ylag = PoliLagrange (x,y,Xlag)
%função que realiza interpolação usando o método de lagrange
%Parâmetros: Ylag = PoliLagrange (x,y,Xlag) 
% x e y são os pontos que pertencem ao conjuto de dados
% Xlag é o ponto a ser interpolado
% Ylag é a saída: valor interpolado

    %validação
    if isnumeric(x)==false||isnumeric(y)==false|| ...
            isnumeric(Xlag)==false %um dos parâmetros não é numérico
        disp('Erro. Todos os parâmetros devem ser numéricos.');
        Ylag = 'erro';
        return;
    end
    if(((size(x,1)>1)&&(size(x,2)>1))||((size(y,1)>1)&&(size(y,2)>1)))
        disp('Erro! X ou Y não é um vetor.');
        Ylag = 'erro';
        return;
    elseif(length(x)~=length(y))%x e y devem ter mesmo número de elementos
        disp('Erro! Dimensões de X e Y não são equivalentes.');
        Ylag = 'erro';
        return;
    end

    syms a;%variável simbólica usada no cálculo do polinômio interpolador
    soma = 0; % variável que guarda o resultado do produtório '(Li)*f(xi)'

    for i = 1:length(x) %laço que soma os produtórios
        produto = 1; %variável que soma os produtórios '(Li)*f(xi)'
        for j = 1:length(x) %laço que realiza o produtório
            if i~=j %se i=j, x(i) não entra no denominador do produtório
                produto = produto*((a - x(j))/(x(i) - x(j))); %produtório
            end
        end
        produto = produto * y(i); % multiplicação pela 'imagem' da função 
        soma = soma + produto; % somatório dos produtos         
    end
    %soma agora é simbólica e contém o polinômio interpolador
    format long;
    
    disp('Coeficientes do polinômio interpolador:');
    c = sym2poly(soma);
    disp(c'); %imprime coeficientes
    
    %imprimindo polinômio interpolador com variável simbólica
    poli = 0;
    j = 0;
    for i = length(c):-1:1
        poli = poli + c(i)*a^(j);
        j = j + 1;
    end
    disp('Polinômio interpolador:');
    pretty(poli);

    Ylag = sym2poly(subs(soma,a,Xlag)); %interpolação
    
    %plotando gráfico
    poli = inline(poli);
    plot(x,y,'o'), grid on, hold on;
    x1 = x(1):0.01:x(length(x));
    y1 = poli(x1);
    plot(x1,y1), hold off;
end