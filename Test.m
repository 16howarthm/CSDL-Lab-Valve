%test 
close all
clear a
a = arduino;

time = 0;
V_Q1_M = [];
count = 1;

startTime = clock;
while time < 30
V_Q1 = readVoltage(a,'A6');
    V_Q1_M(count) = V_Q1;
    timeM2(count) = time;
    
    CurrentTime = clock;
    time = etime(CurrentTime,startTime);

    count = count+1;
end

Q_Q1_M2 = 1000.*V_Q1_M;
figure();
plot(timeM,Q_Q1_M)
hold on 
yline(2000);
plot(timeM2,Q_Q1_M2)
xlabel("Time"); 
ylabel("Q");
ylim([0 5000]);
legend('FlowRate Sensor new','Manual Flowmeter','FlowRate Sensor original');
title('FlowRate Sensor Check');


