function [ raiz ] = bissecao(f,x1,x2,tol,imax)
%A função bissecao calcula a raíz de uma função qualquer de uma variável
%dentro de um intervalo fornecido utilizando o método da Bisseção.
%Parâmetros:
%f: nome da função ou vetor de caracteres com a expressão da função.
%x1: extremidade inferior do intervalo.
%x2: extremidade superior do intervalo.
%tol: tolerância.
%imax: número máximo de iterações.
%raiz: variável de saída.
    
    %validação de parâmetros
    if ischar(f)==true %f é um vetor de caracteres
        f = str2func(strcat('@(x)',f));%transforma em function_handle
    elseif isa(f,'function_handle')==false&& ... 
            isa(f,'inline')==false%f não é do tipo function_handle ou inline
        disp('Tipo de variável inválido para o parâmetro função (f).');
        return;
    end
    if isnumeric(x1)==false %x1 não é um tipo numérico
        disp('Erro. O parâmetro x1 deve ser numérico.');
        return;
    end
    if isnumeric(x2)==false %x2 não é um tipo numérico
        disp('Erro. O parâmetro x2 deve ser numérico.');
        return;
    end
    if isnumeric(tol)==false %tolerância não é um tipo numérico
        disp('Erro. O parâmetro tol deve ser numérico.');
        return;
    end
    if isnumeric(imax)==false %imax não é um tipo numérico
        disp('Erro. O parâmetro imax deve ser numérico.');
        return;
    end
    if x1>x2 % x1 deve ser menor que x2
        disp('Erro. x1 deve ser menor que x2.');
        return;
    elseif x1==x2
        disp('Erro. x1 e x2 devem ser diferentes.');
        return;
    end
    if f(x1)*f(x2)>0 %deve ser menor que zero
        disp('Erro. Não há raíz entre x1 e x2.');
        return;
    end
    
    %após verificadas todas as situações problema, prosseguimos com o
    %método da bisseção
    
    %processamento
    format longe;%formato longo com notação exponencial
    fprintf('iteração\t\tx1\t\t\tx2\t\t  Solução(Xi)\t\tf(Xi)\t\ttolerância\n');
    for i=1:imax
       Xi = (x1 + x2)/2;%solução da iteração atual
       Ti = (x2 - x1)/2;%tolerância da iteração atual
       Fi = f(Xi);%imagem da função em Xi na iteração atual
       %exibição de resultados da iteração
       fprintf('%4d\t\t%.6f\t%.6f\t\t%.6f\t%.6f\t\t%.10f\n',i,x1,x2,Xi,Fi,Ti);
       if Fi==0 %raíz exata
          fprintf('Solução exata encontrada: %.6f',Xi);
          break; 
       end
       if Ti<tol %critério da tolerância foi atingido
           break;
       end
       
       if f(x1)*f(Xi)<0 %a raíz está entre x1 e Xi
           x2 = Xi;%atualiza extremidade superior
       else %a raíz está entre Xi e x2
           x1 = Xi;%atualiza extremidade inferior
       end
    end
    if i==imax %núemro máximo de iterações atingido
        disp('Função finalizada, pois o número máximo de iterações foi atingido.');
    end
    raiz = Xi;%atualiza variável de saída
    fprintf('\nNúmero total de iterações: %d\n',i);
end

