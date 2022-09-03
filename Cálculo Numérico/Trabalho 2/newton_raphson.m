function [ raiz ] = newton_raphson(f, dfdx, Xe, tol, imax)
%A fun��o newton_raphson calcula a ra�z de uma fun��o qualquer de uma
%vari�vel em torno de um valor de estimativa dado utilizando o m�todo de
%Newton-Raphson.
%Par�metros:
%f: nome da fun��o ou vetor de caracteres com a express�o da fun��o.
%dfdx: nome da fun��o derivada ou vetor de caracteres com a express�o
%anal�tica da derivada.
%Xe: estimativa inicial para a ra�z.
%tol: toler�ncia
%imax: n�mero m�ximo de itera��es.
%ra�z: vari�vel de sa�da.

    %valida��o de par�metros
    if ischar(f)==true %fun��o � um vetor de caracteres
        f = str2func(strcat('@(x)',f));%transforma em function_handle
    elseif isa(f,'function_handle')==false&& ... 
            isa(f,'inline')==false%f n�o � do tipo function_handle ou inline
        disp('Tipo de vari�vel inv�lido para o par�metro funcao.');
        return;
    end
    if ischar(dfdx)==true%derivada � um vetor de caracteres
        dfdx = str2func(strcat('@(x)',dfdx));%transforma em function_handle
    elseif isa(dfdx,'function_handle')==false&& ... 
            isa(dfdx,'inline')==false%dfdx n�o � do tipo function_handle ou inline
        disp('Tipo de vari�vel inv�lido para o par�metro derivada.');
        return;
    end
    if isnumeric(Xe)==false %estimativa n�o � um tipo num�rico
        disp('Tipo de vari�vel inv�lido para o par�metro Xe.');
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
    fprintf('itera��o\t\tXe\t\t Solu��o(Xi)\t\tf(Xi)\t\ttoler�ncia\n');
    for i=1:imax
        %c�lculo da estimativa atual
        Xi = Xe - f(Xe)/dfdx(Xe);
        Ti = abs((Xi - Xe)/Xe);
        fprintf('%4d\t\t%.6f\t\t%.6f\t%.10f\t%.10f \n',i,Xe,Xi,f(Xi),Ti);
        %quando o erro relativo da estimativa atual com a anterior � menor
        %que a toler�ncia, temos o resultado da ra�z.
        if Ti<tol
            raiz = Xi; %valor � atribu�do � vari�vel de sa�da
            break; %finaliza la�o de repeti��o
        end
        erro = [erro log(Ti)]; 
        iteracoes = [iteracoes i];
        Xe = Xi; %atualiza o valor da estimativa anterior
    end
    erro = [erro log(Ti)]; 
    iteracoes = [iteracoes i];
    if i==imax %n�emro m�ximo de itera��es atingido
        disp('Fun��o finalizada, pois o n�mero m�ximo de itera��es foi atingido.');
        raiz = Xi;
    end
    fprintf('\nN�mero total de itera��es: %d\n',i);
    plot(iteracoes,erro); grid on;
    xlabel('Itera��es');
    ylabel('ln(erro)');
end

