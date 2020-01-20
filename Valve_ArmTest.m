%% setup
clear all 
close all

a = arduino('/dev/cu.usbmodem14201','Uno');
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

%% load
%deflate all frees
writeDigitalPin(a,'D2',0);      %1 open solenoid, 0 close solenoid
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

%inflate all frees 
writeDigitalPin(a,'D2',1);      %1 open solenoid, 0 close solenoid
writeDigitalPin(a,'D3',1);
writeDigitalPin(a,'D4',1);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D7',0);
writeDigitalPin(a,'D8',1);
writeDigitalPin(a,'D9',1);
writeDigitalPin(a,'D10',1);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);
writeDigitalPin(a,'D13',0);
pause(20);

%deflate all frees
writeDigitalPin(a,'D2',0);      %1 open solenoid, 0 close solenoid
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

%inflate frees 1 by 1 
writeDigitalPin(a,'D2',1);      
writeDigitalPin(a,'D3',1);
writeDigitalPin(a,'D4',1);
writeDigitalPin(a,'D8',1);
writeDigitalPin(a,'D9',1);
writeDigitalPin(a,'D10',1);
pause(1);

writeDigitalPin(a,'D5',0);
pause(2);
writeDigitalPin(a,'D6',0);
pause(2);
writeDigitalPin(a,'D7',0);
pause(2);
writeDigitalPin(a,'D11',0);
pause(2);
writeDigitalPin(a,'D12',0);
pause(2);
writeDigitalPin(a,'D13',0);
pause(5);

%deflate all frees 1 by 1
writeDigitalPin(a,'D5',1);      
writeDigitalPin(a,'D6',1);
writeDigitalPin(a,'D7',1);
writeDigitalPin(a,'D11',1);
writeDigitalPin(a,'D12',1);
writeDigitalPin(a,'D13',1);
pause(1);

writeDigitalPin(a,'D2',0);
pause(2);
writeDigitalPin(a,'D3',0);
pause(2);
writeDigitalPin(a,'D4',0);
pause(2);
writeDigitalPin(a,'D8',0);
pause(2);
writeDigitalPin(a,'D9',0);
pause(2);
writeDigitalPin(a,'D10',0);
pause(5);

%close all solenoids
writeDigitalPin(a,'D2',0);      %1 open solenoid, 0 close solenoid
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D7',0);
writeDigitalPin(a,'D8',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);
writeDigitalPin(a,'D13',0);