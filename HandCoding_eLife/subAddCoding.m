function [Coding]=subAddCoding(Coding,Frame,framecount,keyCode,NumberKeyCodes);

% This function saves the current code inputted by the user into the Coding
% variable. 

if nargin==0
    Coding=[1 5 1; 6 10 2; 11 15 1];
    keyCode=1;
    Frame=16;
    framecount=999;
end

which=find(keyCode(:)==1);
Code=find(NumberKeyCodes(:)==which);

[CurrentCodingLine, ignore]=find(Coding(:,1)<=Frame &(Coding(:,2)>=Frame));
HowManyPrevCodes2=Coding(:,1);
HowManyPrevCodes2=ExcludeNoughts(HowManyPrevCodes2);
HowManyPrevCodes=length(HowManyPrevCodes2);

if isempty(CurrentCodingLine)
    % no current code active
    NextCode=HowManyPrevCodes+1;
    Coding(NextCode,1)=Frame;
    Coding(NextCode,2)=framecount;
    Coding(NextCode,3)=Code;
    
elseif ~isempty(CurrentCodingLine)
    
    % if we are in the last active code, add another one on the end
    if CurrentCodingLine==HowManyPrevCodes
        % is the key currently pressed the same as currently active coding?
        % If so do nothing.
        if Code==Coding(CurrentCodingLine,3)
        else
            % otherwise...
            Coding(CurrentCodingLine,2)=Frame-1;
            NextCode=HowManyPrevCodes+1;
            Coding(NextCode,1)=Frame;
            Coding(NextCode,2)=framecount;
            Coding(NextCode,3)=Code;
        end

    end
end


return