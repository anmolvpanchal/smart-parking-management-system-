clear servo arduinoObj lcd
clc
s=13;  %Number of slots
arduinoObj = arduino('COM4','Uno','Libraries',{'ExampleLCD/LCDAddon','servo','Ultrasonic'});  %Libraries for servo and Lcd included to arduino

Ultrasonic=ultrasonic(arduinoObj,'A3','A2')

lcd = addon(arduinoObj,'ExampleLCD/LCDAddon',{'D7','D6','D5','D4','D3','D2'});  %Lcd object created

initializeLCD(lcd)  %Initializing Lcd

servo=servo(arduinoObj,"D11")  %Servo object created

writePosition(servo,0);  %Servo initial position

writeDigitalPin(arduinoObj,'A5',1);  %Turn on red led

while 1  %Infinity loop created
    
            b=readDigitalPin(arduinoObj,'D12');  %Enter switch created
            
    if s>0  %Check whether the slot is full or empty
        if b==1  % Checked that enter switch is on or not 
           printLCD(lcd,'WELCOME')  %Print welcome
           pause(1);  %Display lcd for 1 second
           clearLCD(lcd);  %Clear lcd
           pause(0.5)  %Delay of 0.5 second
           s=s-1  %Decrease number of slots
           writeDigitalPin(arduinoObj,'A4',1);  %Turn on green light                     
           printLCD(lcd,'Available Slots:');  %Display 'Available Slots'
           printLCD(lcd,num2str(s))  %Display number of slots in count
           writePosition(servo,0.5);  %Rotate the servo at 90 degree upside
           pause(1)  %Delay of 1 second
           writePosition(servo,0);  %Rotate the servo at 90 degree downside
           writeDigitalPin(arduinoObj,'A4',0);  %Turn off green light
           pause(0.5)  %Delay of 0.5 second
        end
    end
    
    if s==0  %Checked whether the number of slot is 0 or not
            writeDigitalPin(arduinoObj,'A5',1);  %Turn on red light
            printLCD(lcd,'Sorry')  %Display 'Sorry'
            printLCD(lcd,'Plz come later')  %Display 'Plz come later
            pause(1)  %Delay of 1 second
    end
    
            d=readDigitalPin(arduinoObj,'D13');  %Exit switch created
    
    if s<13  %To limit the number of parking slots
        if d==1 % Checked that exit switch is on or not
           printLCD(lcd,'THANK YOU ')  %Display 'THANK YOU'
           pause(1);  %Delay of 1 second
           clearLCD(lcd);  %Clear lcd
           s=s+1  %Increase the number of slots
           writeDigitalPin(arduinoObj,'A4',1);  %Turn on green light
           printLCD(lcd,'Available Slots:')  %Display 'Available Slots:'
           printLCD(lcd,num2str(s));  %Display number of slots in count
           writePosition(servo,0.5);  %Rotate the servo at 90 degree upside
           pause(1)  %Delay of 1 second
           writePosition(servo,0);  %Rotate the servo at 90 degree downside
           writeDigitalPin(arduinoObj,'A4',0);  %Turn off green light
           pause(0.5)  %Delay of 0.5 second
        end
    end
end