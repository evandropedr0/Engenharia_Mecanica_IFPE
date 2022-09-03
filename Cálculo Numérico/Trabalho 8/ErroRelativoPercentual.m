function [ erro ] = ErroRelativoPercentual(Vexato,Vaproximado)
%Calcula o erro relativo percentual de um valor aproximado
%Parâmetros: [ erro ] = ErroRelativoPercentual(Vexato,Vaproximado)
%Vexato: valor exato
%Vaproximado: valor aproximado
%erro: erro relativo percentual (saída)

    %%%VALIDAÇÃO%%%
    if isnumeric(Vexato)==false||isnumeric(Vaproximado)==false
        disp('Erro. Todos os parâmetros devem ser numéricos.');
        erro = 'erro';
        return;
    end
    
    %%%PROCESSAMENTO E SAÍDA%%%
    erro = (abs(Vexato - Vaproximado)./abs(Vexato))*100;
end