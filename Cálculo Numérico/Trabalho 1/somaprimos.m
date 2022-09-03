function [ SP ] = somaprimos(num) %declaracao da fun��o conforme quest�o
%Esta fun��o soma os n�meros primos entre 100 e 500 que sejam menores que 'num'.
%Obs.: 'num' deve ser um n�mero maior que 100 e menor que 500
%Exemplo: somaprimos(110) -> ans = 420
    if((num<=100)||(num>=500)) %valida��o inicial
        disp('Argumento inv�lido! N�mero deve ser maior que 100 e menor que 500.');
        SP = 'Erro';
        return
    end
    %inicializa��o de vari�veis
    SP = 0;
    naoeprimo = 0;%0 = falso; 1 = verdadeiro.
    
    %aqui faremos o teste de numeros primos, ou seja, faremos divisoes
    %do n�mero por outros numeros menores que ele, exceto: 1, pois n�o 
    %se faz necess�rio, uma vez que todo n�mero � divisivel por 1; e o 
    %2, pois numeros divis�veis por 2 (pares) n�o s�o primos.
    for i=101:2:(num-1) %anda de 2 em 2 ate num-1 (para n�o incluir o pr�prio num)
        naoeprimo = 0; %restaura o valor do sinalizador.
        for j = 3:2:(i/2) %testa divis�o de i por 3 at� i/2
            if mod(i,j) == 0 %teste da divis�o inteira
                naoeprimo = 1; %sinaliza que i n�o � primo
            end
        end
        if naoeprimo == 0 %nesse caso, i e primo
            SP = SP + i; %acrescenta i na soma
        end
    end
end