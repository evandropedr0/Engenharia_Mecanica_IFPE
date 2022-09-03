function Yint = PoliNewtonGregory(x,y,Xint)
%Função que realiza interpolação pelo método de Newton-Gregory
%Parâmetros: Yint = PoliNewton (x,y,Xint) 
% x e y são os pontos que pertencem ao conjuto de dados
% Xint é o ponto a ser interpolado
% Yint é a saída: valor interpolado

    %validação
    if isnumeric(x)==false||isnumeric(y)==false|| ...
            isnumeric(Xint)==false %um dos parâmetros não é numérico
        disp('Erro. Todos os parâmetros devem ser numéricos.');
        Yint = 'erro';
        return;
    end
    if(((size(x,1)>1)&&(size(x,2)>1))||((size(y,1)>1)&&(size(y,2)>1)))
        disp('Erro! X ou Y não é um vetor.');
        Yint = 'erro';
        return;
    elseif(length(x)~=length(y))%x e y devem ter mesmo número de elementos
        disp('Erro! Dimensões de X e Y não são equivalentes.');
        Yint = 'erro';
        return;
    end
    if length(x)>2
        anterior = abs(x(2)-x(1));
        for i = 2:length(x)-1
            atual = abs(x(i+1)-x(i));
            if atual~=anterior
                disp('Erro! Vetor x deve ser igualmente espaçado.');
                Yint = 'erro';
                return;
            end
        end
    end
    syms a;%variável simbólica usada no cálculo do polinômio interpolador
    diford = zeros(length(y));%matriz que armazena as diferenças ordinárias
    diford(:,1) = y; %1ª coluna da matriz é o próprio vetor y
    for j = 2:length(y) %colunas
        for i = 1:(length(y)+1-j) %linhas
            diford(i,j) = diford(i+1,j-1)-diford(i,j-1);
        end
    end

    soma = diford(1,1); %polinômio interpolador com valor inicial
    %#ok<*NASGU>
    produtorio = 1; %variável que guarda os produtórios
    h = x(2)-x(1); %tamanho do espaçamento
    for i = 2:length(x) %laço que constrói o polinômio interpolador
        produtorio = produtorio * (a - x(i-1));
        soma = soma + (diford(1,i)/(factorial(i-1)*h^(i-1)))*produtorio;
    end
    %soma agora é simbólica e contém o polinômio interpolador
    format long;
    
    disp('Coeficientes do polinômio interpolador');
    %disp('(do menor ao maior grau):');
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
    
    disp('Diferenças ordinárias:');
    disp(diford);
    
    Yint = sym2poly(subs(soma,a,Xint)); %interpolação
    
    %plotando gráfico
    poli = inline(poli);
    plot(x,y,'o'), grid on, hold on;
    x1 = x(1):0.01:x(length(x));
    y1 = poli(x1);
    plot(x1,y1), hold off;
end