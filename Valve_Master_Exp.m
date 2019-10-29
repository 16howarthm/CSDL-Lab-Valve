%ValveMaster Experiment
clear all
close all

%% setup
numTri = 1;        %number of trials for each experiment
expNum = 1;   %experiment number for each day
funcNum = 8;   %function number for experiment being run
%Valve_Varying_Control_Pressure() and plot_VCP() = 1
%Valve_Varying_Control_Pressure2() and plot_VCP2() = 2;
%Valve_Hysteresis() and plot_H() = 3;
%Valve_PandDP_Time() and plot_PDP() = 4;
%Valve_Solenoid_Step() = 5;
%Valve_DaveP() = 6;
%Valve_DaveDP() = 7;
%Valve_CharacteristicCurve() = 8;

%% load
Matrix = [];
if funcNum == 1
    Matrix = Valve_Varying_Control_Pressure();
elseif funcNum == 3
    Matrix = Valve_Hysteresis();
elseif funcNum == 4
    Matrix = Valve_PandDP_Time();
elseif funcNum == 5
    Matrix = Valve_Solenoid_Step();
elseif funcNum == 6
    Matrix = Valve_DaveP();
elseif funcNum == 7
    Matrix = Valve_DaveDP();
elseif funcNum == 8
    Matrix = Valve_CharacteristicCurve();
else
    Matrix = Valve_Varying_Control_Pressure2();
end

Date = datestr(now,'mm dd yy HH:MM:SS');       %imports to text file
DateDay = datestr(now,'mm-dd-yy');
fileN = strcat('ValveArd',DateDay,'_',int2str(expNum));
fileID = fopen(fileN,'a');
fprintf(fileID,'%s %s %s %s %s %s %s %s %s %s %s\n','time[sec]','P_G1 [Psi]','P_D1 [Psi]','P_S1 [Psi]','P_G2 [Psi]','P_D2 [Psi]','P_Act [Psi]','Q1 [ml/min]','Q2 [ml/min]','P_DS1 [Psi]','P_DS2 [Psi]');
fprintf(fileID,'%s\n',Date);     %trial header
fprintf(fileID,'%4.4f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f\n',Matrix);  %values
fclose(fileID);

%% separate text file
fid = fopen(fileN,'r');
Og = textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s');
[l,w] = size(Og);
fclose(fid);
idx = find(contains(Og{1},'time'));
N = length(idx);
New = cell(N,w);
% find header location
for i = 1:N
    for j = 1:w
        if i == N
            New{N,j} = Og{j}(idx(N)+3:end);
            New{N,j} = str2double(New{N,j});
        else
            New{i,j} = Og{j}(idx(i)+3:idx(i+1)-1);
            New{i,j} = str2double(New{i,j});
        end
    end
end

%% shorten file
b = 100000000;
[l,w] = size(New);
for i = 1:l
    for j = 1:w
        a = max(size(New{i,j}));
        if b > a
            b = a;
        end
    end
end
for i = 1:l
    for j = 1:w
        New{i,j} = New{i,j}(1:b,1);
    end
end

%% average and error
NewMatrix = {};
ValueMatrix = {};
ValueMatrixE = {};
[Q,R] = quorem(sym(N),sym(numTri));
Q = sym2poly(Q);
R = sym2poly(R);
amount = ceil(N/numTri);
Rem = R;


for i= 1:amount
    for j = 1:11
        for f = 1:numTri
            if i == amount && R > 0
                n = 1;
                while n <= Rem
                    NewMatrix{i,j}(:,n) = New{(i-1)*numTri+n,j}(:);
                    n = n +1;
                end
            else
                NewMatrix{i,j}(:,f) = New{(i-1)*numTri+f,j}(:);
            end
        end
        
        ValueMatrix{i,j} = mean(NewMatrix{i,j}(:,:),2);
        if j == 1
            ValueMatrixE{i,j} = 2.*std(NewMatrix{i,j}(:,:),0,2);
        elseif j == 2 || j==3 || j==4 || j==5 || j==6 || j==7 || j ==10 || j ==11
            ValueMatrixE{i,j} = sqrt((2).^2+2.*std(NewMatrix{i,j}(:,:),0,2).^2);
        else
            ValueMatrixE{i,j} = sqrt((17).^2+2.*std(NewMatrix{i,j}(:,:),0,2).^2);
        end
    end
end

Valve_Plot(ValueMatrix,ValueMatrixE,funcNum,fileN);

clear hit a count CurrentTime startTime time i fid fileID ans Date P_G1_Plot P_G2_Plot ...
    P_Act_Plot P_H_Plot P_V_Plot Date N1 N2 N3 N4 N5 N6 N7 N8 N9 N10 Names NamesH NamesT NamesV NamesH Trial ...
    l w i j fileID fid P_S_Plot
