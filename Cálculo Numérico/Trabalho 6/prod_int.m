function [produto] = prod_int(a,b)
%fun��o que calcula o produto interno de dois vetores 
%a,b - vetores passados como parâmetro
tamanho_a = size(a);
tamanho_b = size(b);

if(tamanho_a(1)>1)%trasnposi��o de matriz coluna para matriz linha
    a = a';
end
if(tamanho_b(1)>1)%trasnposi��o de matriz coluna para matriz linha
    b = b';
end
%valida��o: checar se entradas s�o vetores
if(((tamanho_a(1)>1)&&(tamanho_a(2)>1))||((tamanho_b(1)>1)&&(tamanho_b(2)>1)))
    disp('Erro! Ao menos um dos par�metros n�o � um vetor.');
    produto = 'erro';
elseif(length(a) ~= length(b))%valida��o: vetores devem ter mesmo n�mero de elementos
    fprintf('Dimens�es n�o s�o equivalentes.\nN�o � poss�vel realizar o produto interno.\n\n');
    produto = 'erro';
else %passou por todas as valida��es
    % Inicializa��o da vari�vel usada para guardar os resultados de cada
    % opera��o no produto interno entre a e b
    produto = 0;
    
    for i=1:1:length(a) % vai at� o fim da dimens�o do vetor de a.
        produto = produto + (a(i)*b(i));
    end
end
end