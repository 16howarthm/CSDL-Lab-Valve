%Valve Plot Generator
% makes matlab figures of all experiments
%experiments based on date and #, see journal for specific data
%also bar plots of average and error time step for opening, closing
%valve for each plot
clear all
close all

numTri = 1;     %number of trials for each experiment
funcNum = 8;    %function number for experiment being run
month = 12;     %month experiment was run in

Pcalib_M = 25.34; %[Psi]     6.89476* if want kPa
Pcalib_b = -13.024;
Qcalib_M = 1000; %100ml/min = 5/3*10^-6 m3/s, 1 m3/s = 10^6 cm3/s 20000/5.05 for larger flowmeter
Qcalib_b = 0;

for day = 1:1       %day
    for expNum = 1:2     %experiment number for each day
        if month < 10
            title = 'ValveArd0';
        else
            title = 'ValveArd';
        end
        if day > 9
            fileN = strcat(title,int2str(month),'-',int2str(day),'-19_',int2str(expNum));
        else
            fileN = strcat(title,int2str(month),'-0',int2str(day),'-19_',int2str(expNum));
        end
        if month < 6
            fileN = strcat(title,int2str(month),'-',int2str(day),'-20_',int2str(expNum));
        else
            fileN = strcat(title,int2str(month),'-0',int2str(day),'-19_',int2str(expNum));
        end
        if exist(fileN,'file') ~= 0
            if fileN == 'ValveArd06-25-19_2'
                numTri = 2;
                funcNum = 0;
            elseif fileN == 'ValveArd07-15-19_1'
                numTri = 1;
                funcNum = 1;
            elseif fileN == 'ValveArd07-16-19_1'
                numTri = 1;
                funcNum = 4;
            elseif fileN == 'ValveArd07-17-19_1'
                numTri = 4;
                funcNum = 4;
            elseif fileN == 'ValveArd07-17-19_2'
                numTri = 1;
                funcNum = 1;
            elseif fileN == 'ValveArd07-17-19_3'
                numTri = 1;
                funcNum = 3;
            elseif fileN == 'ValveArd07-22-19_1'
                numTri = 1;
                funcNum = 1;
            elseif fileN == 'ValveArd07-22-19_2'
                numTri = 1;
                funcNum = 1;
            elseif fileN == 'ValveArd07-22-19_3'
                numTri = 1;
                funcNum = 3;
            elseif fileN == 'ValveArd07-22-19_4'
                numTri = 1;
                funcNum = 3;
            elseif fileN == 'ValveArd07-25-19_1'
                numTri = 3;
                funcNum = 5;
            elseif fileN == 'ValveArd07-25-19_2'
                numTri = 3;
                funcNum = 5;
            elseif fileN == 'ValveArd07-25-19_3'
                numTri = 1;
                funcNum = 3;
            elseif fileN == 'ValveArd07-26-19_1'
                numTri = 3;
                funcNum = 5;
            elseif fileN == 'ValveArd08-01-19_1'
                numTri = 1;
                funcNum = 6;
            elseif fileN == 'ValveArd08-02-19_1'
                numTri = 1;
                funcNum = 7;
            elseif fileN == 'ValveArd08-02-19_2'
                numTri = 1;
                funcNum = 5;
            elseif fileN == 'ValveArd08-02-19_3'
                numTri = 1;
                funcNum = 7;
            elseif fileN == 'ValveArd08-02-19_4'
                numTri = 1;
                funcNum = 7;
            elseif fileN == 'ValveArd08-02-19_5'
                numTri = 1;
                funcNum = 7;
            elseif fileN == 'ValveArd08-07-19_1'
                numTri = 1;
                funcNum = 6;
            elseif fileN == 'ValveArd08-07-19_2'
                numTri = 1;
                funcNum = 6;
            elseif fileN == 'ValveArd08-08-19_1'
                numTri = 1;
                funcNum = 6;
            elseif fileN == 'ValveArd08-08-19_2'
                numTri = 1;
                funcNum = 6;
            elseif fileN == 'ValveArd09-23-19_1'
                numTri = 1;
                funcNum = 6;
            elseif fileN == 'ValveArd09-23-19_2'
                numTri = 1;
                funcNum = 6;
            elseif fileN == 'ValveArd09-23-19_3'
                numTri = 1;
                funcNum = 6;
            elseif fileN == 'ValveArd09-23-19_4'
                numTri = 1;
                funcNum = 6;
            elseif fileN == 'ValveArd09-23-19_5'
                numTri = 1;
                funcNum = 6;
            elseif fileN == 'ValveArd09-23-19_6'
                numTri = 1;
                funcNum = 6;
            else
                numTri = 1;
                funcNum = 8;
            end
            
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
                for expNum = 1:w
                    if i == N
                        New{N,expNum} = Og{expNum}(idx(N)+3:end);
                        New{N,expNum} = str2double(New{N,expNum});
                    else
                        New{i,expNum} = Og{expNum}(idx(i)+3:idx(i+1)-1);
                        New{i,expNum} = str2double(New{i,expNum});
                    end
                end
            end
            
            %% shorten file
            b = 100000000;
            [l,w] = size(New);
            for i = 1:l
                for expNum = 1:w
                    a = max(size(New{i,expNum}));
                    if b > a
                        b = a;
                    end
                end
            end
            for i = 1:l
                for expNum = 1:w
                    New{i,expNum} = New{i,expNum}(1:b,1);
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
                for expNum = 1:9
                    for f = 1:numTri
                        if i == amount && R > 0
                            n = 1;
                            while n <= Rem
                                NewMatrix{i,expNum}(:,n) = New{(i-1)*numTri+n,expNum}(:);
                                n = n +1;
                            end
                        else
                            NewMatrix{i,expNum}(:,f) = New{(i-1)*numTri+f,expNum}(:);
                        end
                    end
                    
                    ValueMatrix{i,expNum} = mean(NewMatrix{i,expNum}(:,:),2);
                    if expNum == 1
                        ValueMatrixE{i,expNum} = 2.*std(NewMatrix{i,expNum}(:,:),0,2);
                    elseif expNum == 2 || expNum==3 || expNum==4 || expNum==5 || expNum==6 || expNum==7
                        ValueMatrixE{i,expNum} = sqrt((2).^2+2.*std(NewMatrix{i,expNum}(:,:),0,2).^2);
                    else
                        ValueMatrixE{i,expNum} = sqrt((17).^2+2.*std(NewMatrix{i,expNum}(:,:),0,2).^2);
                    end
                end
            end
            
            %% Calibrate
            [m,c] = size(ValueMatrix);
            for row = 1:m;
                for i = 2:9;
                    if i == 2 || i == 3 || i == 4 || i == 5 || i == 6 ||i == 7;
                        ValueMatrix{row,i}(:,1) = Pcalib_M*ValueMatrix{row,i}(:,1)+Pcalib_b;
                    elseif i == 8 || i == 9;
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
            
        end
    end
end

clear hit a count CurrentTime startTime time i fid fileID Date P_G1_Plot P_G2_Plot ...
    P_Act_Plot P_H_Plot P_V_Plot Date N1 N2 N3 N4 N5 N6 N7 N8 N9 N10 Names NamesH NamesT NamesV NamesH Trial ...
    l w i j fileID fid P_S_Plot sumMatrix