function [Matrix] = Valve_DaveP
%% setup
a = arduino;
configurePin(a,'D8','DigitalOutput');
configurePin(a,'D9','DigitalOutput');
configurePin(a,'D10','PWM');
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
alpha = 360;

%% load

writeDigitalPin(a,'D8',1);      %open solenoid
writeDigitalPin(a,'D9',0);      %close solenoid
startTime = clock;
while time < alpha+15
    
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
    
    value = 0;
    if rem(time,alpha)<alpha/2   
        value = 5*rem(time,alpha/2)/(alpha/2);      
    else 
        value = 5-5*rem(time,alpha/2)/(alpha/2);
    end 
    
    writePWMVoltage(a,'D10',value);

    count = count+1;
%     if count > alpha*10   %30 sec    %% count 10 = 1 sec if output stable end program
%         if abs((P_G1_M(count-20) - P_G1_M(count - 40))) < 0.2
%             break
%         end
%     end
end 
writeDigitalPin(a,'D8',0);
writeDigitalPin(a,'D9',0);
    PDS1_M = P_D1_M-P_S1_M;
    PDS2_M = P_D2_M-0;
Matrix = [timeM;P_G1_M;P_D1_M;P_S1_M;P_G2_M;P_D2_M;P_Act_M;Q1_M;Q2_M;PDS1_M;PDS2_M];
end 