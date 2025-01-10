%% TUUM1 - Skripta za pokretanje eksperimenta

% parametri PID regulatora
Kp = 3;
Ti = 0.3;
Td = 0.02;
N = 100;
Tt = 0.1;

% zasićenje napona i amplituda referentne brzine
SAT = 3;  % [V]
REF = 5;  % [rad/s]

%% pokrenuti eksperiment u Simulinku