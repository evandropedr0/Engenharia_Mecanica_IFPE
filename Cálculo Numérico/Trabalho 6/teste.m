x = [1 2.5 4];
y = [5.5 4.9 5.5];

s = SplineCubica(x,y);
plotarspline3(s,x);
axis equal tight