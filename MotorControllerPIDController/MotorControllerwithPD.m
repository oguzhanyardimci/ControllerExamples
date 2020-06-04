% Author: oguzhanyardimci

clear all;
close all;
clc;

%% Parameters are defined and Transfer Function was created.
syms K R L J b s Kp Kd KI;

G = K/((J*L)*s^2 + (J*R + L*b)*s + (R*b + K^2)); %Plant for input over output with respect to omega(s) / Voltage(s) 
G_c = Kp+Kd*s; %PD controller (Proportional Derivative)
W_d = 1/s; %Input (Unit Step)

T_s = (G*G_c)/(1 + G*G_c);

pretty(simplify(T_s))

%% For Real Values
J = 0.09;
K = 85*10^-3;
R = 0.55;
b = 0.05;
L = 25*10^-3;

G_v = K/((J*L)*s^2 + (J*R + L*b)*s + (R*b + K^2)); %Plant for input over output with respect to omega(s) / Voltage(s) 
G_c_v = Kp+Kd*s;
W_d_v = 1/s;

pretty(collect(G_v,s))

T_s_v = (G_v*G_c_v)/(1 + G_v*G_c_v);

pretty(collect(T_s_v,s));

