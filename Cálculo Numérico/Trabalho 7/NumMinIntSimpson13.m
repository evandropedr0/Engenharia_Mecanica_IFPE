function [ n ] = NumMinIntSimpson13(a,b,f,tol)
%Esta função calcula o número mínimo de intervalos para garantir uma
%exatidão definida no processo de integração numérica pelo método de
%Simpson de 1/3.
%Parâmetros: [ n ] = NumMinIntSimpson13(a,b,f,tol)
%a: extremo esquerdo do domínio de integração
%b: extremo direito do domínio de integração
%f: função do integrando
%tol: tolerância de exatidão.

    %%%VALIDAÇÃO%%%
    if isa(f,'sym')==false 
        f = sym(f); %transforma string em uma função simbólica
    end
    if isnumeric(a)==false||isnumeric(b)==false||isnumeric(tol)==false
        disp('Erro. Parâmetros a, b e tol devem ser numéricos.');
        n = 'erro';
        return;
    end
    if a>b % a deve ser menor que b
        disp('Erro. Parâmetro a deve ser menor que b.');
        n = 'erro';
        return;
    elseif a==b % a deve ser diferente de b
        disp('Erro. Parâmetros a e b devem ser diferentes.');
        n = 'erro';
        return;
    end
    
    %%%PROCESSAMENTO%%%
    d4f = diff(f,4); %calcula segunda derivada de f
    ymax = maximo(d4f,a,b); %calcula ponto máximo de d4f
    
    %calcula tamanho do passo de acordo com fórmula de estimativa de erro
    %do método do trapézio
    h = ((180*abs(tol))/(abs(b-a)*abs(ymax)))^(1/4);
    
    %%%SAÍDA%%%
    n = ceil((b-a)/h); %calcula o número de passos no intervalo
    if mod(n,2)~=0 %se n for impar, acrescenta mais uma unidade
        n = n+1;
    end
end