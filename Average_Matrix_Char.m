Matrix2 = Matrix; 
%average values
sumMatrix = zeros(11,1);
AvgMatrix = zeros(11,5);
Segment = 0;
for i = 0:4
    for b = 1:length(Matrix)
    if Matrix(1,b) > 14.5+30*(i) && Matrix(1,b) < 30*(i+1)
        sumMatrix = Matrix(:,b)+sumMatrix;
        Segment = Segment+1;
    end  
    end
    AvgMatrix(:,i+1) = sumMatrix./Segment;
    Segment = 0;
    sumMatrix = zeros(11,1);
end
Matrix = AvgMatrix; 