%Valve Plot Generator
% makes matlab figures of all experiments
%experiments based on date and #, see journal for specific data
%also bar plots of average and error time step for opening, closing
%valve for each plot
clear all
close all
numTri = 3;
funcNum = 0;
month = 9;

for g = 29:29        %day
    for j = 1:6     %experiment number
        if g > 9
            fileN = strcat('ValveArd0',int2str(month),'-',int2str(g),'-19_',int2str(j));
        else
            fileN = strcat('ValveArd0',int2str(month),'-0',int2str(g),'-19_',int2str(j));
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
           elseif fileN == 'ValveArd09-25-19_1'
                numTri = 1;
                funcNum = 8;
           elseif fileN == 'ValveArd09-29-19_1'
                numTri = 1;
                funcNum = 8; 
            elseif fileN == 'ValveArd09-29-19_2'
                numTri = 1;
                funcNum = 8;  
            else
                numTri = 1;
                funcNum = 6;
            end
            
            fid = fopen(fileN,'r');
            Og = textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s');
            [l,w] = size(Og);
            fclose(fid);
            idx = find(contains(Og{1},'time'));
            N = length(idx);
            New = cell(N,w);
            % find header location
            for x = 1:N
                for y = 1:w
                    if x == N
                        New{N,y} = Og{y}(idx(N)+3:end);
                        New{N,y} = str2double(New{N,y});
                    else
                        New{x,y} = Og{y}(idx(x)+3:idx(x+1)-1);
                        New{x,y} = str2double(New{x,y});
                    end
                end
            end
            
            %% shorten file
            b = 100000000;
            [l,w] = size(New);
            for i = 1:l
                for z = 1:w
                    a = max(size(New{i,z}));
                    if b > a
                        b = a;
                    end
                end
            end
            for i = 1:l
                for z = 1:w
                    New{i,z} = New{i,z}(1:b,1);
                end
            end
            
            %% numTri
            NewMatrix = {};
            ValueMatrix = {};
            ValueMatrixE = {};
            [Q,R] = quorem(sym(N),sym(numTri));
            Q = sym2poly(Q);
            R = sym2poly(R);
            amount = ceil(N/numTri);
            Rem = R;
            
            for i= 1:amount
                for z = 1:11
                    for f = 1:numTri
                        if i == amount && R > 0
                            n = 1;
                            while n <= Rem
                                NewMatrix{i,z}(:,n) = New{(i-1)*numTri+n,z}(:);
                                n = n +1;
                            end
                        else
                            NewMatrix{i,z}(:,f) = New{(i-1)*numTri+f,z}(:);
                        end
                    end
                    ValueMatrix{i,z} = mean(NewMatrix{i,z}(:,:),2);
                    
                    if z == 1
                        ValueMatrixE{i,z} = 2.*std(NewMatrix{i,z}(:,:),0,2);
                    elseif z == 2 || z==3 || z==4 || z==5 || z==6 || z==7 || z ==10 || z ==11
                        ValueMatrixE{i,z} = sqrt((2).^2+2.*std(NewMatrix{i,z}(:,:),0,2).^2);
                    else
                        ValueMatrixE{i,z} = sqrt((17).^2+2.*std(NewMatrix{i,z}(:,:),0,2).^2);
                    end
                end
            end
            
            Valve_Plot(ValueMatrix,ValueMatrixE,funcNum,fileN);

        end
    end
end

clear hit a count CurrentTime startTime time i fid fileID ans Date P_G1_Plot P_G2_Plot ...
    P_Act_Plot P_H_Plot P_V_Plot Date N1 N2 N3 N4 N5 N6 N7 N8 N9 N10 Names NamesH NamesT NamesV NamesH Trial ...
    l w i j fileID fid P_S_Plot