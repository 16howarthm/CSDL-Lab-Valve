%ValveCalib
clear all
close all
Pcalib_M = 25.501; %[Psi]     
Pcalib_b = -13.777;
%write down pressure at time 0-10 and time  20-30

a = arduino;
configurePin(a,'D8','DigitalOutput');
configurePin(a,'D9','DigitalOutput');
configurePin(a,'D10','PWM');
startTime = clock;
time = 0;
count = 1;

writeDigitalPin(a,'D8',0);      %close solenoid
writeDigitalPin(a,'D9',0);      %close solenoid
pause(1);
writeDigitalPin(a,'D8',1);      %open solenoid
writeDigitalPin(a,'D9',0);      %close solenoid
writePWMVoltage(a,'D10',5);
pause(5)

while time < 30
    %mean(V_G1[100:end])
    %  writeDigitalPin(a,'D9',1);      %open solenoid
    % writeDigitalPin(a,'D8',1);      %open solenoid
    %         writeDigitalPin(a,'D9',0);      %open solenoid
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
    
    
    
    CurrentTime = clock;
    time = etime(CurrentTime,startTime);
    timeM(count) = time;
    
    %     PDS1_M = P_D1_M-P_S1_M;
    %     PDS2_M = P_D2_M-0;
    %     if rem(time,30)<15
    %         value = 5*rem(time,15)/15;
    %
    %     else
    %          value = 5-5*rem(time,15)/15;
    %     end
    % if time < 15
    %       writePWMVoltage(a,'D10',1);
    % else
    %          writePWMVoltage(a,'D10',5);
    % end
    
    %
    %     %% live graph
    %     hold on
    %     plot(timeM,P_G1_M);
    % %     plot(timeM,P_D1_M);
    % %     plot(timeM,P_S1_M);
    %     hold off
    %     grid on;
    %     drawnow;
    %     leg = legend('P_Q1');
    %     xlabel('Time [s]');
    %     ylabel('Q [m^3/s]');
    %     title('Valve Master Experiment LiveFeed');
    %     set(gca,'FontSize',14);
    %
    %
    count = count+1;
end

P_G1_M = (Pcalib_M.*V_G1_M+Pcalib_b);                % +101.325 to go from gauge to abs pressure
P_D1_M = (Pcalib_M.*V_D1_M+Pcalib_b);                %6.89476* if want kPa
P_S1_M = (Pcalib_M.*V_S1_M+Pcalib_b);
P_G2_M =(Pcalib_M.*V_G2_M+Pcalib_b);
P_D2_M = (Pcalib_M.*V_D2_M+Pcalib_b);
P_Act_M = (Pcalib_M.*V_Act_M+Pcalib_b);
Q1_M = 1000.*V_Q1_M;              %100ml/min = 5/3*10^-6 m3/s, 1 m3/s = 10^6 cm3/s
Q2_M = 1000.*V_Q2_M;

 clear V_G1 V_D1 V_S1 V_G2 V_D2 V_Act V_Q1 V_Q2 time...
     ...
     P_Act P_D1 P_D2 P_S2 P_S1 P_G1 P_G2 Q1 Q2
writeDigitalPin(a,'D8',0);      %open solenoid
writeDigitalPin(a,'D9',0);      %open solenoid
