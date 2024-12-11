
% set directories

MoviesDir= '/Users/Dean/BabyLab/coding_videos'; % directory to video files coding
ResultsDir= '/Users/Dean/BabyLab/hand coding scripts'; % directory to where results will be saved
ScriptsDir= '/Users/Dean/BabyLab/hand coding scripts'; % directory to where scripts are stored
SyncPath='/Users/Dean/BabyLab/coding_videos/camera_sync.xlsx'; %directory to xlsx file with right and left camera LEDs
Syncs=xlsread(SyncPath);

fname={'22_2_nat1s_inf'}; %file corresponding to video

% you need to update these manually too every time you do a new video
subject=22; % ID number (first number above)
visit=2; %visit number (second number above)
chunk=1; % (play section number (third number bove)


% res(1) is the x dimension and res(2) is the y dimension - if the display
% doesn't fit onto your screen you can shrink these
res(1)=1000;
res(2)=1010;

%%%% set resolution for each screen
xdivider=0.6;
ydivider=[0.4 0.8];
resb(1,:)=[1 1 res(1)*xdivider res(2)*ydivider(1)]; 1;% main screen1
resb(2,:)=[res(1)*xdivider 1 res(1) res(2)*(ydivider(1)*0.66)]; % face screen1
resb(3,:)=[1 res(2)*ydivider(1) res(1)*xdivider res(2)*ydivider(2)]; 1% main screen2
resb(4,:)=[res(1)*xdivider res(2)*ydivider(1) res(1) (res(2)*ydivider(1))+(resb(2,4)-resb(2,2))]; % face screen2
resb(5,:)=[1 res(2)*ydivider(2) res(1)*xdivider res(2)]; % text screen
resb(6,:)=[res(1)*xdivider res(2)*(ydivider(2)*0.66) res(1) res(2)]; % object codes
format long g

% initialise screen
[EXPWIN, scr_rect]=Screen('OpenWindow',0, [], [0 0 res(1) res(2)]);
ifi = Screen('GetFlipInterval', EXPWIN);

% initialise keys
KbName('UnifyKeyNames');
kb=GetKeyboardIndices;
kb=kb(1);

% Windows = 1, Mac = 2
PCMac=2;

% Setup keyboard shortcuts
changeface=KbName('p');
quit=KbName('q');
delete=KbName('d');

[NumberKeyCodes]=subAssignNumberKeyCodes(PCMac);
fastback=NumberKeyCodes(20);
back=NumberKeyCodes(21);
forward=NumberKeyCodes(22);
fastforward=NumberKeyCodes(23);

files=1;

% Find the camera frame in each camera to synchronise the cameras
DingTime1=Syncs((Syncs(:,1)==subject & Syncs(:,2)==visit & Syncs(:,3)==chunk),5);
DingTime2=Syncs((Syncs(:,1)==subject & Syncs(:,2)==visit & Syncs(:,3)==chunk),4);
DingLRDiff=DingTime1-DingTime2; 
if isempty(DingTime1) || isempty(DingTime2)
   disp('COULD NOT FIND DING TIMES. DID YOU UPDATE THE NUMBERS AT THE TOP OR IS IT MISSING FROM THE EXCEL FILE?')
   crashme
end
Frame2=DingTime2;

% Disable echoing keypresses to MATLAB command window
ListenChar(2);

% Initialise the video system
Screen('Preference', 'SkipSyncTests', 2);

% initialise and set start frame
savename=strcat(ResultsDir,'/',fname{files},'.csv');
try
    Coding=csvread(savename);
    exists=1;
catch
    exists=0;
    Coding=zeros(1,3);
    Frame2=DingTime2;
end
       

if exists
    Screen('FillRect', EXPWIN, [255 255 255], [resb(1,1) resb(1,2) resb(1,3) resb(1,4)]) % no transp
    Screen('TextSize',EXPWIN,20);
    Text=fname{files};
    Screen('DrawText', EXPWIN, Text, 20, 20, [0 0 0]);
    Text='previous coded file exists. start from last code entered (1) or begin again(2)?';
    Screen('DrawText', EXPWIN, Text, 20, 50, [0 0 0]);
    Screen('Flip', EXPWIN);
    while(1)
        [keyIsDown,secs,keyCode]=KbCheck;
        if keyIsDown==1
            which=find(keyCode(:)==1);
            Code=find(NumberKeyCodes(:)==which);
            if Code==1
                Frame2=Coding(end,1);
            elseif Code==2
                Coding=zeros(1,3);
                Frame2=1;
            end
            break
        end
    end
end

MovieName=strcat(MoviesDir,'/',fname{files},'.MP4')
[mov dur fps h w framecount] = Screen('OpenMovie', EXPWIN, MovieName);
             
[FaceCoords]=subSetFaceCoords(mov, fps, framecount/2, resb, EXPWIN,MoviesDir);

% Re-enable echoing to MATLAB command window so user can enter object names
ListenChar(0);

[CodingLabels, CodingLabelsAllInOne]=subDefineCodingLabels;

FaceSourceRect=[FaceCoords(1)*h FaceCoords(2)*w FaceCoords(3)*h FaceCoords(4)*w];
      
%Disable echoing keypresses to MATLAB
ListenChar(2);

        tic
        while(1)
            % fetches the frame specified by the time code Frame/fps from
            % one part of the memory to another
            Frame/fps;
            [nextframe] = Screen('GetMovieImage', EXPWIN, mov, [], Frame/fps, [], 1);
            
            % draws the image nextframe to the screen
            Screen('DrawTexture', EXPWIN, nextframe, [], resb(1,:));
            Screen('DrawTexture', EXPWIN, nextframe, FaceSourceRect, resb(2,:));
            
            % draw frame number
            Screen('FillRect', EXPWIN, [255 255 255], [resb(1,1) 1 resb(1,1)+300 50 ]) % no transp
            Text=strcat(fname{files},'Frame',num2str(Frame));
            Screen('TextSize',EXPWIN,20);
            Screen('DrawText', EXPWIN, Text, 20, 20, [0 0 0]);
            
            % draw current code
            [CurrentCode]=subFindOutCurrentCode(CodingLabels,Frame,Coding);
            Screen('FillRect', EXPWIN, [255 255 255], [resb(1,1) 51 resb(1,1)+310 101 ]) % no transp
            Screen('TextSize',EXPWIN,20);
            Screen('DrawText', EXPWIN, strcat('CURRENT FRAME:',CurrentCode), resb(1,1)+5, 71, [255 0 0]);
            
            % draw commands along the bottom
            Screen('TextSize',EXPWIN,15);
            Text='(m) back five frames  (<) back one frame  (>) forward one frame  (/) forward five frames';
            Screen('DrawText', EXPWIN, Text, resb(3,1), resb(3,2), [0 0 0]);
            Text=strcat('PRESS TO CODE: ', CodingLabelsAllInOne);
            Screen('DrawText', EXPWIN, Text, resb(3,1), resb(3,2)+30, [0 0 0]);
            Text='(d) delete last code  (p) redo face  (q) quit';
            Screen('DrawText', EXPWIN, Text, resb(3,1), resb(3,2)+60, [0 0 0]);
            subDrawCodingLabels(EXPWIN, resb,Coding,CodingLabels,framecount)
            Screen('Flip', EXPWIN);
            Screen('Close', nextframe);
       
            [keyIsDown,secs,keyCode]=KbCheck;
            if (keyIsDown==1 & keyCode(fastback));
                Frame=Frame-5;
              
            elseif (keyIsDown==1 & keyCode(back));
                Frame=Frame-1;
            
            elseif (keyIsDown==1 & keyCode(forward));
                Frame=Frame+1;
               
            elseif (keyIsDown==1 & keyCode(fastforward));
                Frame=Frame+5;
                
            elseif (keyIsDown==1 & keyCode(changeface));
                [FaceCoords]=subSetFaceCoords(mov, fps, Frame, resb, EXPWIN,MoviesDir);
                FaceSourceRect=[FaceCoords(1)*h FaceCoords(2)*w FaceCoords(3)*h FaceCoords(4)*w];
                
            elseif (keyIsDown==1 & keyCode(delete));
                [Coding,Frame]=subDeleteLastCode(Coding,framecount);
                
            elseif (keyIsDown==1 & keyCode(quit));
                break
            elseif keyIsDown==1
                which=find(keyCode(:)==1);
                Code=find(NumberKeyCodes(:)==which);
                if ~isempty(Code)
                    [Coding]=subAddCoding(Coding,Frame,framecount,keyCode,NumberKeyCodes);
                end
            end
           
            if Frame<1
                Frame=1;
            end
            WaitSecs(0.2);
            
            if toc>10
                savename=strcat(ResultsDir,'/',fname{files},'.csv');
                csvwrite(savename,Coding);
                tic
            end
        end
        
Screen('PlayMovie', mov, 0);

% Close down any residual windows.
Screen('CloseAll');

% Re-enable keyboard echoing onto MATLAB command window & Cursor
ListenChar(0);
ShowCursor('Arrow');

% save coding output
savename=strcat(ResultsDir,'/',fname{files},'.csv');
csvwrite(savename,Coding);
clear all