function [Matrix] = Valve_CharacteristicCurve
%% setup
a = arduino;
configurePin(a,'D8','DigitalOutput');  %solenoid 1
configurePin(a,'D9','DigitalOutput');  %solenoid 2 
configurePin(a,'D10','PWM');           %gate pressure regulator
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
Pstep = 5;    % 0.2 -> 5psi
Pmax = 40;
i = 0;
alpha = Pmax/Pstep*30;

%% load

writeDigitalPin(a,'D8',1);      %open solenoid  lets air through to close the discrete valve 
writeDigitalPin(a,'D9',0);      %close solenoid
startTime = clock;
while time < alpha+2
    
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
    
    if time > 30*i && time < 30*(i+1); 
        value = Pstep./25.*i;
        value_count = i; 
    else 
        i = i+1;
    end 
    writePWMVoltage(a,'D10',value);
    
%     if time > 14.5+30*(value_count) && time < 30*(value_count+1)
%         if rem(time,2) < 0.12
%             count = count+1;
%         end
%     end
    count = count+1;
end
writeDigitalPin(a,'D8',0);
writeDigitalPin(a,'D9',0);
Matrix = [timeM;V_G1_M;V_D1_M;V_S1_M;V_G2_M;V_D2_M;V_Act_M;V_Q1_M;V_Q2_M];
end 