function [ raiz ] = secante(f,x1,x2,tol,imax)
%A fun��o secante calcula a ra�z de uma fun��o qualquer de uma
%vari�vel em torno de um valor de estimativa dado utilizando o m�todo de
%Newton-Raphson.
%Par�metros:
%f: nome da fun��o ou vetor de caracteres com a express�o da fun��o.
%x1 e x2: pontos na vizinhan�a da solu��o
%tol: toler�ncia
%imax: n�mero m�ximo de itera��es.
%ra�z: vari�vel de sa�da.
    
    %valida��o de par�metros
    if ischar(f)==true %fun��o � um vetor de caracteres
        f = str2func(strcat('@(x)',f));%transforma em function_handle
    elseif isa(f,'function_handle')==false&& ... 
            isa(f,'inline')==false%f n�o � do tipo function_handle ou inline
        disp('Tipo de vari�vel inv�lido para o par�metro funcao (f).');
        return;
    end
    if isnumeric(x1)==false %x1 n�o � um tipo num�rico
        disp('Tipo de vari�vel inv�lido para o par�metro x1.');
        return;
    end
    if isnumeric(x2)==false %x2 n�o � um tipo num�rico
        disp('Tipo de vari�vel inv�lido para o par�metro x2.');
        return;
    end
    if isnumeric(tol)==false %toler�ncia n�o � um tipo num�rico
        disp('Tipo de vari�vel inv�lido para o par�metro tol.');
        return;
    end
    if isnumeric(imax)==false %imax n�o � um tipo num�rico
        disp('Erro. O par�metro imax deve ser num�rico.');
        return;
    end
    
    erro = [];
    iteracoes = [];
    %processamento
    format longe;%formato longo com nota��o exponencial
    fprintf('itera��o\t\tx1\t\t\tx2\t\t  Solu��o(x3)\t\tf(x3)\t\ttoler�ncia\n');
    for i=1:imax
        %c�lculo da estimativa atual
        x3 = x2 - ((f(x2)*(x1-x2))/(f(x1)-f(x2)));
        Ti = abs((x3 - x2)/x2);
        fprintf('%4d\t\t%.6f\t%.6f\t\t%.6f\t%.10f\t%.10f\n',i,x1,x2,x3,f(x3),Ti);
        %quando o erro relativo da estimativa atual com a anterior � menor
        %que a toler�ncia, temos o resultado da ra�z.
        if Ti<tol
            raiz = x3; %valor � atribu�do � vari�vel de sa�da
            break; %finaliza la�o de repeti��o
        end
        erro = [erro log(Ti)]; 
        iteracoes = [iteracoes i];
        %atualiza��o das estimativas
        x1 = x2;
        x2 = x3;
    end
    erro = [erro log(Ti)]; 
    iteracoes = [iteracoes i];
    if i==imax %n�emro m�ximo de itera��es atingido
        disp('Fun��o finalizada, pois o n�mero m�ximo de itera��es foi atingido.');
        raiz = x3;
    end
    fprintf('\nN�mero total de itera��es: %d\n',i);
    plot(iteracoes,erro); grid on;
    xlabel('Itera��es');
    ylabel('ln(erro)');
end

