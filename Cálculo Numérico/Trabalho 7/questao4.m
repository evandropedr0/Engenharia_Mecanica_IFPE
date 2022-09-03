%Questão 4
tic;
H = [0;1.8;2;4;4;6;4;3.6;3.4;2.8;0];
U = [0;0.1;0.14;0.36;0.38;0.47;0.43;0.33;0.25;0.18;0];
y = 0:2:20;
delta_y = y(length(y))-y(1);

%4.a) Calcular profundidade média
ProfundidadeMedia = (1/(delta_y))*IntTrapz(y,H)

%4.b) Calcular área da seção transversal
Area = IntTrapz(y,H)

%4.c) Calcular velocidade média
VelocidadeMedia = (1/(delta_y))*IntTrapz(y,U)

%4.d) Calcular vazão do escoamento
Vazao = IntTrapz(y,H.*U)
toc;