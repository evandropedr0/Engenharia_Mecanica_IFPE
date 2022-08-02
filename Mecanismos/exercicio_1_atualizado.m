%Exerc�cio 1:

% Comprimento dos elos em mil�metros
% Condi��o de Grashof
% Elo Maior + Elo Menor <= Soma dos Elos Adjacentes




%d= input("Insira o valor do Elo 01: ");
%a= input("Insira o valor do Elo 02: ");
%b= input("Insira o Valor do Elo 03: ");
%c= input("Insira o Valor do Elo 04: ");
%theta2 = input("Insira o Valor do �ngulo Theta 02 em Graus: ");


d = 152.4;
a = 50.8;
b = 177.8;
c = 228.6;
theta2 = 30


% Quest�o 4.6 - Mecanismos

K_1 = d/a;
K_2 = d/c;
K_3 = (a^2 - b^2 + c^2 + d^2)/(2*a*c);
K_4 = d/b;
K_5 = (c^2-d^2-a^2-b^2)/(2*a*b);

A = cosd(theta2)-K_1-K_2*cosd(theta2)+K_3;
B = -2*sind(theta2);
C = K_1-(K_2+1)*cosd(theta2)+K_3;
D = cosd(theta2)-K_1+K_4*cosd(theta2)+K_5;
E = -2*sind(theta2);
F = K_1+(K_4-1)*cosd(theta2)+K_5;

theta3_1 = 2*atand((-E+sqrt((E^2)-(4*D*F)))/(2*D));
theta3_2 = 2*atand((-E-sqrt((E^2)-(4*D*F)))/(2*D));
theta4_1 = 2*atand((-B+sqrt(B^2-(4*A*C)))/(2*A));
theta4_2 = 2*atand((-B-sqrt(B^2-(4*A*C)))/(2*A));

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
 

omega_2 = 10; %(Rad/s)
%omega_2 = input("Insira �mega-2 em Rad/s :")

%alpha_2 = input("Insira o Valor de Alpha 2: "
alpha_2 = 0


%aberto
omega_3_aberto = (a*omega_2*sind(theta4_2-theta2))/(b*sind(theta3_2-theta4_2))
 
omega_4_aberto = (a*omega_2*sind(theta2-theta3_2))/(c*sind(theta4_2-theta3_2))
 

j = sqrt(-1);

V_a_aberto = abs(a*omega_2*(-sind(theta2)+j*cosd(theta2)))
 
V_ba_aberto = abs(b*omega_3_aberto*(-sind(theta3_2)+j*cosd(theta3_2)))
 
V_b_aberto = abs(c*omega_4_aberto*(-sind(theta4_2)+j*cosd(theta4_2)))
 

A_aberto = c*sind(theta4_2);
B_aberto = b*sind(theta3_2);
C_aberto = (a*alpha_2*sind(theta2))+(a*(omega_2^2)*cosd(theta2))+(b*(omega_3_aberto^2)*cosd(theta3_2))-(c*(omega_4_aberto^2)*cosd(theta4_2));
D_aberto = c*cosd(theta4_2);
E_aberto = b*cosd(theta3_2);
F_aberto = a*alpha_2*cosd(theta2)-a*omega_2^2*sind(theta2)-b*omega_3_aberto^2*sind(theta3_2)+c*omega_4_aberto^2*sind(theta4_2);

alpha_3_aberto = ((D_aberto*C_aberto)-(F_aberto*A_aberto))/((E_aberto*A_aberto)-(D_aberto*B_aberto))
 
alpha_4_aberto = ((C_aberto*E_aberto) - (B_aberto*F_aberto))/((A_aberto*E_aberto)-(B_aberto*D_aberto))
 

%aV_aberto
%=a*alpha_2*(-send(theta2)+j*cosd(theta2)-a*omega_2^2*(cosd(theta2)+j*sind(theta2)))
%baV_aberto = b*alpha_3_aberto*(-send(theta3_2)+j*cosd(theta3_2)-b*omega_2^2*(cosd(theta2)+j*sind(theta2)))

%Cruzado

omega_3_cruzado = (a*omega_2*sind(theta4_22-theta2))/(b*sind(theta3_22-theta4_22))
 
omega_4_cruzado = (a*omega_2*sind(theta2-theta3_22))/(c*sind(theta4_22-theta3_22))
 

V_a_cruzado = abs(a*omega_2*(-sind(theta2)+j*cosd(theta2)))
 
V_ba_cruzado = abs(b*omega_3_cruzado*(-sind(theta3_22)+j*cosd(theta3_22)))
 
V_b_cruzado = abs(c*omega_4_cruzado*(-sind(theta4_22)+j*cosd(theta4_22)))
 

A_cruzado = c*sind(theta4_22);
B_cruzado = b*sind(theta3_22);
C_cruzado = a*alpha_2*sind(theta2)+a*omega_2^2*cosd(theta2)+b*omega_3_cruzado^2*cosd(theta3_22)-c*omega_4_cruzado^2*cosd(theta4_22);
D_cruzado = c*cosd(theta4_22);
E_cruzado = b*cosd(theta3_22);
F_cruzado = a*alpha_2*cosd(theta2) - a*omega_2^2*sind(theta2)-b*omega_3_cruzado^2*sind(theta3_22) + c*omega_4_cruzado^2*sind(theta4_22);

alpha_3_cruzado = ((D_cruzado*C_cruzado)-(F_cruzado*A_cruzado))/((E_cruzado*A_cruzado)-(D_cruzado*B_cruzado))
 
alpha_4_cruzado = ((C_cruzado*E_cruzado) - (B_cruzado*F_cruzado))/((A_cruzado*E_cruzado)-(B_cruzado*D_cruzado))
 

a_xy = [a*cosd(theta2), a*sind(theta2)];
b_xy = [a_xy(1) + b*cosd(theta3_2), a_xy(2) + b*sind(theta3_2)];
c_xy = [b_xy(1) - c*cosd(theta4_2), b_xy(2) - c*sind(theta4_2)];

x = [0, a_xy(1), b_xy(1), c_xy(1), 0];
y = [0, a_xy(2), b_xy(2), c_xy(2), 0];


plot(x,y)
grid('on')