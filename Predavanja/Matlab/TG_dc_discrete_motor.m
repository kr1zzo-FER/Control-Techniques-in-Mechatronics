%Usporedba sustava upravljanja emuliranim kontinuranim TG regulatorom
% i sustava upravljanja s regulatorm dobivenim diskretnim TG postupkom
%Butterworth oblik uz tm=0.01

tm=10e-3; %zahtjev
%DC motor
K=10;
T1=5e-3;
T2=30e-3;

T=2e-3; %vrijeme diskretizacije
Gp=tf(K,conv([T1 1],[T2 1])); %Proces

Gpd=c2d(Gp,T,'zoh');% Diskretizirani proces
bp0=Gpd.Numerator{1}(3);
bp1=Gpd.Numerator{1}(2);


omg0=4.3/tm;

%Kontinuirani TG regulator
Gm=tf(omg0^2,[1 1.4*omg0 omg0^2]);
Gr=minreal(1/Gp*Gm/(1-Gm));
Grz=minreal(Gr*Gp/(1+Gr*Gp),1e-2);
[hc,tc]=step(Grz,0.04);



%Diskretni TG
p=roots([1 1.4*omg0 omg0^2]); %polovi od Am
pz=exp(p*T); %Preslikavanje polova
Amz=poly(pz); %Formiranje polinoma Am(z)

%Proračun koeficijenata Bm(z)
% 1. uvjet: red polinoma u brojniku <=1
% 2. Stacionarna točnost Gm(a)=1 -> Bm(1)=Am(1)
b1m=bp1/(bp1+bp0)*sum(Amz);
b0m=bp0/(bp1+bp0)*sum(Amz);

ripple_free=1;
if ripple_free==1
Bmz=[b1m b0m];
else
    b1m=sum(Amz);
 Bmz=[b1m 0];   
end
%Km=sum(Amz)/sum(Bmz);
Gmz=tf(Bmz,Amz,T);



Grd=minreal(1/Gpd*Gmz/(1-Gmz));% Regulator u z-domeni
Grzd=minreal(Grd*Gpd/(1+Grd*Gpd));% Zatv. reg. krug prema referenci
[hd1,td1]=step(Grzd);
hold on;


%Emulacija EMUL1
Grde1=c2d(Gr,T,'Tustin');
Grzde1=minreal(Grde1*Gpd/(1+Grde1*Gpd));
[hd2,td2]=step(Grzde1);


%Emulacija EMUL2
Gpa=tf(K,conv([T1+T/2 1],[T2 1]));
Gre2=minreal(1/Gpa*Gm/(1-Gm));
Grde2=c2d(Gre2,T,'Tustin');
Grzde2=minreal(Grde2*Gpd/(1+Grde2*Gpd));
[hd3,td3]=step(Grzde2);


subplot(311),plot(tc,hc); hold on, stem(td2,hd2,'r'), title('EMUL1') 
subplot(312),plot(tc,hc); hold on, stem(td3,hd3,'r'), title('EMUL2') 
subplot(313),plot(tc,hc); hold on, stem(td1,hd1,'r'), title('Ragazzini') 

