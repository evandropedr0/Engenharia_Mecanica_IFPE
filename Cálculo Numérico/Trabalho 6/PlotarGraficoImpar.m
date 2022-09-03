%declarando quadrados
[x1,y1] = formarquadrado(0,0);
[x2,y2] = formarquadrado(1,0);
[x3,y3] = formarquadrado(2,0);
[x4,y4] = formarquadrado(3,0);
[x5,y5] = formarquadrado(4,0);
[x6,y6] = formarquadrado(5,0);
[x7,y7] = formarquadrado(6,0);
[x8,y8] = formarquadrado(2,1);
[x9,y9] = formarquadrado(3,1);
[x10,y10] = formarquadrado(4,1);
[x11,y11] = formarquadrado(6,1);
[x12,y12] = formarquadrado(7,1);
[x13,y13] = formarquadrado(8,1);
[x14,y14] = formarquadrado(3,2);
[x15,y15] = formarquadrado(4,2);
[x16,y16] = formarquadrado(8,2);
[x17,y17] = formarquadrado(9,2);
[x18,y18] = formarquadrado(2,3);
[x19,y19] = formarquadrado(3,3);
[x20,y20] = formarquadrado(4,3);
[x21,y21] = formarquadrado(6,3);
[x22,y22] = formarquadrado(7,3);
[x23,y23] = formarquadrado(8,3);
[x24,y24] = formarquadrado(0,4);
[x25,y25] = formarquadrado(1,4);
[x26,y26] = formarquadrado(2,4);
[x27,y27] = formarquadrado(3,4);
[x28,y28] = formarquadrado(4,4);
[x29,y29] = formarquadrado(5,4);
[x30,y30] = formarquadrado(6,4);

%juntando tudo em duas matrizes
x = [x1 x2 x3 x4 x5 x6 x7 x8 x9 x10];
x = [x x11 x12 x13 x14 x15 x16 x17 x18 x19 x20];
x = [x x21 x22 x23 x24 x25 x26 x27 x28 x29 x30];
y = [y1 y2 y3 y4 y5 y6 y7 y8 y9 y10];
y = [y y11 y12 y13 y14 y15 y16 y17 y18 y19 y20];
y = [y y21 y22 y23 y24 y25 y26 y27 y28 y29 y30];

%apagando vetores
clear x1 x2 x3 x4 x5 x6 x7 x8 x9 x10
clear x11 x12 x13 x14 x15 x16 x17 x18 x19 x20
clear x21 x22 x23 x24 x25 x26 x27 x28 x29 x30
clear y1 y2 y3 y4 y5 y6 y7 y8 y9 y10
clear y11 y12 y13 y14 y15 y16 y17 y18 y19 y20
clear y21 y22 y23 y24 y25 y26 y27 y28 y29 y30

%plotando
patch(x,y,'g','LineWidth',2);
axis equal tight
grid on