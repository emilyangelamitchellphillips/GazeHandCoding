function [FaceCoords]=subSetFaceCoords(mov, fps, Frame, resb, EXPWIN,MoviesDir)

% This function allows the user to select the window for the zoomed-in
% image of the infant/caregvier face. The user can re-do the box muliple
% times until they are happy with the zoomed-in image. 

[imdata map alpha] = imread (strcat(MoviesDir,'/DemoSlide1.jpg'));
texes.demo1=Screen('MakeTexture', EXPWIN, imdata);

[imdata map alpha] = imread (strcat(MoviesDir,'/DemoSlide2.jpg'));
texes.demo2=Screen('MakeTexture', EXPWIN, imdata);

HideCursor(EXPWIN);
QuitFlag=0;

while(1)
    
    CornerCount=0;
    
    while(1)
        [nextframe] = Screen('GetMovieImage', EXPWIN, mov, [], Frame/fps, [], 1);
        Screen('DrawTexture', EXPWIN, nextframe, [], resb(1,:));
        
        Screen('TextSize',EXPWIN,20);
        if CornerCount==0
            Screen('DrawTexture', EXPWIN, texes.demo1, [], resb(2,:));
            Text='Click on top left corner of baby face (see demo image on right)';
        elseif CornerCount==1
            Screen('DrawTexture', EXPWIN, texes.demo2, [], resb(2,:));
            Text='Click on bottom right corner of baby face (see demo image on right)';
        end
        Screen('DrawText', EXPWIN, Text, resb(3,1), resb(3,2), [0 0 0]);
        
        [x,y,buttons]=GetMouse(EXPWIN);
        Screen('TextSize',EXPWIN,40);
        Screen ('DrawText', EXPWIN, '.', x, y, [255 0 0]);
        Screen('Flip',EXPWIN);
        
        if buttons(1)==1;
            CornerCount=CornerCount+1;
            
            if CornerCount==1;
                Corners(1)=x+5;
                Corners(2)=y+0; 
                WaitSecs(0.5)
            elseif CornerCount==2;
                Corners(3)=x+5;
                Corners(4)=y+0;
                break
            end
        end
        
    end
    
    while(1)
        Screen('DrawTexture', EXPWIN, nextframe, [], resb(1,:));
        Screen('FrameRect', EXPWIN, [255 0 0], Corners, 3);
        Text='Accept(q) or redo(w)?';
        Screen('TextSize',EXPWIN,20);
        Screen('DrawText', EXPWIN, Text, resb(3,1), resb(3,2), [0 0 0]);
        
        Screen('Flip',EXPWIN);
        
        q=KbName('q');
        w=KbName('w');
        
        [keyIsDown,~,keyCode]=KbCheck;
        if (keyIsDown==1 & keyCode(q));
            QuitFlag=1;
            break;
        elseif (keyIsDown==1 & keyCode(w));
            break
        end;
    end
    QuitFlag
    if QuitFlag
        break
    end
end

Corners;
resb2dims=[resb(1,3)-resb(1,1) resb(1,4)-resb(1,2)];
FaceCoords=[(Corners(1))/resb2dims(1) (Corners(2))/resb2dims(2) (Corners(3))/resb2dims(1) (Corners(4))/resb2dims(2)];

return