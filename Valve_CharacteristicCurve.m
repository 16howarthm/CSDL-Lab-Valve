function [Matrix] = Valve_CharacteristicCurve
%% setup
a = arduino;
configurePin(a,'D8','DigitalOutput');  %solenoid 1
configurePin(a,'D9','DigitalOutput');  %solenoid 2 
configurePin(a,'D10','PWM');           %gate pressure regulator
count = 1;
P_G1_M = [];
P_D1_M = [];
P_S1_M = [];
P_G2_M = [];
P_D2_M = [];
P_Act_M = [];
Q1_M = [];
Q2_M = [];
timeM = [];
V_G1_M = [];
V_D1_M = [];
V_S1_M = [];
V_G2_M = [];
V_D2_M = [];
V_Act_M = [];
V_Q1_M = [];
V_Q2_M = [];
time = 0;
alpha = 30;

%% load

writeDigitalPin(a,'D8',1);      %open solenoid  lets air through to close the discrete valve 
writeDigitalPin(a,'D9',0);      %close solenoid
startTime = clock;
while time < alpha+1
    
    V_G1 = readVoltage(a,'A0');
    V_D1 = readVoltage(a,'A1');
    V_S1 = readVoltage(a,'A2');
    V_G2 = readVoltage(a,'A3');
    V_D2 = readVoltage(a,'A4');
    V_Act = readVoltage(a,'A5');
    V_Q1 = readVoltage(a,'A6');
    V_Q2 = readVoltage(a,'A7');
    
    P_G1 = (25.6*V_G1-13);                % +101.325 to go from gauge to abs pressure
    P_D1 = (25.6*V_D1-13);                %6.89476* if want kPa
    P_S1 = (25.6*V_S1-13);
    P_G2 =(25.6*V_G2-13);
    P_D2 = (25.6*V_D2-13);
    P_Act = (25.6*V_Act-13);
    Q1 = 20000/5.05*V_Q1;              %100ml/min = 5/3*10^-6 m3/s, 1 m3/s = 10^6 cm3/s
    Q2 = 20000/5.05*V_Q2;
   
    P_G1_M(count) = P_G1;
    P_D1_M(count) = P_D1;
    P_S1_M(count) = P_S1;
    P_G2_M(count) = P_G2;
    P_D2_M(count) = P_D2;
    P_Act_M(count) = P_Act;
    Q1_M(count) = Q1;
    Q2_M(count) = Q2;
    timeM(count) = time;
    
    CurrentTime = clock;
    time = etime(CurrentTime,startTime);
    
    if time < 30; 
         value = 0;
    elseif time > 30 && time < 60;
        value = 0.5;
    elseif time > 60 && time < 90; 
        value = 1;    
    elseif time > 90 && time < 120; 
        value = 1.5;   
    elseif time > 120 && time < 150; 
        value = 2;   
    else
        value = 2.5;  
    end 
    
    writePWMVoltage(a,'D10',value);
    
    if time > 10+30*(value) && time < 30*(value+1)
        if rem(time,2) < 0.12
            count = count+1;
        end
    end

end
writeDigitalPin(a,'D8',0);
writeDigitalPin(a,'D9',0);
    PDS1_M = P_D1_M-P_S1_M;
    PDS2_M = P_D2_M-0;
Matrix = [timeM;P_G1_M;P_D1_M;P_S1_M;P_G2_M;P_D2_M;P_Act_M;Q1_M;Q2_M;PDS1_M;PDS2_M];    

%average values
sumMatrix = zeros(11,1);
AvgMatrix = zeros(11,value);
Segment = 0;
for i = 0:value
    for b = 1:length(Matrix)
    if Matrix(1,b) > 9.5+30*(i) && Matrix(1,b) < 30*(i+1)
        Segment = Segment+1;
        sumMatrix = Matrix(:,b)+sumMatrix;
    end  
    end
    AvgMatrix(:,i+1) = sumMatrix./Segment;
    sumMatrix = zeros(11,1);
end
Matrix = AvgMatrix;
end 