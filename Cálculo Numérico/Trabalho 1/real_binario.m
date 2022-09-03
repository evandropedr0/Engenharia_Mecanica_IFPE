function Bi = real_binario(num)
%Transforma um n�mero real positivo em um binario.
%Exemplo:
%real_binario(10)
%ans = 1 0 1 0
%Obs.: o argumento dessa fun��o deve estar entre 0 e 999999.99

    if(num<0||num>999999.99)%valida��o inicial para intervalo
        disp('Valor inv�lido! O argumento deve estar entre 0 e 999999.99');
        return
    elseif (num == 0)||(num==1)
        Bi = num;
    else
        %convers�o da parte inteira de 'num'
        int = fix(num); %atribui a parte inteira de 'num' a 'int'
        frac = num - int;%atribui a parte fracion�ria de 'num' a 'frac'
        Bi = [];%inicializa��o da vari�vel de sa�da
    
        while (fix(int/2)>=1)%condi��o de parada: valor inteiro do quociente < 1
            %i recebe o resto da divis�o inteira de int por 2, que s� pode
            %assumir 2 valores diferentes, 0 ou 1, ou seja, i � um bit.
            i = mod(int,2);
            
            %o i da itera��o atual � inserido no in�cio do vetor Bi
            Bi = [i Bi];
            
            %atualiza��o do valor de int
            int = fix(int/2);
        end
        Bi = [int Bi];%insere o �ltimo quociente, que � o bit mais significativo.
        
        %convers�o da parte fracion�ria
        %crit�rio de parada: ao menos dez itera��es e at� encontrar o
        %primeiro bit 1, salvo quando a parte fracion�ria for completamente
        %convertida antes desse crit�rio.
        if frac > 0 %testa se h� parte fracion�ria a ser convertida
           tamanho_inteiro = size(Bi);%tamanho do vetor somente com a parte inteira
           tamanho_total = 0;
           %inicializa��o de vari�veis
           cont = 0;
           bit = 0;
           
           while(cont < 10 || bit ~= 1)
               frac = frac*2;
               if (frac == 1)
                   bit = 1; %frac*2 � exatamente igual a uma parte inteira
                   Bi = [Bi bit];%adiciona o bit ao final do vetor Bi
                   break;%termina o la�o pois a parte fracion�ria foi completamente convertida
               elseif(frac > 1)
                   bit = 1; %frac*2 superou uma parte inteira
                   frac = frac - 1;%remove a parte inteira novamente
               else
                   bit = 0; %frac*2 n�o atingiu uma parte inteira
               end
               Bi = [Bi bit]; %adiciona o bit ao final do vetor Bi
               cont = cont + 1; %incremento de vari�vel de controle
           end
           tamanho_total = size(Bi);%tamanho do vetor ap�s adicionar a parte fracion�ria
           
           %Para que o usu�rio identifique quais bits representam a parte
           %inteira e quais representam a parte fracion�ria, exibimos estes
           %dados. Os bits mais a esquerda s�o os da parte inteira.
           fprintf("\nTamanho da parte inteira:     %d bits",tamanho_inteiro(2));
           fprintf("\nTamanho da parte fracion�ria: %d bits\n",(tamanho_total(2)-tamanho_inteiro(2)));
        end
    end
end