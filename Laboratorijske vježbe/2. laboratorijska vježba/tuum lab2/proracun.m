G = tf ([0 1.467],[0.155 1 0]) %quanser
 % G = tf ([0 1.633],[0.166 1 0]) %me13
w_c = 5;

%quanser
figure
margin(G*4.31)

%me13
% figure
% margin(G*3.98)

%quanser
fi = 85-52.2
fi_rad = (fi * pi) / 180

%me13
 % fi = 85-50.3
 % fi_rad = (fi * pi) / 180


alfa = (1-sin(fi_rad)) / (1+sin(fi_rad))

T = 1 / (sqrt(alfa) * w_c)
G_fp = tf ([sqrt(alfa)*T sqrt(alfa)], [alfa*T 1])

%quanser
figure
margin(G*4.31*G_fp)

%me13
% figure
% margin(G*3.98*G_fp)

Ts = 0;

%quanser
figure
step ( feedback(G*4.31*G_fp , 1) )

%me13
% figure
% step ( feedback(G*3.98*G_fp , 1) )




