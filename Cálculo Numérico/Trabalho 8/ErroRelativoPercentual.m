function [ erro ] = ErroRelativoPercentual(Vexato,Vaproximado)
%Calcula o erro relativo percentual de um valor aproximado
%Par�metros: [ erro ] = ErroRelativoPercentual(Vexato,Vaproximado)
%Vexato: valor exato
%Vaproximado: valor aproximado
%erro: erro relativo percentual (sa�da)

    %%%VALIDA��O%%%
    if isnumeric(Vexato)==false||isnumeric(Vaproximado)==false
        disp('Erro. Todos os par�metros devem ser num�ricos.');
        erro = 'erro';
        return;
    end
    
    %%%PROCESSAMENTO E SA�DA%%%
    erro = (abs(Vexato - Vaproximado)./abs(Vexato))*100;
end