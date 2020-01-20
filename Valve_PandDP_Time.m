function [Matrix] = Valve_PandDP_Time
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

% writeDigitalPin(a,'D8',0);
% writeDigitalPin(a,'D9',0); 
% pause(1);

%% load

%   writeDigitalPin(a,'D8',1);      %open solenoid
%     writeDigitalPin(a,'D9',1);      %open solenoid
% %  pause(1);
        
startTime = clock;
while time < 120
    
    V_G1 = readVoltage(a,'A0');
    V_D1 = readVoltage(a,'A1');
    V_S1 = readVoltage(a,'A2');
    V_G2 = readVoltage(a,'A3');
    V_D2 = readVoltage(a,'A4');
    V_Act = readVoltage(a,'A5');
    V_Q1 = readVoltage(a,'A6');
    V_Q2 = readVoltage(a,'A7');
    
        V_G1_M(count) = V_G1;
    V_D1_M(count) = V_D1;
    V_S1_M(count) = V_S1;
    V_G2_M(count) = V_G2;
    V_D2_M(count) = V_D2;
    V_Act_M(count) = V_Act;
    V_Q1_M(count) = V_Q1;
    V_Q2_M(count) = V_Q2;
        timeM(count) = time;
    
    CurrentTime = clock;
    time = etime(CurrentTime,startTime);
    
    if time  < 30.0
        writeDigitalPin(a,'D8',1);      %open solenoid
        writeDigitalPin(a,'D9',1);      %open solenoid  
    elseif time > 30.0 && time < 60.0
        writeDigitalPin(a,'D8',0);      %close solenoid
        writeDigitalPin(a,'D9',1);      %open solenoid
    else
        writeDigitalPin(a,'D8',1);
        writeDigitalPin(a,'D9',0);
    end
    
    count = count+1;
    if count > 700   %70 sec    %% count 10 = 1 sec if output stable end program
        if abs((V_Act_M(count-20) - V_Act_M(count - 40))) < 0.2
            break
        end
    end
end
Matrix = [timeM;V_G1_M;V_D1_M;V_S1_M;V_G2_M;V_D2_M;V_Act_M;V_Q1_M;V_Q2_M];
end