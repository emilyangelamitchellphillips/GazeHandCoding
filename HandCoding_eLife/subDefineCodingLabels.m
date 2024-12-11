function [CodingLabels, CodingLabelsAllInOne]=subDefineCodingLabels

% This function allows the user to input the names of the obejcts that the
% caregiver and infant are playing with. The user has the option to leave
% empty. 

Temp=input('Name for object 1?','s');
% Temp='Ball';
if ~isempty(Temp)
    CodingLabels{1}=strcat('1:',Temp,' ');
end

Temp=input('Name for object 2? (or return to leave empty)','s');
% Temp='Cup';
if ~isempty(Temp)
    CodingLabels{2}=strcat('2:',Temp,' ');
end

Temp=input('Name for object 3? (or return to leave empty)','s');
% Temp='Robot';
if ~isempty(Temp)
    CodingLabels{3}=strcat('3:',Temp,' ');
end


CodingLabels{4}='4:Partner ';
CodingLabels{5}='5:Inattentive ';
CodingLabels{6}='6:Uncodable ';

CodingLabelsAllInOne=strcat(CodingLabels{1:length(CodingLabels)});



return