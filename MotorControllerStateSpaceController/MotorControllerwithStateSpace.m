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

% x_dot = A*x+B*u ' daki statelerin katsay�s� olan matrix.
a11 = -R/L;
a12 = -K/L;
a21 = K/J;
a22 = -b/J;

% x_dot = A*x+B*u ' daki inputun katsay�s� olan matrix.
b11 = 1/L;
b21 = 0;

A = [a11,a12;
     a21,a22];
 
B = [b11;
     b21];
 
%% Check the controllability.
 
 ctrb_motor = ctrb(A,B);
 
 rank_evaluation = rank(ctrb_motor) - rank(A);
 %Rank de�erleri biribirinden ��kar�ld���nda sonu� 0 ise ranklar� e�ittir
 %Sonu� 0 ise bu sistem CONTROLLABLE d�r.
 %E�er ki controllable ise bunun �zerine istedi�imiz herhangi bir
 %kontrolc�y� tasarlayabiliriz.
 
 %Ayr�ca eig(A) komutu ile de s-domainindeki hangi yerde oldu�unu s�yler.
 %Input matrisi kare matis olmal�.eig(B) yaz�nca bu hatay� verir.
 
 %% Place Function 
 
 p = [-30,-40]; 
 %2 state var ve yerle�tirmek istedi�imiz k�k de�erleri
 %K�k ne kadar solda ise o kadar s�f�ra yak�nl��� daha az olur.
 %Yani -4 ve -5 ise daha bombeli
 %-30 ve -40 ise daha keskin bir ini� yapcakt�r.
 
 K = place(A,B,p);
 A_cl = (A-B*K); % u = -K.x
 
 eig(A_cl)
 
 %eig(A)'dan s-domainindeki konumlar�n�(K�kler = -21.8492 , -0.7064) 
 %bulduktan sonra bunun -4 ve -5 'e ta��mak istedik. 
 
 %K katsay�lar� Characteristic Equation'�n denklemindeki k�klerin s planede
 %nerede olaca��n� se�er.
 
%% Reference Tracking

 A_new = [A,zeros(2,1);
          0, 1, 0];
      
 B_new = [B; 
          0];     
      
 p = [-200, -150, -100];     %Arbitrary values, poles.
 K = place(A_new, B_new, p);
 
 eig(A_new-B_new*K)