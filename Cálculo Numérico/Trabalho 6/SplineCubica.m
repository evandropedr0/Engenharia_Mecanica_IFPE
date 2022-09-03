function [ ] = SplineCubica(x,y)
%SplineCubica calcula a interpolação usando splines cúbicas.
%Parâmetros: [ Yint ] = SplineCubica(x,y,Xint)
%x: Vetor com as coordenadas x dos pontos dados.
%y: Vetor com as coordenadas y dos pontos dados.
%Xint: Coordenada x do ponto a ser interpolado.
%Yint: O valor interpolado de Xint.

    %%%%%VALIDAÇÃO%%%%%
    if isnumeric(x)==false||isnumeric(y)==false%|| ...
            %isnumeric(Xint)==false %um dos parâmetros não é numérico
        disp('Erro. Todos os parâmetros devem ser numéricos.');
        %Yint = 'erro';
        return;
    end
    if(((size(x,1)>1)&&(size(x,2)>1))||((size(y,1)>1)&&(size(y,2)>1)))
        disp('Erro! X ou Y não é um vetor.');
        %Yint = 'erro';
        return;
    elseif(length(x)~=length(y))%x e y devem ter mesmo número de elementos
        disp('Erro! Dimensões de X e Y não são equivalentes.');
        %Yint = 'erro';
        return;
    end
    
    %%%%%PROCESSAMENTO%%%%%
    n = length(x); %número de pontos
    ns = n-1; %número de splines
    h = zeros(1,ns); %vetor de tamanhos de intervalos
    for i = 1:ns
        h(i) = x(i+1)-x(i);%calculando tamanhos de intervalos
    end
    %MONTAGEM DO SISTEMA LINEAR PARA ENCONTRAR COEFICIENTES
    %Como a spline cúbica é natural, a(1)=a(n)=0
    b = zeros(n-2,1); %declarando vetor coluna inicialmente nulo
    for i = 1:n-2 %montando vetor resposta do sistema linear
        b(i) = 6*(((y(i+2)-y(i+1))/h(i+1))-((y(i+1)-y(i))/h(i)));
    end
    A = zeros(n-2); %declaração da matriz dos coeficientes (nula)
    j = 1; %variável auxiliar para colunas
    for i = 1:n-2 %calculando elementos da matriz A
        if i == 1 %primeira linha
            A(i,j) = 2*(h(i)+h(i+1)); %coeficiente de a(2)
            A(i,j+1) = h(i+1); %coeficiente de a(3)
        elseif i == n-2 %última linha
            A(i,j) = h(i); %coeficiente de a(n-3)
            A(i,j+1) = 2*(h(i)+h(i+1)); %coeficiente de a(n-2)
        else %linhas do meio
            A(i,j) = h(i); %coeficiente de a(i)
            A(i,j+1) = 2*(h(i)+h(i+1)); %coeficiente de a(i+1)
            A(i,j+2) = h(i+1); %coeficiente de a(i+2)
            j = j + 1; %incremento de j
        end
    end
    %SOLUÇÃO DO SISTEMA LINEAR
    format long;
    a = A\b;%vetor a contém os coeficientes de a(2) até a(n-1)
    a = [0;a;0];%adicionando os demais coeficientes
    
    %%%%%SAÍDA%%%%%
%     disp('Coeficientes das splines cúbicas naturais:');
%     disp(a);
%     %encontrando o intervalo de interpolação
%     for k = 2:n %k contém o ponto final do intervalo de interpolação
%         if (Xint<x(k))
%             break;
%         end
%     end
%     i = k-1; %i é o ponto inicial do intervalo de interpolação
%     %criando spline
%     spline = montarspline3(x,y,i,a,h);
%     disp('Spline interpoladora:');
%     pretty(spline);%imprimindo spline interpoladora
%     %transformando spline em uma função do tipo inline
%     spline = inline(spline);
%     %avaliando a spline no ponto Xint
%     Yint = spline(Xint); %INTERPOLAÇÃO
    
    %plotando gráfico
    plot(x,y,'*'), grid on, hold on;%plotando dados
    for i = 1:n-1 %i contém o ponto inicial do intervalo de interpolação
        spline = montarspline3(x,y,i,a,h);%montando spline
        spline = inline(spline);%transformando em função inline
        x1 = x(i):0.005:x(i+1);%intervalo em x
        y1 = spline(x1);%cálculo das imagens no intervalo
        plot(x1,y1,'r');%plotando spline
    end
    hold off;
end

