function [ SP ] = somaprimos(num) %declaracao da função conforme questão
%Esta função soma os números primos entre 100 e 500 que sejam menores que 'num'.
%Obs.: 'num' deve ser um número maior que 100 e menor que 500
%Exemplo: somaprimos(110) -> ans = 420
    if((num<=100)||(num>=500)) %validação inicial
        disp('Argumento inválido! Número deve ser maior que 100 e menor que 500.');
        SP = 'Erro';
        return
    end
    %inicialização de variáveis
    SP = 0;
    naoeprimo = 0;%0 = falso; 1 = verdadeiro.
    
    %aqui faremos o teste de numeros primos, ou seja, faremos divisoes
    %do número por outros numeros menores que ele, exceto: 1, pois não 
    %se faz necessário, uma vez que todo número é divisivel por 1; e o 
    %2, pois numeros divisíveis por 2 (pares) não são primos.
    for i=101:2:(num-1) %anda de 2 em 2 ate num-1 (para não incluir o próprio num)
        naoeprimo = 0; %restaura o valor do sinalizador.
        for j = 3:2:(i/2) %testa divisão de i por 3 até i/2
            if mod(i,j) == 0 %teste da divisão inteira
                naoeprimo = 1; %sinaliza que i não é primo
            end
        end
        if naoeprimo == 0 %nesse caso, i e primo
            SP = SP + i; %acrescenta i na soma
        end
    end
end