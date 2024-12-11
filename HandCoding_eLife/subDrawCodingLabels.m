function subDrawCodingLabels(EXPWIN, resb,Coding,CodingLabels,framecount)

NLabels=size(Coding,1);

XCols=[1 120 240];

Screen('TextSize',EXPWIN,15);
ColLabels={'StartFrame' 'EndFrame' 'Code'};

for cols=1:length(XCols)
    Screen('DrawText', EXPWIN, ColLabels{cols}, resb(4,1)+XCols(cols), resb(4,2), [0 0 0]);
end

StartLabel=NLabels-5;
if StartLabel<1
    StartLabel=1;
end

TextY=resb(4,2);
for Label=StartLabel:NLabels
    TextY=TextY+30;
    for cols=1:3
        if cols==1||cols==2
        Temp=(Coding(Label,cols));
        if Temp==framecount
            Text='current';
        else
            Text=num2str(Temp);
        end
        else
            WhichLabel=Coding(Label,cols);
            if WhichLabel~=0
            Text=CodingLabels{WhichLabel};
            else
                Text='Empty';
            end
        end
        Screen('DrawText', EXPWIN, Text, resb(4,1)+XCols(cols), TextY, [0 0 0]);
    end
end

return