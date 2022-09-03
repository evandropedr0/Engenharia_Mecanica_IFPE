function [ raiz ] = secante(f,x1,x2,tol,imax)
%A função secante calcula a raíz de uma função qualquer de uma
%variável em torno de um valor de estimativa dado utilizando o método de
%Newton-Raphson.
%Parâmetros:
%f: nome da função ou vetor de caracteres com a expressão da função.
%x1 e x2: pontos na vizinhança da solução
%tol: tolerância
%imax: número máximo de iterações.
%raíz: variável de saída.
    
    %validação de parâmetros
    if ischar(f)==true %função é um vetor de caracteres
        f = str2func(strcat('@(x)',f));%transforma em function_handle
    elseif isa(f,'function_handle')==false&& ... 
            isa(f,'inline')==false%f não é do tipo function_handle ou inline
        disp('Tipo de variável inválido para o parâmetro funcao (f).');
        return;
    end
    if isnumeric(x1)==false %x1 não é um tipo numérico
        disp('Tipo de variável inválido para o parâmetro x1.');
        return;
    end
    if isnumeric(x2)==false %x2 não é um tipo numérico
        disp('Tipo de variável inválido para o parâmetro x2.');
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
    fprintf('iteração\t\tx1\t\t\tx2\t\t  Solução(x3)\t\tf(x3)\t\ttolerância\n');
    for i=1:imax
        %cálculo da estimativa atual
        x3 = x2 - ((f(x2)*(x1-x2))/(f(x1)-f(x2)));
        Ti = abs((x3 - x2)/x2);
        fprintf('%4d\t\t%.6f\t%.6f\t\t%.6f\t%.10f\t%.10f\n',i,x1,x2,x3,f(x3),Ti);
        %quando o erro relativo da estimativa atual com a anterior é menor
        %que a tolerância, temos o resultado da raíz.
        if Ti<tol
            raiz = x3; %valor é atribuído à variável de saída
            break; %finaliza laço de repetição
        end
        erro = [erro log(Ti)]; 
        iteracoes = [iteracoes i];
        %atualização das estimativas
        x1 = x2;
        x2 = x3;
    end
    erro = [erro log(Ti)]; 
    iteracoes = [iteracoes i];
    if i==imax %núemro máximo de iterações atingido
        disp('Função finalizada, pois o número máximo de iterações foi atingido.');
        raiz = x3;
    end
    fprintf('\nNúmero total de iterações: %d\n',i);
    plot(iteracoes,erro); grid on;
    xlabel('Iterações');
    ylabel('ln(erro)');
end

