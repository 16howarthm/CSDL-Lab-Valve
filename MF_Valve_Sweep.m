function [Matrix] = Valve_CharacteristicCurve
%% setup

% ARDUINO CONFIGURATION
a = arduino;
configurePin(a,'D8','DigitalOutput');  % solenoid 1
configurePin(a,'D9','DigitalOutput');  % solenoid 2 
configurePin(a,'D10','PWM');           % gate pressure regulator
configurePin(a,'D11','PWM');           % MEMS valve duty cycle control


% SENSORS
% Pressure
P_G1_M = [];
P_D1_M = [];
P_S1_M = [];
P_G2_M = [];
P_D2_M = [];
P_Act_M = [];

% Flow
Q1_M = [];
Q2_M = [];

% DATA
V_G1_M = [];
V_D1_M = [];
V_S1_M = [];
V_G2_M = [];
V_D2_M = [];
V_Act_M = [];
V_Q1_M = [];
V_Q2_M = [];

% TEST RUN TRACKING
timeM = [];
time = 0;                   % initial time
alpha = 80;                % total test length
count = 1;

% INITIALIZATION VALUES
valveDC = 0;                % [percent DC]
regulatedP = 2;           % [Voltage]

writePWMVoltage(a,'D11',valveDC); % start with zero duty cycle
writePWMVoltage(a,'D10',regulatedP); % start with zero input pressure

%% load

writeDigitalPin(a,'D8',1);      %open solenoid  lets air through to close the discrete valve 
writeDigitalPin(a,'D9',0);      %close solenoid
startTime = clock;

while time < alpha + 1            % main test loop
    
    V_G1 = readVoltage(a,'A0');
    V_D1 = readVoltage(a,'A1');
    V_S1 = readVoltage(a,'A2');
    V_G2 = readVoltage(a,'A3');
    V_D2 = readVoltage(a,'A4');
    V_Act = readVoltage(a,'A5');
    V_Q1 = readVoltage(a,'A6');
    V_Q2 = readVoltage(a,'A7');
    
    P_G1 = (25.6*V_G1-13);        % +101.325 to go from gauge to abs pressure
    P_D1 = (25.6*V_D1-13);        % 6.89476* if want kPa
    P_S1 = (25.6*V_S1-13);
    P_G2 =(25.6*V_G2-13);
    P_D2 = (25.6*V_D2-13);
    P_Act = (25.6*V_Act-13);
    Q1 = 1000*V_Q1;               % 100ml/min = 5/3*10^-6 m3/s, 1 m3/s = 10^6 cm3/s
    Q2 = 1000*V_Q2;               % 20000/5.05* for larger flowmeter
   
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
    
    if time < 10 
        valveDC = 10;
        value_count = 0;
    elseif time > 10 && time < 20
        valveDC = 90;
        value_count = 1;
    elseif time > 20 && time < 30
        valveDC = 10;
        value_count = 2;
    elseif time > 30 && time < 40
        valveDC = 90;
        value_count = 3;
    elseif time > 40 && time < 50
        valveDC = 10;
        value_count = 4;
    elseif time > 50 && time < 60
        valveDC = 90;
        value_count = 5;
    elseif time > 60 && time < 70
        valveDC = 10;
        value_count = 6;
    elseif time > 70 && time < 80
        valveDC = 90;
        value_count = 7;
    else
        valveDC = 20;
        value_count = 8;
    end 
    
    writePWMVoltage(a,'D10',regulatedP); % set regulator pressure
    valveDC = valveDC/20;                % convert DC percent to voltage 
    writePWMVoltage(a,'D11',valveDC);    % set duty cycle percent
    
    if time > 15+10*(value_count) && time < 10*(value_count+1)
        if rem(time,2) < 0.12
            count = count + 1;
        end
    end

end
writeDigitalPin(a,'D8',0);
writeDigitalPin(a,'D9',0);
    PDS1_M = P_D1_M-P_S1_M;
    PDS2_M = P_D2_M-0;
Matrix = [timeM;P_G1_M;P_D1_M;P_S1_M;P_G2_M;P_D2_M;P_Act_M;Q1_M;Q2_M;PDS1_M;PDS2_M];    
Matrix2 = Matrix; 

% average values
sumMatrix = zeros(11,1);
AvgMatrix = zeros(11,value_count+1);
Segment = 0;

for i = 0:4
    for b = 1:length(Matrix)
    if Matrix(1,b) > 14.5+10*(i) && Matrix(1,b) < 10*(i+1)
        sumMatrix = Matrix(:,b)+sumMatrix;
        Segment = Segment+1;
    end  
    end
    AvgMatrix(:,i+1) = sumMatrix./Segment;
    Segment = 0;
    sumMatrix = zeros(11,1);
end

Matrix = AvgMatrix; 
end 