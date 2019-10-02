%Valve Flowrate determination 
clear all 
close all

%% Experiment 1

%Experiment 1 
Exp1 = csvread('Valves_Data.csv');
[a,b] = size(Exp1);
b = 9;

for i = 1:b
    C{i} = Exp1(:,i);
    for j = a:-1:2
        if(C{i}(j,1) == 0)
            C{i}(j,1) = NaN;
        end
    end 
end 

%find index of first trailing zero 
index = [];
for i = 1:b
    Cell = min(find(isnan(C{1,i})));
    if isempty(Cell)
        Cell = a;
    end 
    index(i) = Cell;
end

%Delete all values 100 values before first trailing zero
index = index - 100;
for i = 1:b
    C{1,i}(index:end,1) = NaN;
    C{1,i}(1:150,1) = NaN;
end 

NoV_1t = C{1,1}(:,1)./1000;
NoV_1p = 6.89476.*smooth(C{1,2}(:,1));  %kpa
NoV_2t = C{1,4}./1000;
NoV_2p =  6.89476.*smooth(C{1,5}(:,1));
NoV_3t = C{1,7}(:,1)./1000;
NoV_3p =  6.89476.*smooth(C{1,8}(:,1));

m = 591/(287.058*294.15)*1000;
NoV_1m = m.*NoV_1p./NoV_1t; %mg/s      
NoV_2m = m.*NoV_2p./NoV_2t;
NoV_3m = m.*NoV_3p./NoV_3t;
v = 60/(1.2754*1000);
NoV_1v = v.*NoV_1m; %L/min      
NoV_2v = v.*NoV_2m;
NoV_3v = v.*NoV_3m;

mass1 = m.*NoV_1p; dm1 = diff(mass1)./diff(NoV_1t); vol1 = v.*mass1; dv1 = diff(vol1)./diff(NoV_1t);
mass2 = m.*NoV_2p; dm2 = diff(mass2)./diff(NoV_2t); vol2 = v.*mass2; dv2 = diff(vol2)./diff(NoV_2t);
mass3 = m.*NoV_3p; dm3 = diff(mass3)./diff(NoV_3t); vol3 = v.*mass3; dv3 = diff(vol3)./diff(NoV_3t);

%% plots
figure();
plot(NoV_1t,NoV_1p,'--b'); 
hold on 
plot(NoV_2t,NoV_2p,'--g'); 
plot(NoV_3t,NoV_3p,'--r'); 

hold off 
legend('No Valve Trial 1','No Valve Trial 2','No Valve Trial 3','Location','SouthEast');
xlabel('time [s]');
ylabel('P_{actuator} [KPa]');
title('Pressure Curve');
set(gca,'FontSize',14);

figure();
plot(NoV_1t,NoV_1m,'--b'); 
hold on 
plot(NoV_2t,NoV_2m,'--g'); 
plot(NoV_3t,NoV_3m,'--r');
% plot(NoV_1t(1:end-1,1),dm1,'b');
% plot(NoV_2t(1:end-1,1),dm2,'g');
% plot(NoV_3t(1:end-1,1),dm3,'r');

hold off 
legend('V1','V2','V3','V1 diff','V2 diff','V3 diff','Location','NorthEast');
xlabel('time [s]');
ylabel('dm/dt [mg/s]');
title('Mass Flow Rate Range');
set(gca,'FontSize',14);

figure();
plot(NoV_1t,NoV_1v,'--b'); 
hold on 
plot(NoV_2t,NoV_2v,'--g'); 
plot(NoV_3t,NoV_3v,'--r'); 
plot(NoV_1t(1:end-1,1),dv1,'b');
plot(NoV_2t(1:end-1,1),dv2,'g');
plot(NoV_3t(1:end-1,1),dv3,'r');

hold off 
legend('V1','V2','V3','V1 diff','V2 diff','V3 diff','Location','NorthEast');
xlabel('time [s]');
ylabel('dV/dt [L/min]');
title('Volume Flow Rate Range');
set(gca,'FontSize',14);