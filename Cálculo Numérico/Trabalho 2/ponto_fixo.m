function [ raiz ] = ponto_fixo(f,g,Xe,tol,imax)
%A fun��o ponto_fixo calcula a ra�z de uma fun��o qualquer de uma
%vari�vel em torno de um valor de estimativa dado utilizando o m�todo do
%Ponto Fixo.
%Par�metros:
%f: nome da fun��o ou vetor de caracteres com a express�o da fun��o
%principal.
%g: nome da fun��o ou vetor de caracteres com a express�o da fun��o de
%itera��o.
%Xe: estimativa inicial para a ra�z.
%tol: toler�ncia
%imax: n�mero m�ximo de itera��es.
%ra�z: vari�vel de sa�da.

    %valida��o de par�metros
    if ischar(f)==true %fun��o � um vetor de caracteres
        f = str2func(strcat('@(x)',f));%transforma em function_handle
    elseif isa(f,'function_handle')==false&& ... 
            isa(f,'inline')==false%f n�o � do tipo function_handle ou inline
        disp('Tipo de vari�vel inv�lido para o par�metro fun��o.');
        return;
    end
    if ischar(g)==true %fun��o � um vetor de caracteres
        g = str2func(strcat('@(x)',f));%transforma em function_handle
    elseif isa(g,'function_handle')==false&& ... 
            isa(g,'inline')==false%f n�o � do tipo function_handle ou inline
        disp('Tipo de vari�vel inv�lido para o par�metro fun��o de itera��o.');
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
    
    %processamento
    format longe;%formato longo com nota��o exponencial
    fprintf('itera��o\t\tXe\t\t Solu��o(Xi)\t\tf(Xi)\t\ttoler�ncia\n');
    for i=1:imax
        %c�lculo da estimativa atual
        Xi = g(Xe); %Xi � a imagem de f no ponto Xe
        Ti = abs((Xi - Xe)/Xe);
        fprintf('%4d\t\t%.6f\t\t%.6f\t%.10f\t%.10f \n',i,Xe,Xi,f(Xi),Ti);
        %quando o erro relativo da estimativa atual com a anterior � menor
        %que a toler�ncia, temos o resultado da ra�z.
        if Ti<tol
            raiz = Xi; %valor � atribu�do � vari�vel de sa�da
            break; %finaliza la�o de repeti��o
        end
        
        Xe = Xi; %atualiza o valor da estimativa anterior
    end
    if i==imax %n�emro m�ximo de itera��es atingido
        disp('Fun��o finalizada, pois o n�mero m�ximo de itera��es foi atingido.');
        raiz = Xi;
    end
    fprintf('\nN�mero total de itera��es: %d\n',i);
end

