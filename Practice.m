%practice deleting trailing zeros
%makes initial and final portions of data NaN 
clear all 
close all 


Exp1 = csvread('Valves_Data.csv');
[a,b] = size(Exp1);


% replace trailing zeros with NaN
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
    C{1,i}(1:100,1) = NaN;
end 

clear Cell a b i j 
