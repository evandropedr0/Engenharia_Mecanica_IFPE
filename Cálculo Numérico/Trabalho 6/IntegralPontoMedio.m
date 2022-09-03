function [ I,erro ] = IntegralPontoMedio(a,b,f,n)
%Calcula integral numericamente pelo método do Ponto Médio
%Parâmetros: [ I,erro ] = IntegralTrapezio(a,b,f,n)
%a: ponto inicial do domínio de integração
%b: ponto final do domínio de integração
%f: função do integrando 
%n: número de intervalos
%I: valor da integral (saída)
%erro: estimativa de erro de truncamento (saída)

    %%%VALIDAÇÃO%%%
    if isa(f,'sym')==false 
        f = sym(f); %transforma string em uma função simbólica
    end
    if isnumeric(a)==false||isnumeric(b)==false||isnumeric(n)==false
        disp('Erro. Parâmetros a, b e n devem ser numéricos.');
        I = 'erro'; erro = I;
        return;
    end
    if a>b % a deve ser menor que b
        disp('Erro. Parâmetro a deve ser menor que b.');
        I = 'erro'; erro = I;
        return;
    elseif a==b % a deve ser diferente de b
        disp('Erro. Parâmetros a e b devem ser diferentes.');
        I = 'erro'; erro = I;
        return;
    end
    if mod(fix(n),n)~=0||n<=0
        disp('Erro. Número de intervalos deve ser um inteiro positivo.');
        I = 'erro'; erro = I;
        return;
    end
    
    %%%PROCESSAMENTO%%%
    h = (b-a)/n; %define tamanho do intervalo
    x = a:h:b; %discretização do domínio
    g = inline(f); %cria função inline a partir de f    
    soma = 0; %declaração da variável do somatório
    for i = 1:n
        %calcula imagem de cada ponto médio e acrescenta à soma
        soma = soma + g((x(i)+x(i+1))/2);
    end
    
    %%%SAÍDA%%%
    I = h*soma; %cálculo da integral
    
    %cálculo do erro
    erro = ((b-a)/24)*maximo(diff(f,2),a,b)*h^2;
end