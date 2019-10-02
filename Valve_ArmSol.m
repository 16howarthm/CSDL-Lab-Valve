%Valve_ArmSol

%% setup
clear all 
close all

a = arduino;
configurePin(a,'D2','DigitalOutput');
configurePin(a,'D3','DigitalOutput');
configurePin(a,'D4','DigitalOutput');
configurePin(a,'D5','DigitalOutput');
configurePin(a,'D6','DigitalOutput');
configurePin(a,'D7','DigitalOutput');
configurePin(a,'D8','DigitalOutput');
configurePin(a,'D9','DigitalOutput');
configurePin(a,'D10','DigitalOutput');
configurePin(a,'D11','DigitalOutput');
configurePin(a,'D12','DigitalOutput');
configurePin(a,'D13','DigitalOutput');

writeDigitalPin(a,'D2',);      %1 open solenoid, 0 close solenoid
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',1);
writeDigitalPin(a,'D6',1);
writeDigitalPin(a,'D7',1);
writeDigitalPin(a,'D8',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',1);
writeDigitalPin(a,'D12',1);
writeDigitalPin(a,'D13',1);
pause(1);