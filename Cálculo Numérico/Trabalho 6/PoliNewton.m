function Ylag = PoliNewton(x,y,Xlag)
%Função que realiza interpolação pelo método de Newton
%Parâmetros: Ylag = PoliNewton (x,y,Xlag) 
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
    difdiv = zeros(length(y)); %matriz que armazena as diferenças divididas
    difdiv(:,1) = y; %1ª coluna da matriz é o próprio vetor y
    aux = 1; %variável auxiliar
    for j = 2:length(y) %colunas
        for i = 1:(length(y)+1-j) %linhas
            difdiv(i,j) = (difdiv(i,j-1)-difdiv(i+1,j-1))/(x(i)-x(i+aux));
        end
        aux = aux + 1;
    end

    soma = difdiv(1,1); %polinômio interpolador com valor inicial
    %#ok<*NASGU>
    produtorio = 1; %variável que guarda os produtórios
    for i = 2:length(x) %laço que constrói o polinômio interpolador
        produtorio = produtorio * (a - x(i-1));
        soma = soma + difdiv(1,i)*produtorio;
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
    
    disp('Diferenças divididas:');
    disp(difdiv);
    
    Ylag = sym2poly(subs(soma,a,Xlag)); %interpolação
    
    %plotando gráfico
    poli = inline(poli);
    plot(x,y,'o'), grid on, hold on;
    x1 = x(1):0.01:x(length(x));
    y1 = poli(x1);
    plot(x1,y1), hold off;
end