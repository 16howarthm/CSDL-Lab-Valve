function [Matrix] = Valve_Varying_Control_Pressure
%% setup
a = arduino;
configurePin(a,'D8','DigitalOutput');
configurePin(a,'D9','DigitalOutput');
count = 1;
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

%% load
writeDigitalPin(a,'D8',1);      %open solenoid
writeDigitalPin(a,'D9',0);      %close solenoid
pause(1);
startTime = clock;
while time < 340
    
   V_G1 = readVoltage(a,'A0');
    V_D1 = readVoltage(a,'A1');
    V_S1 = readVoltage(a,'A2');
    V_G2 = readVoltage(a,'A3');
    V_D2 = readVoltage(a,'A4');
    V_Act = readVoltage(a,'A5');
    V_Q1 = readVoltage(a,'A6');
    V_Q2 = readVoltage(a,'A7');  
  
  
    CurrentTime = clock;
    time = etime(CurrentTime,startTime);

    if rem(time,30) < 0.2
    V_G1_M(count) = V_G1;
    V_D1_M(count) = V_D1;
    V_S1_M(count) = V_S1;
    V_G2_M(count) = V_G2;
    V_D2_M(count) = V_D2;
    V_Act_M(count) = V_Act;
    V_Q1_M(count) = V_Q1;
    V_Q2_M(count) = V_Q2;
        timeM(count) = time;
        count = count+1;
    end
end
Matrix = [timeM;V_G1_M;V_D1_M;V_S1_M;V_G2_M;V_D2_M;V_Act_M;V_Q1_M;V_Q2_M];

writeDigitalPin(a,'D8',0);      %close solenoid
writeDigitalPin(a,'D9',0);      %close solenoid
end