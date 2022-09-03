syms x;
f = sqrt(2*x).*sin(5*pi*x);
df5 = diff(f,5);
g = -df5;
g = inline(g);
max = fminbnd(g,0.4,0.95);
df = inline(df5);
ymax = df(max);
erro = ((abs((max-0.4))*abs((max-0.5))*abs((max-0.6))*abs((max-0.75))...
    *abs((max-0.95)))/factorial(5))*abs(ymax)