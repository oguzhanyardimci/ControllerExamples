clear all;
close all;
clc;

%% Parameters are defined.
J = 0.09;
K = 85*10^-3;
R = 0.55;
b = 0.05;
L = 25*10^-3;

%% s_dot matrix are written.

% x_dot = A*x+B*u ' daki statelerin katsayýsý olan matrix.
a11 = -R/L;
a12 = -K/L;
a21 = K/J;
a22 = -b/J;

% x_dot = A*x+B*u ' daki inputun katsayýsý olan matrix.
b11 = 1/L;
b21 = 0;

A = [a11,a12;
     a21,a22];
 
B = [b11;
     b21];
 
%% Check the controllability.
 
 ctrb_motor = ctrb(A,B);
 
 rank_evaluation = rank(ctrb_motor) - rank(A);
 %Rank deðerleri biribirinden çýkarýldýðýnda sonuç 0 ise ranklarý eþittir
 %Sonuç 0 ise bu sistem CONTROLLABLE dýr.
 %Eðer ki controllable ise bunun üzerine istediðimiz herhangi bir
 %kontrolcüyü tasarlayabiliriz.
 
 %Ayrýca eig(A) komutu ile de s-domainindeki hangi yerde olduðunu söyler.
 %Input matrisi kare matis olmalý.eig(B) yazýnca bu hatayý verir.
 
 %% Place Function 
 
 p = [-30,-40]; 
 %2 state var ve yerleþtirmek istediðimiz kök deðerleri
 %Kök ne kadar solda ise o kadar sýfýra yakýnlýðý daha az olur.
 %Yani -4 ve -5 ise daha bombeli
 %-30 ve -40 ise daha keskin bir iniþ yapcaktýr.
 
 K = place(A,B,p);
 A_cl = (A-B*K); % u = -K.x
 
 eig(A_cl)
 
 %eig(A)'dan s-domainindeki konumlarýný(Kökler = -21.8492 , -0.7064) 
 %bulduktan sonra bunun -4 ve -5 'e taþýmak istedik. 
 
 %K katsayýlarý Characteristic Equation'ýn denklemindeki köklerin s planede
 %nerede olacaðýný seçer.
 
%% Reference Tracking

 A_new = [A,zeros(2,1);
          0, 1, 0];
      
 B_new = [B; 
          0];     
      
 p = [-200, -150, -100];     %Arbitrary values, poles.
 K = place(A_new, B_new, p);
 
 eig(A_new-B_new*K)