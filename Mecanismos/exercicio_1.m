% Exercício 1:
% Comprimento dos elos em milímetros
% Condição de Grashof
% Elo Maior + Elo Menor <= Soma dos Elos Adjacentes


theta2 = 30

% d= input("Insira o valor do Elo 01: ")
% a= input("Insira o valor do Elo 02: ")
% b= input("Insira o Valor do Elo 03: ")
% c= input("Insira o Valor do Elo 04: ")

d = 152.4
a = 50.8
b = 177.8
c = 228.6

% Questão 4.6 - Mecanismos

K_1 = d/a
K_2 = d/c
K_3 = (a^2 - b^2 + c^2 + d^2)/(2*a*c)
K_4 = d/b
K_5 = (c^2-d^2-a^2-b^2)/(2*a*b)

A = cosd(theta2)-K_1-K_2*cosd(theta2)+K_3
B = -2*sind(theta2)
C = K_1-(K_2+1)*cosd(theta2)+K_3
D = cosd(theta2)-K_1+K_4*cosd(theta2)+K_5
E = -2*sind(theta2)
F = K_1+(K_4-1)*cosd(theta2)+K_5

theta3_1 = 2*atand((-E+sqrt((E^2)-(4*D*F)))/(2*D))
theta3_2 = 2*atand((-E-sqrt((E^2)-(4*D*F)))/(2*D))
theta4_1 = 2*atand((-B+sqrt(B^2-(4*A*C)))/(2*A))
theta4_2 = 2*atand((-B-sqrt(B^2-(4*A*C)))/(2*A))

theta3 = [theta3_1, theta3_2]
theta4 = [theta4_1, theta4_2]

if (theta3_1 > 0)
  theta3_22 = 360 - theta3_1
else
  theta3_22 = 360 + theta3_1
end

if (theta4_1 > 0)
  theta4_22 = 360 - theta4_1
else
  theta4_22 = 360 + theta4_1
end

theta_trans_aberto = (theta3_1 - theta4_1)
theta_trans_cruzado = (theta3_2- theta4_2)

omega_2 = 10 %(Rad/s)

% aberto
omega_3_aberto = (a*omega_2*sind(theta4-theta2))/(b*sind(theta3-theta4))
omega_4_aberto = (a*omega_2*sind(theta2-theta3))/(c*sind(theta4-theta3))

j = sqrt(-1);

V_a_aberto = a*omega_2*(-sind(theta2)+j*cosd(theta2))
V_ba_aberto = b*omega_3_aberto*(-sind(theta3_2)+j*cosd(theta3_2))
V_b_aberto = c*omega_4_aberto*(-sind(theta4_2)+j*cosd(theta4_2))

% Cruzado

omega_3_cruzado = (a*omega_2*sind(theta4_2-theta2))/(b*sind(theta3_2-theta4_2))
omega_4_cruzado = (a*omega_2*sind(theta2-theta3_2))/(c*sind(theta4_2-theta3_2))

V_a_cruzado = a*omega_2*(-sind(theta2)+j*cosd(theta2))
V_ba_cruzado = b*omega_3_aberto*(-sind(theta3_22)+j*cosd(theta3_22))
V_b_cruzado = c*omega_4_aberto*(-sind(theta4_22)+j*cosd(theta4_22))