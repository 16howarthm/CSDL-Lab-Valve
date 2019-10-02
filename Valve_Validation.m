%Valve Validation

close all 
clear all 

%% import data

time = {};
Pout = {};
fileNames = {};
Pin = {};

for i = 1:100
    timeRow = {};
    PoutRow = {};
    PinRow = {};
    fileRow = {};
    
    for j = 1:3
        fileN = strcat('ValveV',int2str(i),'_',int2str(j));
       if exist(fileN,'file') ~= 0
        B = importdata(fileN);
        timeRow = [timeRow,B(1:end,1)];
        PoutRow = [PoutRow,B(1:end,2)];   
        PinRow = [PinRow,B(1:end,3)];        %assuming Pin in column 3
        fileRow = [fileRow,fileN];
       end 
    end 
    fileNames = [fileNames,fileRow];
    time  = [time,timeRow];
    Pout = [Pout,PoutRow];
    Pin = [Pin,PinRow];
end

%% trim Pout Pin time
[l,w] = size(time);

for i = 1:l
for j = 1:w
    cutoff = 0;
    
    Pout{i,j}(end-cutoff:end,1) = NaN;
    Pout{i,j}(1:cutoff,1) = NaN;
   
    time{i,j}(end-cutoff:end,1) = NaN;
    time{i,j}(1:cutoff,1) = NaN;
    
    Pin{i,j}(end-cutoff:end,1) = NaN;
    Pin{i,j}(1:cutoff,1) = NaN;
    
    time{i,j}(:,1) = time{i,j}(:,1)/1000;   %convert ms to s
end
end

%% plot 
names ={};

figure();
hold on 
for i = 1:l
    namesR = {};
    
    for j = 1:w
    p = plot(time{i,j}(:,1), smooth(Pout{i,j}(:,1)),'-');
    p = plot(time{i,j}(:,1), smooth(Pin{i,j}(:,1)),'--');
    namesR = [namesR,fileNames{i,j}];
    
    if j == 1 |2|3
      set(p,'Color','red');
    elseif j == 4
      set(p,'Color','black');
    else
        set(p,'Color','green');
    end 
    end
    names = [names,namesR];
end
hold off

names = {'Valve1_1 Out','ValveV1_1 In','Valve1_2 Out','Valve1_2 In','ValveV1_3 Out','Valve1_3 In',...
    'Valve2_1 Out','Valve2_1 In','Valve3_1 Out','ValveV3_1 In','Valve3_2 Out','Valve3_2 In','ValveV3_3 Out','Valve3_3 In'};

leg = legend(names,'Location','SouthEast');
set(leg,'Interpreter', 'none');
%set(gca,'XScale','log');
xlabel('time [s]');
ylabel('P_{actuator} [Psi]');
title('Valve Performance Validation 6/4');
set(gca,'FontSize',14);
axis([0.1 1850 0 35]);
