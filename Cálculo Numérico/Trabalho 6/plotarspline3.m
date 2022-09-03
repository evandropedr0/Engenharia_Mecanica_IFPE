function [] = plotarspline3(spline,x)
%Plotar spline cúbica.
%Parâmetros: plotarspline3(spline,x)
%spline: spline cúbica
%x: vetor x

    for i = 1:length(spline)
        sp = inline(spline(i));%transformando em função inline
        x1 = x(i):0.005:x(i+1);%intervalo em x
        y1 = sp(x1);%cálculo das imagens no intervalo
        plot(x1,y1,'r','LineWidth',3);%plotando spline
        grid on; hold on;
    end
end

