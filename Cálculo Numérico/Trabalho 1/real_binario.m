function Bi = real_binario(num)
%Transforma um número real positivo em um binario.
%Exemplo:
%real_binario(10)
%ans = 1 0 1 0
%Obs.: o argumento dessa função deve estar entre 0 e 999999.99

    if(num<0||num>999999.99)%validação inicial para intervalo
        disp('Valor inválido! O argumento deve estar entre 0 e 999999.99');
        return
    elseif (num == 0)||(num==1)
        Bi = num;
    else
        %conversão da parte inteira de 'num'
        int = fix(num); %atribui a parte inteira de 'num' a 'int'
        frac = num - int;%atribui a parte fracionária de 'num' a 'frac'
        Bi = [];%inicialização da variável de saída
    
        while (fix(int/2)>=1)%condição de parada: valor inteiro do quociente < 1
            %i recebe o resto da divisão inteira de int por 2, que só pode
            %assumir 2 valores diferentes, 0 ou 1, ou seja, i é um bit.
            i = mod(int,2);
            
            %o i da iteração atual é inserido no início do vetor Bi
            Bi = [i Bi];
            
            %atualização do valor de int
            int = fix(int/2);
        end
        Bi = [int Bi];%insere o último quociente, que é o bit mais significativo.
        
        %conversão da parte fracionária
        %critério de parada: ao menos dez iterações e até encontrar o
        %primeiro bit 1, salvo quando a parte fracionária for completamente
        %convertida antes desse critério.
        if frac > 0 %testa se há parte fracionária a ser convertida
           tamanho_inteiro = size(Bi);%tamanho do vetor somente com a parte inteira
           tamanho_total = 0;
           %inicialização de variáveis
           cont = 0;
           bit = 0;
           
           while(cont < 10 || bit ~= 1)
               frac = frac*2;
               if (frac == 1)
                   bit = 1; %frac*2 é exatamente igual a uma parte inteira
                   Bi = [Bi bit];%adiciona o bit ao final do vetor Bi
                   break;%termina o laço pois a parte fracionária foi completamente convertida
               elseif(frac > 1)
                   bit = 1; %frac*2 superou uma parte inteira
                   frac = frac - 1;%remove a parte inteira novamente
               else
                   bit = 0; %frac*2 não atingiu uma parte inteira
               end
               Bi = [Bi bit]; %adiciona o bit ao final do vetor Bi
               cont = cont + 1; %incremento de variável de controle
           end
           tamanho_total = size(Bi);%tamanho do vetor após adicionar a parte fracionária
           
           %Para que o usuário identifique quais bits representam a parte
           %inteira e quais representam a parte fracionária, exibimos estes
           %dados. Os bits mais a esquerda são os da parte inteira.
           fprintf("\nTamanho da parte inteira:     %d bits",tamanho_inteiro(2));
           fprintf("\nTamanho da parte fracionária: %d bits\n",(tamanho_total(2)-tamanho_inteiro(2)));
        end
    end
end