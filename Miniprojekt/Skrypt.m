
%parametry zadania
Tzewn = -20; 
Tw1 = 20;
Tw2 = 15;
Tkzn = 30;
Pkn = 20000;
rop = 1.2;
cp = 1000;
rob = 1400;
cb = 880;
fk = Pkn/(rop*cp*303.15);
ks1 = (cp*rop*fk*(Tkzn-Tw1))/(Tw1-Tzewn+(1/3)*(Tw1-Tw2));
ks2 = ((1/3)*ks1*(Tw1-Tw2)+cp*rop*fk*(Tw1-Tw2))/(Tw2-Tzewn);
k0 = (1/3)*ks1;



%parametry symulacji
czas_skoku = 50000;
czas = 1000000;
fk0 = fk * 1;
dfk0 = fk * 0.12;
Tkz0 = Tkzn *1;
dTkz0 = 0;
Tzew0 = Tzewn + 0;
dTzew0 = 0;
Vw1 = 40;
Cv1 = cb*rob*Vw1;
Vw2 = 45;
Cv2 = cb*rob*Vw2;



%warunki pocz¹tkowe
Tw10 = ((k0+cp*rop*fk0+ks2)*(cp*rop*fk0*Tkz0+ks1*Tzew0)+k0*ks2*Tzew0)/((cp*rop*fk0+ks1+k0)*(k0+cp*rop*fk0+ks2)-k0*(k0+cp*rop*fk0));
Tw20 = (Tw10*(k0+cp*rop*fk0)+ks2*Tzew0)/(k0+cp*rop*fk0+ks2);
sim('Schemat.slx', czas);
figure(1);
plot(t,Tw1, 'b');
hold on;
plot(t,Tw2,'r');
hold on;
plot(t,Tzew,'g');
grid on, title('Tw1,Tw2,Tzew'), legend('Tw1','Tw2','Tzew');


%Rownania stanu

%warunki pocz¹tkowe i parametry
Tkz0 = Tkzn + 0;
Tzew0 = Tzewn * 1.0;
fk0 = fk * 1.0;

%Macierze

A = [(-cp*rop*fk-ks1-k0)/Cv1, k0/Cv1; (cp*rop*fk+k0)/Cv2, (-k0-cp*rop*fk-ks2)/Cv2];
B = [cp*rop*fk/Cv1, ks1/Cv1; 0, ks2/Cv2];
C = [1,0; 0,1]; D = [0,0; 0,0];

%stan rownowagi
u0 = [Tkz0; Tzew0];
x0 = -A^-1 * B*u0;

%symulacja

czas = 500;
%zak³ócenie
czas_skok = 50;
dTkz0 = 0.14 * Tkzn;
dTzew0 = 0;

sim('Schemata.slx', czas);

%wykresy
figure; 
plot(t, aTw1,'r');
hold on;
plot(t, aTw2,'b');
hold on;
plot(t, aTzew,'g');
grid on;
title('Tw1, Tw2, Tzew');
legend('Tw1','Tw2','Tzew');
%TRANSMITANCJE

%warunki pocz¹tkowe
Tzew0 = Tzewn + 0;
Tkz0 = Tkzn * 1.0;
fk0 = fk *1.0;

%definicja wspó³czynników transmitancji

M = [Cv1*Cv2, Cv1*(k0+cp*rop*fk+ks2)+Cv2*(cp*rop*fk+ks1+k0), (cp*rop*fk+ks1+k0)*(cp*rop*fk+ks2+k0)-k0^2-k0*cp*rop*fk];

L11 = [Cv2*cp*rop*fk, cp*rop*fk*(k0+cp*rop*fk+ks2)];
L12 = [ks1*Cv2, ks1*(k0+cp*rop*fk+ks2)+k0*ks2];
L21 = [k0*cp*rop*fk+(cp*rop*fk)^2];
L22 = [ks2*Cv1, ks2*(cp*rop*fk+ks1+k0)+k0+ks1+cp*rop*fk*ks1];

%warunki pocz¹tkowe
Tw10 = ((k0+cp*rop*fk0+ks2)*(cp*rop*fk0*Tkz0+ks1*Tzew0)+k0*ks2*Tzew0)/((cp*rop*fk0+ks1+k0)*(k0+cp*rop*fk0+ks2)-k0*(k0+cp*rop*fk0));
Tw20 = (Tw10*(k0+cp*rop*fk0)+ks2*Tzew0)/(k0+cp*rop*fk0+ks2);
czas = 1000000;
%zak³ócenie
czas_skok = 50000;
dTkz0 = 0;
dTzew0 = 0;

sim('Schematb.slx', czas);

figure;
plot(t, aTw1, 'b');
hold on;
plot(t, aTw2,'r');
hold on;
plot(t, aTzew,'g');
grid on, title('Tw1,Tw2,Tzew'), legend('Tw1','Tw2','Tzew');



