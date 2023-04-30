clc                 % clear the command window
clear               % clear all variables from memory
close all           % close all open figures

tic           % start timer
[h,hg,T,P,rho,a]=isa_prop_improved(100); 
toc           % stop timer and display elapsed time

% plot ISA parameters
figure('Name','ISA Parameters')

subplot(3,3,1)
plot(h,hg,'LineWidth',2)
xlabel("h (km)")
ylabel("hg (km)")
hold on
grid on
axis([0 120 0 120])

subplot(3,3,[2 5 8])
plot(T,hg,'LineWidth',2)
xlabel("T (℃)")
ylabel("hg (km)")
hold on
grid on
axis([-150 50 0 120])

subplot(3,3,[3 6 9])
plot(a,hg,'LineWidth',2)
xlabel("a (km/h)")
ylabel("hg (km)")
legend('1','2','3','4','5','6','7')
hold on
grid on
axis([900 1300 0 120])

subplot(3,3,4)
plot(P,hg,'LineWidth',2)
xlabel("P (bar)")
ylabel("hg (km)")
hold on
grid on
axis([0 1.5 0 120])

subplot(3,3,7)
plot(rho,hg,'LineWidth',2)
xlabel("ρ (kg/m^3)")
ylabel("hg (km)")
hold on
grid on
axis([0 1.5 0 120])