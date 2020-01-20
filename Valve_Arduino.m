%ValveArduino
clear all 
close all 

%% can change 
    numTri = 3;
    expNum = 1;

%% setup
a = arduino; 
configurePin(a,'D8','DigitalOutput');
count = 1;
PinM = [];
PoutM = [];
timeM = [];
VinM = [];
VoutM = [];
time = 0;

writeDigitalPin(a,'D8',0);
%% load
startTime = clock;
while time < 120

Vin = readVoltage(a,'A0'); 
Vout = readVoltage(a,'A1');
Pin = (Vin-0.478)./0.0379;             %0.037207304x-3.773052632
Pout = (Vout-0.478)./0.0379; 

CurrentTime = clock;
time = etime(CurrentTime,startTime);

if time  > 30.0
    writeDigitalPin(a,'D8',0);      %close solenoid
else 
    writeDigitalPin(a,'D8',1);      %open solenoid
end

PinM(count) = Pin; 
PoutM(count) = Pout;
timeM(count) = time;
VoutM(count) = Vout; 
VinM(count) = Vin; 

count = count+1;

        if count > 1200     %%1000 = 20 sec if output stable end program, will have to change when 2 valves
            if (PoutM(count-200) - PoutM(count - 400)) < 0.2
                break 
            end 
        end 
%end 
end

Matrix = [timeM;PinM;PoutM];
Date = datestr(now,'mm dd yy HH:MM:SS');       %imports to text file
DateDay = datestr(now,'mm-dd-yy');
DateDay = datestr('06 25 19','mm-dd-yy'); 
fileID = fopen(strcat('ValveArd ',DateDay,'_',int2str(expNum)),'a');
fprintf(fileID,'%s %s %s\n','time[sec]','Pin[KPa]','Pout[KPa]');
fprintf(fileID,'%s\n',Date);     %trial header
fprintf(fileID,'%4.4f %4.2f %4.2f\n',Matrix);  %values
fclose(fileID);

%% separate text file
fid = fopen(strcat('ValveArd',DateDay,'_',int2str(expNum)),'r');
Og = textscan(fid,'%s %s %s %s');
[l,w] = size(Og);
fclose(fid); 
idx = find(contains(Og{1},'time'));
N = length(idx);
New = cell(N,w);
% find header location 
for i = 1:N    
for j = 1:w   
    if i == N   
    New{N,j} = Og{j}(idx(N)+2:end);
    New{N,j} = str2double(New{N,j});
    else 
    New{i,j} = Og{j}(idx(i)+2:idx(i+1)-1);
    New{i,j} = str2double(New{i,j});
    end
end
end 

%New{:,1} time New{:,2} Pin  New{:,3} Pout 

%% Names
NameRow = {};
Names = {};
for i = 1:N
        N1 = strcat('Pin_',int2str(i));
        N2 = strcat('Pout_',int2str(i));
    Names = [Names,N1,N2];
end

%% plot
figure();
hold on 
for i=1:N
    PinPlot = plot(New{i,1}(:,1),smooth(New{i,2}(:,1)),'--');           %Pin versus time
    PoutPlot = plot(New{i,1}(:,1),smooth(New{i,3}(:,1)));           %Pout versus time
    
    if i <= numTri
        set(PoutPlot,'Color',[1 0 0]);
        set(PinPlot,'Color',[1 0 0]); 
    elseif i <= numTri*2 && i > numTri
        set(PoutPlot,'Color',[0 1 0]);
        set(PinPlot,'Color',[0 1 0]); 
    elseif i <= numTri*3 && i > numTri*2
         set(PoutPlot,'Color',[0 0 1]);
        set(PinPlot,'Color',[0 0 1]);     
    elseif i <= numTri*4 && i > numTri*3
          set(PoutPlot,'Color',[1 0 1]);
        set(PinPlot,'Color',[1 0 1]);         
    elseif i <= numTri*5 && i > numTri*4
        set(PoutPlot,'Color',[1 1 0]);
        set(PinPlot,'Color',[1 1 0]); 
    elseif i <= numTri*6 && i > numTri*5
        set(PoutPlot,'Color',[0 1 1]);
        set(PinPlot,'Color',[0 1 1]); 
    elseif i <= numTri*7 && i > numTri*6
          set(PoutPlot,'Color',[0 0 0]);
        set(PinPlot,'Color',[0 0 0]);    
    elseif i <= numTri*8 && i > numTri*7
          set(PoutPlot,'Color',[0.5 0.5 0]);
        set(PinPlot,'Color',[0.5 0.5 0]);         
    elseif i <= numTri*9 && i > numTri*8
          set(PoutPlot,'Color',[0.5 0.1 0.5]);
        set(PinPlot,'Color',[0.5 0.1 0.5]);   
    else
          set(PoutPlot,'Color',[0.1 0.5 0.1]);
        set(PinPlot,'Color',[0.1 0.5 0.1]);   
    end 
end 

hold off
leg = legend(Names,'Location','SouthEast'); 
set(leg,'Interpreter', 'none');
xlabel('Time [s]');
ylabel('Pressure [KPa]');
title('Valve Arduino'); 
set(gca,'FontSize',14);

clear hit a count CurrentTime startTime time Pin Pout N i fid fileID ans Date
