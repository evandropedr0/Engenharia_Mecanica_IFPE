function [ raiz ] = bissecao(f,x1,x2,tol,imax)
%A fun��o bissecao calcula a ra�z de uma fun��o qualquer de uma vari�vel
%dentro de um intervalo fornecido utilizando o m�todo da Bisse��o.
%Par�metros:
%f: nome da fun��o ou vetor de caracteres com a express�o da fun��o.
%x1: extremidade inferior do intervalo.
%x2: extremidade superior do intervalo.
%tol: toler�ncia.
%imax: n�mero m�ximo de itera��es.
%raiz: vari�vel de sa�da.
    
    %valida��o de par�metros
    if ischar(f)==true %f � um vetor de caracteres
        f = str2func(strcat('@(x)',f));%transforma em function_handle
    elseif isa(f,'function_handle')==false&& ... 
            isa(f,'inline')==false%f n�o � do tipo function_handle ou inline
        disp('Tipo de vari�vel inv�lido para o par�metro fun��o (f).');
        return;
    end
    if isnumeric(x1)==false %x1 n�o � um tipo num�rico
        disp('Erro. O par�metro x1 deve ser num�rico.');
        return;
    end
    if isnumeric(x2)==false %x2 n�o � um tipo num�rico
        disp('Erro. O par�metro x2 deve ser num�rico.');
        return;
    end
    if isnumeric(tol)==false %toler�ncia n�o � um tipo num�rico
        disp('Erro. O par�metro tol deve ser num�rico.');
        return;
    end
    if isnumeric(imax)==false %imax n�o � um tipo num�rico
        disp('Erro. O par�metro imax deve ser num�rico.');
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
        disp('Erro. N�o h� ra�z entre x1 e x2.');
        return;
    end
    
    %ap�s verificadas todas as situa��es problema, prosseguimos com o
    %m�todo da bisse��o
    
    %processamento
    format longe;%formato longo com nota��o exponencial
    fprintf('itera��o\t\tx1\t\t\tx2\t\t  Solu��o(Xi)\t\tf(Xi)\t\ttoler�ncia\n');
    for i=1:imax
       Xi = (x1 + x2)/2;%solu��o da itera��o atual
       Ti = (x2 - x1)/2;%toler�ncia da itera��o atual
       Fi = f(Xi);%imagem da fun��o em Xi na itera��o atual
       %exibi��o de resultados da itera��o
       fprintf('%4d\t\t%.6f\t%.6f\t\t%.6f\t%.6f\t\t%.10f\n',i,x1,x2,Xi,Fi,Ti);
       if Fi==0 %ra�z exata
          fprintf('Solu��o exata encontrada: %.6f',Xi);
          break; 
       end
       if Ti<tol %crit�rio da toler�ncia foi atingido
           break;
       end
       
       if f(x1)*f(Xi)<0 %a ra�z est� entre x1 e Xi
           x2 = Xi;%atualiza extremidade superior
       else %a ra�z est� entre Xi e x2
           x1 = Xi;%atualiza extremidade inferior
       end
    end
    if i==imax %n�emro m�ximo de itera��es atingido
        disp('Fun��o finalizada, pois o n�mero m�ximo de itera��es foi atingido.');
    end
    raiz = Xi;%atualiza vari�vel de sa�da
    fprintf('\nN�mero total de itera��es: %d\n',i);
end

