function [Coding,Frame]=subDeleteLastCode(Coding,framecount)

HowManyPrevCodes=size(Coding,1);
if HowManyPrevCodes==1
    Coding=[0 0 0];
    Frame=1;
else
    Coding2=Coding(1:HowManyPrevCodes-1,:);
    Frame=Coding(HowManyPrevCodes-1,2);
    Coding=Coding2;
    Coding(end,2)=framecount;
end



return