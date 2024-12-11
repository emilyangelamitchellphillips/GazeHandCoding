# Gaze Hand Coding

These scripts can be used to code the gaze behaviours of caregivers and infants during table-top play interactions. See Phillips et al. (2023) for further detail on its implementation. 

## Requirements

•	Matlab\
•	PsychToolbox\
•	Gstreamer


## User instructions 

The user is able to scroll through the video images frame-by-frame, with options to move forward/backwards in 5 frame intervals. A zoomed-in image of the infant’s/Mum’s face appears next to the main video image. Codes available for the user to input include: looks to partner, inattentive, uncodable and looks to each object. The user names each object on the table before beginning the coding so that each object has its own individual code. The scripts save the codes inputted by the user each time a new code is selected. The output is saved in a csv file where col1=look onset frame, col2=look offset frame col3=code (4=partner, 5=inattentive, 6=uncodable, 1-3=each object named by the user). 

The main scripts needed to run the hand coding are HandCoding_inf.m and HandCoding_mum.m. The infant script allows the user to code eye gaze from two synchronised videos, whilst the Mum script is set to code gaze from one video.

Before beginning coding, the user needs to input directories to the Scripts folder, including all main functions and subfunctions, the folder that the videos are located in and a folder for the results to be saved in. 

When the user runs the scripts for each interaction for the first time, they will be asked to enter the name of the objects to be coded and they will need to select the location of the window for the zoomed-in image of the infant’s/Mum’s face.
