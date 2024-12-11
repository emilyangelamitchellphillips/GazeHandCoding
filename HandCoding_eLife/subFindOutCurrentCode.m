function [CurrentCode]=subFindOutCurrentCode(CodingLabels,Frame,Coding);

% This function finds the current code that the user has inputted. 

CurrentCodeNumber=Coding((Coding(:,1)<=Frame & Coding(:,2)>=Frame),3);

if ~isempty(CurrentCodeNumber)
CurrentCode=CodingLabels{CurrentCodeNumber};
else
    CurrentCode='UNCODED';
end

return