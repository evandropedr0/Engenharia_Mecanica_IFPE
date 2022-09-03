function [] = plotarspline3(spline,x)
%Plotar spline c�bica.
%Par�metros: plotarspline3(spline,x)
%spline: spline c�bica
%x: vetor x

    for i = 1:length(spline)
        sp = inline(spline(i));%transformando em fun��o inline
        x1 = x(i):0.005:x(i+1);%intervalo em x
        y1 = sp(x1);%c�lculo das imagens no intervalo
        plot(x1,y1,'r','LineWidth',3);%plotando spline
        grid on; hold on;
    end
end

