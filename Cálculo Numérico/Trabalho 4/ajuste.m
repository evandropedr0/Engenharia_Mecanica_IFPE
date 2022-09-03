function [ c,erro ] = ajuste(x,y,n)
%Esta fun��o realiza o ajuste de curvas de uma fun��o usando uma tabela de
%pontos como refer�ncia.
%Par�metros:
%x = vetor de pontos
%y = vetor de imagens (f(x))
%n = modo de ajuste: 1 - linear, 2 - quadr�tico, 3 - c�bico, etc.
%Obs: n deve ser menor que o n�mero de elementos em x e maior que zero.

    %valida��o
    if(((size(x,1)>1)&&(size(x,2)>1))||((size(y,1)>1)&&(size(y,2)>1)))
        disp('Erro! X ou Y n�o � um vetor.');
        c = 'erro';
        erro = 'erro';
        return;
    elseif(length(x)~=length(y))%x e y devem ter mesmo n�mero de elementos
        fprintf('Dimens�es de X e Y n�o s�o equivalentes.');
        c = 'erro';
        erro = 'erro';
        return;
    end
    if n<1||n>=length(x)
        fprintf('N deve ser menor que X ou maior que 0');
        c = 'erro';
        erro = 'erro';
        return;
    end
    %#ok<*AGROW>
    %processamento
    %criando vetores phi
    phi = ones(1,length(x));%primeiro vetor: phi_0
    for i=1:n
        phi = [phi; x.^i];
    end
    %montando matriz dos coeficientes
    A = [];
    for i=1:n+1
        for j=1:n+1
            A(i,j) = prod_int(phi(i,:),phi(j,:));
        end
    end
    %montando vetor resposta
    b = [];
    for i=1:n+1
        b = [b; prod_int(y,phi(i,:))];
    end
    %resolvendo sistema linear
    c = eliminacao_gauss(A,b);
    
    %plotagem
    g = zeros(1,length(x));
    for i=1:n+1
        g = g + c(i)*phi(i,:);
    end
    plot(x,y,'bo'), grid on, hold on;
    plot(x,g,'r-')
    
    %c�lculo do erro
    erro = 0;
    for i=1:length(x)
        erro = erro + (y(i)-g(i))^2;
    end
end