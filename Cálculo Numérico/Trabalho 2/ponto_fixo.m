function [ raiz ] = ponto_fixo(f,g,Xe,tol,imax)
%A função ponto_fixo calcula a raíz de uma função qualquer de uma
%variável em torno de um valor de estimativa dado utilizando o método do
%Ponto Fixo.
%Parâmetros:
%f: nome da função ou vetor de caracteres com a expressão da função
%principal.
%g: nome da função ou vetor de caracteres com a expressão da função de
%iteração.
%Xe: estimativa inicial para a raíz.
%tol: tolerância
%imax: número máximo de iterações.
%raíz: variável de saída.

    %validação de parâmetros
    if ischar(f)==true %função é um vetor de caracteres
        f = str2func(strcat('@(x)',f));%transforma em function_handle
    elseif isa(f,'function_handle')==false&& ... 
            isa(f,'inline')==false%f não é do tipo function_handle ou inline
        disp('Tipo de variável inválido para o parâmetro função.');
        return;
    end
    if ischar(g)==true %função é um vetor de caracteres
        g = str2func(strcat('@(x)',f));%transforma em function_handle
    elseif isa(g,'function_handle')==false&& ... 
            isa(g,'inline')==false%f não é do tipo function_handle ou inline
        disp('Tipo de variável inválido para o parâmetro função de iteração.');
        return;
    end
    if isnumeric(Xe)==false %estimativa não é um tipo numérico
        disp('Tipo de variável inválido para o parâmetro Xe.');
        return;
    end
    if isnumeric(tol)==false %tolerância não é um tipo numérico
        disp('Tipo de variável inválido para o parâmetro tol.');
        return;
    end
    if isnumeric(imax)==false %imax não é um tipo numérico
        disp('Erro. O parâmetro imax deve ser numérico.');
        return;
    end
    
    %processamento
    format longe;%formato longo com notação exponencial
    fprintf('iteração\t\tXe\t\t Solução(Xi)\t\tf(Xi)\t\ttolerância\n');
    for i=1:imax
        %cálculo da estimativa atual
        Xi = g(Xe); %Xi é a imagem de f no ponto Xe
        Ti = abs((Xi - Xe)/Xe);
        fprintf('%4d\t\t%.6f\t\t%.6f\t%.10f\t%.10f \n',i,Xe,Xi,f(Xi),Ti);
        %quando o erro relativo da estimativa atual com a anterior é menor
        %que a tolerância, temos o resultado da raíz.
        if Ti<tol
            raiz = Xi; %valor é atribuído à variável de saída
            break; %finaliza laço de repetição
        end
        
        Xe = Xi; %atualiza o valor da estimativa anterior
    end
    if i==imax %núemro máximo de iterações atingido
        disp('Função finalizada, pois o número máximo de iterações foi atingido.');
        raiz = Xi;
    end
    fprintf('\nNúmero total de iterações: %d\n',i);
end

