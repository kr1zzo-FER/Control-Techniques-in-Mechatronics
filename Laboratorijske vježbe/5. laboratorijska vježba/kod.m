% Parametri sustava
K = 1.033;
tau = 0.157;

% Prijenosna funkcija procesa
s = tf('s');
Gp = K/(tau*s + 1);

% Parametri kontinuiranog PID regulatora
P = 1;
I = 10;
D = 0.02;
N = 10;

% Napisati prijenosnu funkciju regulatora
Gr = P+ I/s + (D * N) / (1 + N/s) 
     
% Odrediti prijenosnu funkciju zatvorenog kruga i koristeći naredbu 'bandwidth' pronaći širinu frekvencijskog pojasa zatvorenog kruga
Gcl = (Gr * Gp) / (1 + Gr * Gp) 
wb = bandwidth(Gcl)

%{
% Odrediti vrijeme uzorkovanja
Ts = ...;

% Diskretizirati regulator
Grd = ...;
Grd1 = Grd;  % spremanje varijable radi provjere
    
% Postavke simulacije
wref = 1;  % [rad/s] referentna brzina motora
Tsim = 3;  % [s] trajanje simulacije

% Simulacija sustava uz kontinuirani i diskretni regulator
simulacija_sustava_new

% Odabrati 5 do 10 puta veće vrijeme uzorkovanja od prethodnog 
Ts2 = ...;
    
% Ponovno diskretizirati kontinuirani regulator
Grd = ...;
Grd2 = Grd;  % spremanje varijable radi provjere    
%}