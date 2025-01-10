% parametri laboratorijskih postava

% quanser 

% Tsigma = 0.002
% J = 0.0060
% Cm = 0.8333
% Tfb = 0.010

% me13
Tsigma = 0.010
J = 0.0049
Cm = 0.7342
Tfb = 0.010


% %  PI regulacija brzine (bez filtra)
% TIw = 8 * Tsigma
% KRw = J / (4 * Cm * Tsigma)
% 
% %anti windup PI regulator (bez filtra)
% Tt = TIw



%  PI regulacija brzine (filtar)
TIw = 4 * (2 * Tsigma + Tfb)
KRw = J / (2 * Cm * (2 * Tsigma + Tfb))

%anti windup PI regulator (filtar)
Tt = TIw


%prefiltar
Gpf = tf( [ 0 0 1], [TIw * Tfb (TIw + Tfb) 1])

% P regulator pozicije
KRtheta = 1 / (32 * Tsigma + 16 * Tfb)