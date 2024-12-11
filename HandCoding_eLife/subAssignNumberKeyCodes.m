function [NumberKeyCodes]=subAssignNumberKeyCodes(PCMac);

% keep commented in only to find out number key codes, and then comment out
% to run sc1ript
% while(1)
%     [keyIsDown,secs,keyCode]=KbCheck;
%     if keyIsDown==1
%         which=find(keyCode(:)==1)
%         
% end
% end

if PCMac==1      
    %     digits 1 to 8
    NumberKeyCodes(1)=49;
    NumberKeyCodes(2)=50;
    NumberKeyCodes(3)=51;
    NumberKeyCodes(4)=52;
    NumberKeyCodes(5)=53;
    NumberKeyCodes(6)=54;
    NumberKeyCodes(7)=55;
    NumberKeyCodes(8)=56;
    NumberKeyCodes(9)=57;
    NumberKeyCodes(9)=58;
    % back 5 - m
    NumberKeyCodes(20)=77;
    % back 1 - <
    NumberKeyCodes(21)=188;
    % forward 1 - >
    NumberKeyCodes(22)=190;
    % forward 5 - /
    NumberKeyCodes(23)=191;
    
elseif PCMac==2;
    %     digits 1 to 8
    NumberKeyCodes(1)=30;
    NumberKeyCodes(2)=31;
    NumberKeyCodes(3)=32;
    NumberKeyCodes(4)=33;
    NumberKeyCodes(5)=34;
    NumberKeyCodes(6)=35;
    NumberKeyCodes(7)=36;
    NumberKeyCodes(8)=37;
    NumberKeyCodes(9)=38;
    NumberKeyCodes(10)=39;
    
    % back 5 - m
    NumberKeyCodes(20)=16;
    % back 1 - <
    NumberKeyCodes(21)=54;
    % forward 1 - >
    NumberKeyCodes(22)=55;
    % forward 5 - /
    NumberKeyCodes(23)=56;
    
end


return