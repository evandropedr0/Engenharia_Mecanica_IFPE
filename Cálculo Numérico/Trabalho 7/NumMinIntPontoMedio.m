function [ n ] = NumMinIntPontoMedio(a,b,f,tol)
%Esta função calcula o número mínimo de intervalos para garantir uma
%exatidão definida no processo de integração numérica pelo método do
%ponto médio.
%Parâmetros: [ n ] = NumMinIntTrapezio(a,b,f,tol)
%a: extremo inferior do domínio de integração
%b: extremo superior do domínio de integração
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
    d2f = diff(f,2); %calcula segunda derivada de f
    ymax = maximo(d2f,a,b); %calcula ponto máximo de d2f
    
    %calcula tamanho do passo de acordo com fórmula de estimativa de erro
    %do método do trapézio
    h = sqrt((24*abs(tol))/(abs(b-a)*abs(ymax)));
    
    %%%SAÍDA%%%
    n = ceil((b-a)/h); %calcula o número de passos no intervalo e arredonda
                       %para cima
end