%% Model motora po VS: 
format short g

Ra = 2.6 % Ohm
La = 2.6e-3 % H
J = 0.01; % kgm^2
Ce = 0.01; % Vs/rad
Cm = Ce;
%%
Ta = La/Ra;
Tem = J*Ra/(Ce*Cm)

rez = 1 /(Ta*Tem)
%%
A = [-Ra/La -Ce/La; Cm/J 0]
B = [1/La; 0]
E = [0; 1/J]

%% Idemo odrediti wn i zeta tako da vrijede sljedeće specifikacije:
% sigma <= 4 %. 
% ts <= 2s
% tp <= 0.5 s.

zeta_min = abs(log(4/100))/sqrt(pi^2+(log(4/100))^2)
zeta_min/sqrt(1-zeta_min^2)



%% Polovi moraju imati realni dio manji od -2
%% Polovi moraju imati imaginarni dio veći od 2*pi
%% Odnos realnog i imaginarnog dijela

p1 = -10-i*7
p2 = -10+i*7
p = [p1 p2]
alpha = fliplr(poly([p1 p2]))
alpha0 = alpha(1);
alpha1 = alpha(2);
%%
a0 = 1/(Ta*Tem);
a1 = 1/(Ta);
K_CCF = [-(alpha0-a0) -(alpha1-a1)]

%%
A_CCF = [0 1; -a0 -a1]
B_CCF = [0; 1]
K_CCF = [alpha0-a0 alpha1-a1]

%% T_CCF 

P_CCF = [B_CCF A_CCF*B_CCF]
P = [B A*B]
inv_p = inv(P)
invT_CCF = P_CCF*inv(P)

%% K koristeći Bura - Gass formulu
K_GB = K_CCF*invT_CCF
%%
place(A,B,p)
acker(A,B,p)
%% K koristeći Ackermannovu formulu
K_Acker =  [0 1]*([B A*B]^(-1))*(A^2+20*A+149*eye(size(A)))

%% K koristeći Matlab
K = place(A,B,p)

%% Izračun pojačanja u direktnoj grani
C = [0 1]
abk = A-B*K
abkinv = inv(abk)
rez1 = C*inv(A-B*K)*B
G_CCF = -inv(C*inv(A_CCF-B_CCF*K)*B_CCF)

G = -inv(C*inv(A-B*K)*B)
%% Proširenje integratorom
T = 1/20
p1 = roots([8*T^3 8*T^2 4*T 1])
%%
A1 = [A zeros(2,1); -C 0]
B1 = [B; 0]
%%
Kint = place(A1,B1,p1)
%%
Kint = [0 0 1]*inv([B1 A1*B1 A1^2*B1])*(8*T^3*A1^3+8*T^2*A1^2+4*T*A1 + eye(size(A1)))/(8*T^3)