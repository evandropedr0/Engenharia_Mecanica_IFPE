function [produto] = prod_int(a,b)
%função que calcula o produto interno de dois vetores 
%a,b - vetores passados como parÃ¢metro
tamanho_a = size(a);
tamanho_b = size(b);

if(tamanho_a(1)>1)%trasnposição de matriz coluna para matriz linha
    a = a';
end
if(tamanho_b(1)>1)%trasnposição de matriz coluna para matriz linha
    b = b';
end
%validação: checar se entradas são vetores
if(((tamanho_a(1)>1)&&(tamanho_a(2)>1))||((tamanho_b(1)>1)&&(tamanho_b(2)>1)))
    disp('Erro! Ao menos um dos parâmetros não é um vetor.');
    produto = 'erro';
elseif(length(a) ~= length(b))%validação: vetores devem ter mesmo número de elementos
    fprintf('Dimensões não são equivalentes.\nNão é possível realizar o produto interno.\n\n');
    produto = 'erro';
else %passou por todas as validações
    % Inicialização da variável usada para guardar os resultados de cada
    % operação no produto interno entre a e b
    produto = 0;
    
    for i=1:1:length(a) % vai até o fim da dimensão do vetor de a.
        produto = produto + (a(i)*b(i));
    end
end
end