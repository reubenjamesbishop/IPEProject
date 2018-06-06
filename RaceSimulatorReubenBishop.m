%Sets up initial conditions so that the program can run
%Also displays and assigns the users initial account ($100)
repeat=1;
account=100; 
fprintf('You have 100 dollars\n');
pause(1);

%The race simulation will only run again if the user wishes
while repeat >0  

%The simulation will only run if the user has money in their account'
%If the user is broke, it will tell them and break out of the while loop 
if account <=0
    fprintf('Sorry, you ran out of money...\n');
    break
    
else
%If at this point, the user has chosen to play (/play again) and has enough money to spend    
%This creates popup window asking the user to choose a car to bet on
bet=questdlg('Please pick a car to bet on','Bet placement','Red','Green','Blue','Green');
fprintf('You bet on %s \n',bet);

%This assigns the users bet to a number (1,2 or 3) instead of a string
switch bet 
    case 'Red'
        bet=1;
    case 'Blue'
        bet=2;
    case 'Green'
        bet=3;
end 

%Asks for a wager amount (in dollars)
wager=questdlg('Please pick a wager amount','wager placement','$10','$20','$50','$20');

%Assigns and displays the users bet to a number, rather than a string
switch wager
    case '$10'
        wager=10;
    case '$20'
        wager=20;
    case '$50'
        wager=50;
end 
fprintf('You wagered %d dollars\n',wager);

%Sets up a set of axes and a track for the cars to 'race' on, 
close all;
f=figure;
axis([0 500 0 400]);
line([20 20],[50 350],'LineWidth',4,'Color','w','LineStyle','default');
line([3 3],[50,350],'LineWidth',4,'Color','w','LineStyle','--');
line([450 450],[50,350],'LineWidth',4,'Color','w','LineStyle','default');
line([497 497],[50,350],'LineWidth',4,'Color','w','LineStyle','--');
line([0 500],[50 50],'LineWidth',4,'Color','w');
line([0 500],[350 350],'LineWidth',4,'Color','w');

%Adds textboxes labelling the start and finish lines
finish_line_high=uicontrol('style','text');
set(finish_line_high,'String','FINISH');
set(finish_line_high,'BackgroundColor',[0.8 0.8 0.8],'Position',[420,350,100,40],'FontSize',12,'FontWeight','bold');

finish_line_low=uicontrol('style','text');
set(finish_line_low,'String','FINISH');
set(finish_line_low,'BackgroundColor',[0.8 0.8 0.8],'Position',[420,30,100,40],'FontSize',12,'FontWeight','bold');

start_line_high=uicontrol('style','text');
set(start_line_high,'String','START');
set(start_line_high,'BackgroundColor',[0.8 0.8 0.8],'Position',[40,350,100,40],'FontSize',12,'FontWeight','bold');

start_line_low=uicontrol('style','text');
set(start_line_low,'String','START');
set(start_line_low,'BackgroundColor',[0.8 0.8 0.8],'Position',[40,30,100,40],'FontSize',12,'FontWeight','bold');

%Sets the background to light grey ([0.8 0.8 0.8] color triplet), and disables visible axes
set(gca, 'visible', 'off');
set(gcf, 'color',[0.8,0.8,0.8]);

%Sets up the shape, colour and starting position of the cars
redcar=rectangle('Position',[0,300,10,10],'curvature',[.1,1],'FaceColor','r');
greencar=rectangle('Position',[0,200,10,10],'curvature',[.1,1],'FaceColor','g');
bluecar=rectangle('Position',[0,100,10,10],'curvature',[.1,1],'FaceColor','b');

%Sets up the initial positions of the cars, and their respective randomised speed retardation factors
%The cars will run at a random speed of between 50% and 100% of their normal running speed
dx=1;
posx_r=0;
posx_b=0;
posx_g=0;
red_speed=0.01*randi([50 100],1,1);
blue_speed=0.01*randi([50 100],1,1);
green_speed=0.01*randi([50 100],1,1);

%Animates the seperate cars with a 'while' loop
while red_speed*posx_r <450 && blue_speed*posx_b <450 && green_speed*posx_g <450
    posx_r=posx_r+dx;
    set(redcar,'Position',[red_speed*posx_r,300,20,10]);
    posx_b=posx_b+dx;
    set(bluecar,'Position',[blue_speed*posx_b,200,20,10]);
    posx_g=posx_g+dx;
    set(greencar,'Position',[green_speed*posx_g,100,20,10]);
    pause(0.005);
end

%Waits for a second, then closes the popup race window
pause(1);
close all;

%Stores the finishing values of the cars
A=red_speed*posx_r;
B=blue_speed*posx_b;
C=green_speed*posx_g;

%Displays the results of the race, and stores the winner as a number (1,2 or 3)
result=0;
switch result
    case A < 450 
        fprintf('Red won\n');
        winner=1;
    case B < 450 
        fprintf('Blue won\n');
        winner=2;
    case C < 450
        fprintf('Green won\n')
        winner=3;
end 
pause(1);

%Determines and displays to the user the results 
if bet == winner
    fprintf('Congratulations! You were right!!!\n');
    pause(1);
    fprintf('You won %d dollars!\n',wager);
    account=account+wager;
    pause(1);
    fprintf('You now have %d dollars in your account\n',account);
else
    fprintf('Bad luck, you were wrong...\n');
    pause(1);
    fprintf('You lost %d dollars!\n',wager);
    account=account-wager;
    pause(1);
    fprintf('You now have %d dollars in your account\n',account);
end
end

%Asks the user if they would like to continue playing
repeat=questdlg('Would you like to play again?','Try again?','Yes','No','Yes');

switch repeat
    case 'Yes'
        repeat=1;
    case 'No'
        repeat=0;
end
end

%This is the end of the program and tells the user how much money they finished with 
pause(1);
fprintf('You finished with %d dollars in your account\n',account);
pause(1);
fprintf('Have a nice day!\n');

