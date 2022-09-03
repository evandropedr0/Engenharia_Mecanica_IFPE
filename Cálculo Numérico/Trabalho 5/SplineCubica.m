function [ Yint ] = SplineCubica(x,y,Xint)
%SplineCubica calcula a interpola��o usando splines c�bicas.
%Par�metros: [ Yint ] = SplineCubica(x,y,Xint)
%x: Vetor com as coordenadas x dos pontos dados.
%y: Vetor com as coordenadas y dos pontos dados.
%Xint: Coordenada x do ponto a ser interpolado.
%Yint: O valor interpolado de Xint.

    %%%%%VALIDA��O%%%%%
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
    
    %%%%%PROCESSAMENTO%%%%%
    n = length(x); %n�mero de pontos
    ns = n-1; %n�mero de splines
    h = zeros(1,ns); %vetor de tamanhos de intervalos
    for i = 1:ns
        h(i) = x(i+1)-x(i);%calculando tamanhos de intervalos
    end
    %MONTAGEM DO SISTEMA LINEAR PARA ENCONTRAR COEFICIENTES
    %Como a spline c�bica � natural, a(1)=a(n)=0
    b = zeros(n-2,1); %declarando vetor coluna inicialmente nulo
    for i = 1:n-2 %montando vetor resposta do sistema linear
        b(i) = 6*(((y(i+2)-y(i+1))/h(i+1))-((y(i+1)-y(i))/h(i)));
    end
    A = zeros(n-2); %declara��o da matriz dos coeficientes (nula)
    j = 1; %vari�vel auxiliar para colunas
    for i = 1:n-2 %calculando elementos da matriz A
        if i == 1 %primeira linha
            A(i,j) = 2*(h(i)+h(i+1)); %coeficiente de a(2)
            A(i,j+1) = h(i+1); %coeficiente de a(3)
        elseif i == n-2 %�ltima linha
            A(i,j) = h(i); %coeficiente de a(n-3)
            A(i,j+1) = 2*(h(i)+h(i+1)); %coeficiente de a(n-2)
        else %linhas do meio
            A(i,j) = h(i); %coeficiente de a(i)
            A(i,j+1) = 2*(h(i)+h(i+1)); %coeficiente de a(i+1)
            A(i,j+2) = h(i+1); %coeficiente de a(i+2)
            j = j + 1; %incremento de j
        end
    end
    %SOLU��O DO SISTEMA LINEAR
    format long;
    a = A\b;%vetor a cont�m os coeficientes de a(2) at� a(n-1)
    a = [0;a;0];%adicionando os demais coeficientes
    
    %%%%%SA�DA%%%%%
    disp('Coeficientes das splines c�bicas naturais:');
    disp(a);
    %encontrando o intervalo de interpola��o
    for k = 2:n %k cont�m o ponto final do intervalo de interpola��o
        if (Xint<x(k))
            break;
        end
    end
    i = k-1; %i � o ponto inicial do intervalo de interpola��o
    %criando spline
    syms X;
    spline = (a(i)/(6*h(i)))*((x(i+1)-X)^3);%1� parte
    spline = spline + (a(i+1)/(6*h(i)))*((X-x(i))^3);%2� parte
    spline = spline + ((y(i)/h(i))-((a(i)*h(i))/6))*(x(i+1)-X);%3� parte
    spline = spline + ((y(i+1)/h(i))-((a(i+1)*h(i))/6))*(X-x(i));%4� parte
    disp('Spline interpoladora:');
    pretty(spline);%imprimindo spline interpoladora
    %transformando spline em uma fun��o do tipo inline
    spline = inline(spline);
    %avaliando a spline no ponto Xint
    Yint = spline(Xint); %INTERPOLA��O
    
    %plotando gr�fico
    plot(x,y,'o'), grid on, hold on;%plotando dados
    x1 = x(i):0.005:x(k);%intervalo em x
    y1 = spline(x1);%c�lculo das imagens no intervalo
    plot(x1,y1), hold off;%plotando spline
end

