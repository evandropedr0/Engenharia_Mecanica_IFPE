function [ raiz ] = newton_raphson(f, dfdx, Xe, tol, imax)
%A função newton_raphson calcula a raíz de uma função qualquer de uma
%variável em torno de um valor de estimativa dado utilizando o método de
%Newton-Raphson.
%Parâmetros:
%f: nome da função ou vetor de caracteres com a expressão da função.
%dfdx: nome da função derivada ou vetor de caracteres com a expressão
%analítica da derivada.
%Xe: estimativa inicial para a raíz.
%tol: tolerância
%imax: número máximo de iterações.
%raíz: variável de saída.

    %validação de parâmetros
    if ischar(f)==true %função é um vetor de caracteres
        f = str2func(strcat('@(x)',f));%transforma em function_handle
    elseif isa(f,'function_handle')==false&& ... 
            isa(f,'inline')==false%f não é do tipo function_handle ou inline
        disp('Tipo de variável inválido para o parâmetro funcao.');
        return;
    end
    if ischar(dfdx)==true%derivada é um vetor de caracteres
        dfdx = str2func(strcat('@(x)',dfdx));%transforma em function_handle
    elseif isa(dfdx,'function_handle')==false&& ... 
            isa(dfdx,'inline')==false%dfdx não é do tipo function_handle ou inline
        disp('Tipo de variável inválido para o parâmetro derivada.');
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

    erro = [];
    iteracoes = [];
    %processamento
    format longe;%formato longo com notação exponencial
    fprintf('iteração\t\tXe\t\t Solução(Xi)\t\tf(Xi)\t\ttolerância\n');
    for i=1:imax
        %cálculo da estimativa atual
        Xi = Xe - f(Xe)/dfdx(Xe);
        Ti = abs((Xi - Xe)/Xe);
        fprintf('%4d\t\t%.6f\t\t%.6f\t%.10f\t%.10f \n',i,Xe,Xi,f(Xi),Ti);
        %quando o erro relativo da estimativa atual com a anterior é menor
        %que a tolerância, temos o resultado da raíz.
        if Ti<tol
            raiz = Xi; %valor é atribuído à variável de saída
            break; %finaliza laço de repetição
        end
        erro = [erro log(Ti)]; 
        iteracoes = [iteracoes i];
        Xe = Xi; %atualiza o valor da estimativa anterior
    end
    erro = [erro log(Ti)]; 
    iteracoes = [iteracoes i];
    if i==imax %núemro máximo de iterações atingido
        disp('Função finalizada, pois o número máximo de iterações foi atingido.');
        raiz = Xi;
    end
    fprintf('\nNúmero total de iterações: %d\n',i);
    plot(iteracoes,erro); grid on;
    xlabel('Iterações');
    ylabel('ln(erro)');
end

