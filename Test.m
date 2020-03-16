%test 
% close all
% clear a
% 
% %Setup
% a = arduino;
% configurePin(a,'D8','DigitalOutput');  %solenoid 1
% configurePin(a,'D9','DigitalOutput');  %solenoid 2 
% configurePin(a,'D10','PWM');           %gate pressure regulator
% 
% writeDigitalPin(a,'D8',1); 
% writePWMVoltage(a,'D10',0);
% 
% time = 0;
% Q_Q1_M = [];
% count = 1;
% 
% startTime = clock;
% while time < 30
%     V_G1 = readVoltage(a,'A0');
% V_Q1 = readVoltage(a,'A6');
% V_D1 = readVoltage(a,'A1');
% 
%     Q_Q1_M4(count) = V_Q1.*1000; %Change
%      P_G1_M4(count) = 25.34.*V_G1-13.024; %Change
%       P_D1_M4(count) = 25.34.*V_D1-13.024; %Change
%     timeM4(count) = time; %Change
%     
%     CurrentTime = clock;
%     time = etime(CurrentTime,startTime);
% 
%     if time > 15
%             writePWMVoltage(a,'D10',5);
%     end 
%     
%     count = count+1;
% end
% writeDigitalPin(a,'D8',1); 
% writePWMVoltage(a,'D10',0);

%Plot
figure();
plot(timeM1,Q_Q1_M1)
hold on 
plot(timeM2,Q_Q1_M2)
plot(timeM3,Q_Q1_M3)
plot(timeM4,Q_Q1_M4)
xlabel("Time"); 
ylabel("Q");
ylim([0 2000]);
xlim([0 30]);
legend('Max Al 0.03','Viv Al 0.01','Viv Al 0.02','Viv Al 0.03');
title('Valve Gate Check Flow');

figure();
plot(timeM1,P_G1_M1,'--r')
hold on 
plot(timeM1,P_D1_M1,'r')
plot(timeM2,P_G1_M2,'--b')
plot(timeM2,P_D1_M2,'b')
plot(timeM3,P_G1_M3,'--c')
plot(timeM3,P_D1_M3,'c')
plot(timeM4,P_G1_M4,'--k')
plot(timeM4,P_D1_M4,'k')
xlabel("Time"); 
ylabel("Q");
ylim([0 40]);
xlim([0 30]);
legend('Max Al 0.03 Pg','Max Al 0.03 Pd','Viv Al 0.01 Pg','Viv Al 0.01 Pd','Viv Al 0.02 Pg','Viv Al 0.02 Pd','Viv Al 0.03 Pg','Viv Al 0.03 Pd');
title('Valve Gate Check Pressure');


