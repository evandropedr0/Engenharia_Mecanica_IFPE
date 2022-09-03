%declaração de funções e derivadas
f = @(x) 2*x*cos(2*x)-(x-2)^2;
g = @(x) sin(x)-exp(-x);
h = @(x) log(x-1)+cos(x-1);
df = @(x) 2*cos(2*x)-4*x*sin(2*x)-2*(x-2);
dg = @(x) cos(x)+exp(-x);
dh = @(x) (1/(x-1))-sin(x-1);

%chamada de funções
newton_raphson(f,df,2.5,1e-6,50); %4.a intervalo 1
newton_raphson(f,df,3.5,1e-6,50); %4.a intervalo 2
newton_raphson(g,dg,0.5,1e-6,50); %4.b intervalo 1
newton_raphson(g,dg,3.5,1e-6,50); %4.b intervalo 2
newton_raphson(h,dh,1.5,1e-6,50); %4.c
secante(f,2,3,1e-6,50); %5.a intervalo 1
secante(f,3,4,1e-6,50); %5.a intervalo 2
secante(g,0,1,1e-6,50); %5.b intervalo 1
secante(g,3,4,1e-6,50); %5.b intervalo 2
secante(h,1.3,2,1e-6,50); %5.c