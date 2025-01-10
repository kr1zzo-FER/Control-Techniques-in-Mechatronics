close all;
clear all;

s = tf('s');

%proces
K = 1.187;
tau = 0.186;
U_n = 6;

Gp = K / (tau*s+1);


%pid
P = 0.8;
I = 5;
D = 0.001;
N = 10;

G_pid = P+ I/s + (D * N) / (1 + N/s)

[num_pid, den_pid] = tfdata(G_pid, 'v')
%% 3.2

Ts1 = 0.03;

Gpid_D_1 = c2d(G_pid, Ts1, 'Tustin')
[num1,den1] = tfdata(Gpid_D_1, 'v');

%pzmap(Gpid_D_1)

fiTyp = numerictype(1,16,8);

[num_fi] = double(fi(num1, fiTyp));
[den_fi] = double(fi(den1, fiTyp));
Gpid_D_FI_1 = tf(num_fi, den_fi, Ts1)
pzmap(Gpid_D_FI_1)

%%
Ts2 = 0.005;

Gpid_D_2 = c2d(G_pid, Ts2, 'Tustin')

[num2,den2] = tfdata(Gpid_D_2, 'v')

%pzmap(Gpid_D_2)

fiTyp = numerictype(1,16,8);

[num2_fi] = double(fi(num2, fiTyp));
[den2_fi] = double(fi(den2, fiTyp));
Gpid_D_FI_2 = tf(num2_fi, den2_fi, Ts2)
pzmap(Gpid_D_FI_2)

%% 3.4. Implementacija kaskadnog regulatora u diskretnoj domeni sa "fixed point" koeficijentima
[z]=roots([1 (I+P*N)/(P+D*N) I*N/(P+D*N)])
z1=z(1) 
z2=z(2)
G1=tf((P+D*N)*[1 -z1], [1 0])
G2=tf([1 -z2], [1 N])

G1d_ts1=c2d(G1,Ts1, 'Tustin')
G2d_ts1=c2d(G2,Ts1, 'Tustin')
G1d_ts2=c2d(G1,Ts2, 'Tustin')
G2d_ts2=c2d(G2,Ts2, 'Tustin')

[num3,den3] = tfdata(G1d_ts1, 'v');
[num3_fi] = double(fi(num3, fiTyp));
[den3_fi] = double(fi(den3, fiTyp));
Gpid_D_S1_FI_3 = tf(num3_fi, den3_fi, Ts1)

[num4,den4] = tfdata(G2d_ts1, 'v'); 
[num4_fi] = double(fi(num4, fiTyp)); 
[den4_fi] = double(fi(den4, fiTyp)); 
Gpid_D_S2_FI_4 = tf(num4_fi, den4_fi, Ts1);

[num5,den5] = tfdata(G1d_ts2, 'v'); 
[num5_fi] = double(fi(num5, fiTyp)); 
[den5_fi] = double(fi(den5, fiTyp)); 
Gpid_D_S1_FI_5 = tf(num5_fi, den5_fi, Ts2);

[num6,den6] = tfdata(G2d_ts2, 'v'); 
[num6_fi] = double(fi(num6, fiTyp)); 
[den6_fi] = double(fi(den6, fiTyp)); 
Gpid_D_S2_FI_6 = tf(num6_fi, den6_fi, Ts2);

