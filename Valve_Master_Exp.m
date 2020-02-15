%ValveMaster Experiment
clear all
close all

%% setup

%Calibration values
Pcalib_M = 25.34; %[Psi]     6.89476* if want kPa 
Pcalib_b = -13.024;
Qcalib_M = 1000; %100ml/min = 5/3*10^-6 m3/s, 1 m3/s = 10^6 cm3/s 20000/5.05 for larger flowmeter
Qcalib_b = 0;

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

%imports to text file
Date = datestr(now,'mm dd yy HH:MM:SS');
DateDay = datestr(now,'mm-dd-yy');
fileN = strcat('ValveArd',DateDay,'_',int2str(expNum));
fileID = fopen(fileN,'a');
fprintf(fileID,'%s %s %s %s %s %s %s %s %s\n','time[sec]','V_G1 [V]','V_D1 [V]','V_S1 [V]','V_G2 [V]','V_D2 [V]','V_Act [V]','Q1 [ml/min]','Q2 [ml/min]');
fprintf(fileID,'%s\n',Date);     %trial header
fprintf(fileID,'%4.4f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f\n',Matrix);  %values
fclose(fileID);

%% separate text file
fid = fopen(fileN,'r');
Og = textscan(fid,'%s %s %s %s %s %s %s %s %s');
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
    for j = 1:9
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
        elseif j == 2 || j==3 || j==4 || j==5 || j==6 || j==7
            ValueMatrixE{i,j} = sqrt((2).^2+2.*std(NewMatrix{i,j}(:,:),0,2).^2);
        else
            ValueMatrixE{i,j} = sqrt((17).^2+2.*std(NewMatrix{i,j}(:,:),0,2).^2);
        end
    end
end

%% Calibrate
[m,c] = size(ValueMatrix);
for row = 1:m
    for i = 2:9
        if i == 2 || i == 3 || i == 4 || i == 5 || i == 6 ||i == 7
            ValueMatrix{row,i}(:,1) = Pcalib_M*ValueMatrix{row,i}(:,1)+Pcalib_b;
        elseif i == 8 || i == 9
            ValueMatrix{row,i}(:,1) = Qcalib_M*ValueMatrix{row,i}(:,1)+Qcalib_b;
        end
    end
end
%% average end values for characteristic curve function
if funcNum == 8
    Matrix2 = ValueMatrix;
    sumMatrix = {};
    value_count = ceil(ValueMatrix{1,1}(end,1)/30);
    AvgMatrix = {};
    row_count = 1;
    
    for r = 1:m
        for i = 0:value_count-1
            for b = 1:length(Matrix2{1,1})
                if Matrix2{r,1}(b,1) > 14.5+30*(i) && Matrix2{r,1}(b,1) < 30*(i+1)
                    for col = 1:c
                        sumMatrix{r,col}(row_count,1) = Matrix2{r,col}(b,1);
                    end
                    row_count = row_count+1;
                end
            end
            for col = 1:c
                AvgMatrix{r,col}(i+1,1) = sum(sumMatrix{r,col})./length(sumMatrix{r,col});
            end
            row_count = 1;
        end
    end
    ValueMatrix = AvgMatrix;
end

%% Plot
Valve_Plot(ValueMatrix,ValueMatrixE,funcNum,fileN);

clear hit a count CurrentTime startTime time i fid fileID Date P_G1_Plot P_G2_Plot ...
    P_Act_Plot P_H_Plot P_V_Plot Date N1 N2 N3 N4 N5 N6 N7 N8 N9 N10 Names NamesH NamesT NamesV NamesH Trial ...
    l w i j fileID fid P_S_Plot
