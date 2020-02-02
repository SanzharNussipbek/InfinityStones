import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

//import the Minim library
//create Minim variable
Minim minim;
//create AudioPlayer variable
AudioPlayer button1;
AudioPlayer button2;
AudioPlayer gameover;
AudioPlayer win;
AudioPlayer pass;
AudioPlayer music;

PImage cursor, cross, hrz, vrt, ld, lu, rd, ru; // main pipe imagese
int x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6; // coordinates of the flying stones at the background
int dx, dy, s, t, t2, k, timer, timer2, stage, passno, counter=0; //variables
int startX, startY, instrX, instrY, exitX, exitY, buttonWidth, buttonHeight, backX, backY, backWidth, backHeight, restartX, restartY, restartWidth, restartHeight; //coordinates of the buttons
//Arrays for coordinates of the flying stones
int[]x=new int[6];
int[]y=new int[6];
//Arrays for the images
PImage[]stone1 = new PImage[6];
PImage[]stone2 = new PImage[6];
PImage[]thanos = new PImage[6];
PImage[]row = new PImage[6];
PImage[]gauntlet = new PImage[5];
PImage[]stone_move = new PImage[6];
//Arrays for the image locations
PImage[]pipe = new PImage[49];
int[][]pipe1 = new int[5][5];
int[][]pipe2 = new int[5][5];
int[][]pipe3 = new int[5][5];
int[][]pipe4 = new int[5][5];
int[][]pipe5 = new int[5][5];
int[][]pipe6 = new int[5][5];


void setup()
{
 size(700, 400); //size of the window
 
 //create a Minim object 
  minim = new Minim(this); 
  //load the song into the player
  button1 = minim.loadFile("button_click1.mp3");
  button2 = minim.loadFile("button_click2.mp3");
  win=minim.loadFile("win.mp3");
  gameover=minim.loadFile("gameover.mp3");
  music=minim.loadFile("Avengers.mp3");
  
  music.play(); //background music playing
  music.rewind();
  
 for(int i=0;i<6;i++) //loop for creating images and other variables in the arrays
 {
   stone1[i]=loadImage("stone"+(i+1)+".png"); //stones without a text
   stone2[i]=loadImage("stone"+(i+1)+"."+(i+1)+".png"); //stones with text
   thanos[i]=loadImage("thanos"+(i+1)+".png"); //thanos images
   row[i]=loadImage("row"+(i+1)+".png"); //rows for each stone
   stone_move[i]=loadImage("stone"+(i+1)+".png"); //moving stones
   x[i]=int(random(0,690)); //x coordinates
   y[i]=int(random(0,690)); //y coordinates
 }
 
 for(int i=0;i<5;i++)
 {
   gauntlet[i]=loadImage("gauntlet"+(i+1)+".png"); //images of gauntlet
 }
 
 //Images
 cursor=loadImage("cursor.png"); //cursor image
 //declaring images of pipes
 ld=pipe[0]=loadImage("left-down.jpg"); 
 lu=pipe[1]=loadImage("left-up.jpg");
 ru=pipe[2]=loadImage("right-up.jpg");
 rd=pipe[3]=loadImage("right-down.jpg");
 vrt=pipe[4]=loadImage("vertical.jpg");
 hrz=pipe[5]=loadImage("horizontal.jpg");
 cross=pipe[6]=loadImage("cross.jpg");
 //declaring pipes of stone 1
 pipe[7]=loadImage("left-down_stone1.jpg");
 pipe[8]=loadImage("left-up_stone1.jpg");
 pipe[9]=loadImage("right-up_stone1.jpg");
 pipe[10]=loadImage("right-down_stone1.jpg");
 pipe[11]=loadImage("vertical_stone1.jpg");
 pipe[12]=loadImage("horizontal_stone1.jpg");
 pipe[13]=loadImage("cross_stone1.jpg");
 //declaring pipes of stone 2
 pipe[14]=loadImage("left-down_stone2.jpg");
 pipe[15]=loadImage("left-up_stone2.jpg");
 pipe[16]=loadImage("right-up_stone2.jpg");
 pipe[17]=loadImage("right-down_stone2.jpg");
 pipe[18]=loadImage("vertical_stone2.jpg");
 pipe[19]=loadImage("horizontal_stone2.jpg");
 pipe[20]=loadImage("cross_stone2.jpg");
 //declaring pipes of stone 3
 pipe[21]=loadImage("left-down_stone3.jpg");
 pipe[22]=loadImage("left-up_stone3.jpg");
 pipe[23]=loadImage("right-up_stone3.jpg");
 pipe[24]=loadImage("right-down_stone3.jpg");
 pipe[25]=loadImage("vertical_stone3.jpg");
 pipe[26]=loadImage("horizontal_stone3.jpg");
 pipe[27]=loadImage("cross_stone3.jpg");
 //declaring pipes of stone 4
 pipe[28]=loadImage("left-down_stone4.jpg");
 pipe[29]=loadImage("left-up_stone4.jpg");
 pipe[30]=loadImage("right-up_stone4.jpg");
 pipe[31]=loadImage("right-down_stone4.jpg");
 pipe[32]=loadImage("vertical_stone4.jpg");
 pipe[33]=loadImage("horizontal_stone4.jpg");
 pipe[34]=loadImage("cross_stone4.jpg");
 //declaring pipes of stone 5
 pipe[35]=loadImage("left-down_stone5.jpg");
 pipe[36]=loadImage("left-up_stone5.jpg");
 pipe[37]=loadImage("right-up_stone5.jpg");
 pipe[38]=loadImage("right-down_stone5.jpg");
 pipe[39]=loadImage("vertical_stone5.jpg");
 pipe[40]=loadImage("horizontal_stone5.jpg");
 pipe[41]=loadImage("cross_stone5.jpg");
 //declaring pipes of stone 6
 pipe[42]=loadImage("left-down_stone6.jpg");
 pipe[43]=loadImage("left-up_stone6.jpg");
 pipe[44]=loadImage("right-up_stone6.jpg");
 pipe[45]=loadImage("right-down_stone6.jpg");
 pipe[46]=loadImage("vertical_stone6.jpg");
 pipe[47]=loadImage("horizontal_stone6.jpg");
 pipe[48]=loadImage("cross_stone6.jpg");
 
 //Locations of the images of pipes in the level 1
 pipe1[0][0]=0;
 pipe1[0][1]=6;
 pipe1[0][2]=4;
 pipe1[0][3]=3;
 pipe1[0][4]=5;
 pipe1[1][0]=0;
 pipe1[1][1]=5;
 pipe1[1][2]=1;
 pipe1[1][3]=6;
 pipe1[1][4]=1;
 pipe1[2][0]=1;
 pipe1[2][1]=4;
 pipe1[2][2]=5;
 pipe1[2][3]=2;
 pipe1[2][4]=4;
 pipe1[3][0]=6;
 pipe1[3][1]=1;
 pipe1[3][2]=4;
 pipe1[3][3]=4;
 pipe1[3][4]=2;
 pipe1[4][0]=5;
 pipe1[4][1]=2;
 pipe1[4][2]=3;
 pipe1[4][3]=1;
 pipe1[4][4]=6;
 
 //Locations of the images of pipes in the level 2
 pipe2[0][0]=3;
 pipe2[0][1]=3;
 pipe2[0][2]=6;
 pipe2[0][3]=1;
 pipe2[0][4]=5;
 pipe2[1][0]=6;
 pipe2[1][1]=4;
 pipe2[1][2]=1;
 pipe2[1][3]=5;
 pipe2[1][4]=6;
 pipe2[2][0]=5;
 pipe2[2][1]=3;
 pipe2[2][2]=5;
 pipe2[2][3]=4;
 pipe2[2][4]=2;
 pipe2[3][0]=2;
 pipe2[3][1]=6;
 pipe2[3][2]=3;
 pipe2[3][3]=5;
 pipe2[3][4]=4;
 pipe2[4][0]=4;
 pipe2[4][1]=5;
 pipe2[4][2]=1;
 pipe2[4][3]=0;
 pipe2[4][4]=1;
 
 //Locations of the images of pipes in the level 3
 pipe3[0][0]=4;
 pipe3[0][1]=1;
 pipe3[0][2]=2;
 pipe3[0][3]=0;
 pipe3[0][4]=4;
 pipe3[1][0]=6;
 pipe3[1][1]=5;
 pipe3[1][2]=3;
 pipe3[1][3]=4;
 pipe3[1][4]=1;
 pipe3[2][0]=0;
 pipe3[2][1]=2;
 pipe3[2][2]=5;
 pipe3[2][3]=6;
 pipe3[2][4]=2;
 pipe3[3][0]=4;
 pipe3[3][1]=1;
 pipe3[3][2]=4;
 pipe3[3][3]=0;
 pipe3[3][4]=5;
 pipe3[4][0]=1;
 pipe3[4][1]=4;
 pipe3[4][2]=1;
 pipe3[4][3]=2;
 pipe3[4][4]=4;
 
 //Locations of the images of pipes in the level 4
 pipe4[0][0]=6;
 pipe4[0][1]=5;
 pipe4[0][2]=4;
 pipe4[0][3]=3;
 pipe4[0][4]=2;
 pipe4[1][0]=1;
 pipe4[1][1]=2;
 pipe4[1][2]=6;
 pipe4[1][3]=1;
 pipe4[1][4]=5;
 pipe4[2][0]=5;
 pipe4[2][1]=4;
 pipe4[2][2]=1;
 pipe4[2][3]=0;
 pipe4[2][4]=5;
 pipe4[3][0]=4;
 pipe4[3][1]=6;
 pipe4[3][2]=2;
 pipe4[3][3]=1;
 pipe4[3][4]=6;
 pipe4[4][0]=2;
 pipe4[4][1]=5;
 pipe4[4][2]=1;
 pipe4[4][3]=4;
 pipe4[4][4]=1;
 
 //Locations of the images of pipes in the level 5
 pipe5[0][0]=3;
 pipe5[0][1]=4;
 pipe5[0][2]=0;
 pipe5[0][3]=3;
 pipe5[0][4]=5;
 pipe5[1][0]=5;
 pipe5[1][1]=5;
 pipe5[1][2]=5;
 pipe5[1][3]=1;
 pipe5[1][4]=4;
 pipe5[2][0]=1;
 pipe5[2][1]=0;
 pipe5[2][2]=6;
 pipe5[2][3]=5;
 pipe5[2][4]=3;
 pipe5[3][0]=5;
 pipe5[3][1]=1;
 pipe5[3][2]=5;
 pipe5[3][3]=1;
 pipe5[3][4]=5;
 pipe5[4][0]=6;
 pipe5[4][1]=2;
 pipe5[4][2]=1;
 pipe5[4][3]=4;
 pipe5[4][4]=2;
 
 //Locations of the images of pipes in the level 6
 pipe6[0][0]=5;
 pipe6[0][1]=5;
 pipe6[0][2]=6;
 pipe6[0][3]=5;
 pipe6[0][4]=5;
 pipe6[1][0]=0;
 pipe6[1][1]=3;
 pipe6[1][2]=0;
 pipe6[1][3]=3;
 pipe6[1][4]=0;
 pipe6[2][0]=2;
 pipe6[2][1]=1;
 pipe6[2][2]=2;
 pipe6[2][3]=1;
 pipe6[2][4]=5;
 pipe6[3][0]=6;
 pipe6[3][1]=5;
 pipe6[3][2]=4;
 pipe6[3][3]=6;
 pipe6[3][4]=6;
 pipe6[4][0]=3;
 pipe6[4][1]=0;
 pipe6[4][2]=3;
 pipe6[4][3]=0;
 pipe6[4][4]=5;
 
 dx=dy=1; //speed
 
 s=0; //score
 t=0; //timer 1
 t2=0; //timer 2
 k=0;
 
 //Coordinates of the buttons
 startX=instrX=exitX=265;
 startY=120;
 instrY=185;
 exitY=250;
 buttonWidth=150;
 buttonHeight=50;
 
 backX=300;
 backY=330;
 backWidth=80;
 backHeight=40;
 restartX=285;
 restartY=190;
 restartWidth=130;
 restartHeight=50;
 
}

void background1()
{
 background(0,0,13); //background color
 for(int i=0; i<6; i++)//loop for moving stones at the background
 {
    image(stone_move[i], x[i], y[i], 10, 10);
    x[i]=x[i]+dx;
    y[i]=y[i]+dy;
   //conditions for appearing of stones if they exceed the border of the window
   if(x[0]<0 || x[0]>=690)
    {
      x[0]=690-x[0];
    }
     if(y[0]<0 || y[0]>=390)
    {
      y[0]=390-y[0];
    }
   if(x[1]<0 || x[1]>=690)
    {
      x[1]=690-x[1];
    }
     if(y[1]<0 || y[2]>=390)
    {
      y[1]=390-y[2];
    }
    if(x[2]<0 || x[2]>=690)
    {
      x[2]=690-x[2];
    }
     if(y[2]<0 || y[2]>=390)
    {
      y[2]=390-y[2];
    }
    if(x[3]<0 || x[3]>=690)
    {
      x[3]=690-x[3];
    }
     if(y[3]<0 || y[3]>=390)
    {
      y[3]=390-y[3];
    }
    if(x[4]<0 || x[4]>=690)
    {
      x[4]=690-x[4];
    }
     if(y[4]<0 || y[4]>=390)
    {
      y[4]=390-y[4];
    }
    if(x[5]<0 || x[5]>=690)
    {
      x[5]=690-x[5];
    }
     if(y[5]<0 || y[5]>=390)
    {
      y[5]=390-y[5];
    }
 }
}

 void draw()
 {  //stages for different pages
  if(stage==0)
  {welcome();}
  else if(stage==1)
  {level1();}
  else if(stage==2)
  {level2();}
  else if(stage==3)
  {level3();}
  else if(stage==4)
  {level4();}
  else if(stage==5)
  {level5();}
  else if(stage==6)
  {level6();}
  else if(stage==7)
  {instructions();}
  else if(stage==8)
  {gameOver();}
  else if(stage==9)
  {pass();}
  else if(stage==10)
  {gameWin();}
  else if(stage==11)
  {timer();}
  counter++; //stopwatch
 }
 
void welcome()
{
 background1(); //background
 image(thanos[0], 75, 125, 150, 250);

 fill(255, 0, 0);
 textSize(30);
 textAlign(LEFT);
 text("Welcome to", 260, 50);
 text("Infinity Gauntlet game", 190,80);
 
 fill(0,0,13);
 stroke(255,255,255);
 for(int i=0; i<3; i++) //buttons
 {
  rect(startX, startY+65*i, buttonWidth, buttonHeight); 
 }
 
 fill(255,0,0);
 textSize(25);
 textAlign(LEFT);
 text("Start", 310, 155); 
 text("Instructions", 270, 220); 
 text("Exit", 310, 285); 
   //changing the image of the cursor
   if(mouseX>startX && mouseX<startX+buttonWidth && mouseY>startY && mouseY<startY+buttonHeight) //conditions for changing an image of the cursor
   { 
     noCursor();
     image(cursor, mouseX, mouseY);
   }
   else if(mouseX>instrX && mouseX<instrX+buttonWidth && mouseY>instrY && mouseY<instrY+buttonHeight)
   {
     noCursor();
     image(cursor, mouseX, mouseY);
   }
   else if(mouseX>exitX && mouseX<exitX+buttonWidth && mouseY>exitY && mouseY<exitY+buttonHeight)
   {
     noCursor();
     image(cursor, mouseX, mouseY);
   }
   else
   {
    cursor(ARROW); 
   }
}

 void instructions()
 {
  background1(); //background
  image(thanos[1], 50, 150, 125, 225);
  image(gauntlet[1], 550, 50, 175, 150);
  image(stone2[0], 10, 10, 50, 80); //stones
  image(stone2[1], 90, 80, 50, 80);
  image(stone2[2], 200, 320, 50, 80);
  image(stone2[3], 430, 320, 50, 80);
  image(stone2[4], 590, 250, 50, 80);
  image(stone2[5], 550, 100, 50, 80);
 

  fill(255, 0, 0);
  textSize(30);
  textAlign(LEFT);
  text("Instructions", 270, 50);
 
  fill(0,0,13);
  stroke(255,255,255);
  rect(175, 70, 355, 250);//button
  
  fill(0,0,13);
  stroke(255,255,255);
  rect(backX, backY, backWidth, backHeight);//button
 
  fill(255,0,0);
  textSize(25);
  textAlign(LEFT);
  text("Back", 315, 360);
 
  fill(255,0,0); //instruction text
  textSize(15);
  textAlign(CENTER);
  text("Thanos is a Marvel Comics character, who is collecting powerful infinity stones into his own Infinity Gauntlet. Help him to collect the stones and destroy half of the universe to make other's life better. Click on pipes to rotate them and make a pipe-road between thanos and the stone. Be aware of the time given to you, which is placed at top right corner of the window.", 180, 75, 340, 240);
  
  if(mouseX>backX && mouseX<backX+backWidth && mouseY>backY && mouseY<backY+backHeight) //conditions for changing an image of the cursor
   {
     noCursor();
     image(cursor, mouseX, mouseY);
   }
   else
   {
    cursor(ARROW); 
   }
 }
 
 void timer() //timer before the start of the level 1
 {
  background1();
  k++;
  timer=3-k/60; //timer
  fill(255,0,0);
  textSize(50); 
  text(timer, 330, 200);
  if(timer<=0)
  {stage=1;}//stage for the level 1 
  
 }
 
 void level1() //level 1
 {
   background1();
   cursor(HAND);
   
   //images
   image(thanos[3], 50, 130, 75, 125);
   image(stone2[0], 580, 140, 60, 90); 
   image(row[0], 155, 182, 30, 20);
   image(row[0], 510, 182, 30, 20);

   fill(255, 0, 0);
   textSize(25);
   textAlign(LEFT);
   text("Level 1: Space stone", 230, 30); //name of the stone
   text("Score: " + s + " stones", 0, 25); //score
   t++;
   timer=30-t/60;
   text("Time: " + timer + "s", 295, 60); //timer
  
   for(int i=0; i<5; i++)
   { 
     for(int j=0; j<5; j++)
     {
      image(pipe[pipe1[i][j]], 225+50*j, 75+50*i); //making a maze of pipes
     }
   }  
   //checking if the road of pipes is correct
   if(timer>0 && pipe1[2][0]==1 && pipe1[1][0]==3 && pipe1[1][1]==5 && pipe1[1][2]==0 && pipe1[2][2]==4 && pipe1[3][2]==4 && pipe1[4][2]==2 && pipe1[4][3]==1 && pipe1[3][3]==4 && pipe1[2][3]==3 && pipe1[2][4]==5)
   {
     win.play(); //sound effect of winning
     win.rewind();
     
     pipe1[2][0]=8; //changing the pipes to the another color
     pipe1[1][0]=10;
     pipe1[1][1]=12;
     pipe1[1][2]=7;
     pipe1[2][2]=11;
     pipe1[3][2]=11;
     pipe1[4][2]=9;
     pipe1[4][3]=8;
     pipe1[3][3]=11;
     pipe1[2][3]=10; 
     pipe1[2][4]=12;
     s++; //score increment
     passno=1; //to change the level
     t=0; //timer is zero
     counter=0;
   }
   else if(timer<=0) //gameover condition
   {
     gameover.play(); //sound effect
     gameover.rewind();
    stage=8;
   }    
   if(counter/60==2 ) //waiting two seconds to show colorfull pipes
   {
     if(passno==1)
     {
       stage=9;
     }
   }
 }
 
 void level2() //level 2
 {
   background1();
   cursor(HAND);
   
   //images
   image(thanos[3], 50, 130, 75, 125);
   image(stone2[1], 580, 140, 60, 90);
   image(row[1], 155, 182, 30, 20);
   image(row[1], 510, 182, 30, 20);

   fill(255, 0, 0);
   textSize(25);
   textAlign(LEFT);
   text("Level 2: Mind stone", 230, 30); //name of the stone
   text("Score: " + s + " stones", 0, 25); //score
   t++; //timer
   timer=25-t/60;//timer decrement
   text("Time: " + timer + "s", 295, 60); //timer
  
   for(int i=0; i<5; i++)
   { 
     for(int j=0; j<5; j++)
     {
      image(pipe[pipe2[i][j]], 225+50*j, 75+50*i); //declaring pipes
     }
   }
   
   if(timer>0 && pipe2[2][0]==5 && pipe2[2][1]==1 && pipe2[1][1]==4 && pipe2[0][1]==3 && pipe2[0][2]==6 && pipe2[0][3]==0 && pipe2[1][3]==4 && pipe2[2][3]==4 && pipe2[3][3]==4 && pipe2[4][3]==2 && pipe2[4][4]==1 && pipe2[3][4]==4 && pipe2[2][4]==3)
   {
     win.play(); //sound effect
     win.rewind();
     
     pipe2[2][0]=19;
     pipe2[2][1]=15;
     pipe2[1][1]=18;
     pipe2[0][1]=17;
     pipe2[0][2]=20;
     pipe2[0][3]=14;
     pipe2[1][3]=18;
     pipe2[2][3]=18;
     pipe2[3][3]=18;
     pipe2[4][3]=16;
     pipe2[4][4]=15;
     pipe2[3][4]=18;
     pipe2[2][4]=17;
     s++; //score increment
     passno=2;
     t=0; //timer
     counter=0;
     
   } 
   else if(timer<=0)
   {
     gameover.play(); //sound effect
     gameover.rewind();
    stage=8;
   } 
   if(counter/60==2 )
   {
     if(passno==2)
     {
       stage=9;
     }
   }
 }
 
 void level3() //level 3
 {
   background1();
   cursor(HAND);
   //images
   image(thanos[3], 50, 130, 75, 125);
   image(stone2[2], 580, 140, 60, 90);
   image(row[2], 125, 182, 30, 20);
   image(row[2], 510, 182, 30, 20);

   fill(255, 0, 0);
   textSize(25);
   textAlign(LEFT);
   text("Level 3: Soul stone", 230, 30); //name of the stone
   text("Score: " + s + " stones", 0, 25); //score
   t++; //timer
   timer=20-t/60;
   text("Time: " + timer + "s", 295, 60); //timer
  
   for(int i=0; i<5; i++)
   { 
     for(int j=0; j<5; j++)
     {
      image(pipe[pipe3[i][j]], 225+50*j, 75+50*i);//placing the pipes
     }
   }  
   
   if(timer>0 && pipe3[2][0]==0 && pipe3[3][0]==4 && pipe3[4][0]==2 && pipe3[4][1]==5 && pipe3[4][2]==1 && pipe3[3][2]==4 && pipe3[2][2]==4 && pipe3[1][2]==3 && pipe3[1][3]==5 && pipe3[1][4]==0 && pipe3[2][4]==2)
   {
     win.play(); //sound effect
     win.rewind();
     
     pipe3[2][0]=21;
     pipe3[3][0]=25;
     pipe3[4][0]=23;
     pipe3[4][1]=26; 
     pipe3[4][2]=22;
     pipe3[3][2]=25;
     pipe3[2][2]=25;
     pipe3[1][2]=24; 
     pipe3[1][3]=26; 
     pipe3[1][4]=21; 
     pipe3[2][4]=23;
     s++; //score increment
     passno=3;
     t=0; //timer
     counter=0;
     
   } 
   else if(timer<=0)
   {
     gameover.play(); //sound effect
     gameover.rewind();
    stage=8;
   } 
   if(counter/60==2 )
   {
     if(passno==3)
     {
       stage=9;
     }
   }
 }
 
 void level4() //level 4
 {
   background1();
   cursor(HAND);
   //images
   image(thanos[3], 50, 130, 75, 125);
   image(stone2[3], 580, 140, 60, 90);
   image(row[3], 155, 182, 30, 20);
   image(row[3], 510, 182, 30, 20);

   fill(255, 0, 0);
   textSize(25);
   textAlign(LEFT);
   text("Level 4: Reality stone", 230, 30); //name of the stone
   text("Score: " + s + " stones", 0, 25); //score
   t++; //timer
   timer=15-t/60;
   text("Time: " + timer + "s", 295, 60); //timer
  
   for(int i=0; i<5; i++)
   { 
     for(int j=0; j<5; j++)
     {
      image(pipe[pipe4[i][j]], 225+50*j, 75+50*i); //placing the pipes
     }
   } 
   
   if(timer>0 && pipe4[2][0]==5 && pipe4[2][1]==5 && pipe4[2][2]==0 && pipe4[3][2]==2 && pipe4[3][3]==1 && pipe4[2][3]==3 && pipe4[2][4]==5)
   {
     win.play(); //sound effect
     win.rewind();
     
     pipe4[2][0]=33;
     pipe4[2][1]=33;
     pipe4[2][2]=28;
     pipe4[3][2]=30;
     pipe4[3][3]=29;
     pipe4[2][3]=31;
     pipe4[2][4]=33;
     s++; //score increment
     passno=4;
     t=0;
     counter=0;
     
   } 
   else if(timer<=0)
   {
     gameover.play(); //sound effect
     gameover.rewind();
    stage=8;
   } 
   if(counter/60==2 )
   {
     if(passno==4)
     {
       stage=9;
     }
   }
 }
 
 void level5()
 {
   background1();
   cursor(HAND);

   image(thanos[3], 50, 130, 75, 125);
   image(stone2[4], 580, 140, 60, 90);
   image(row[4], 155, 182, 30, 20);
   image(row[4], 510, 182, 30, 20);

   fill(255, 0, 0);
   textSize(25);
   textAlign(LEFT);
   text("Level 5: Time stone", 230, 30); //name of the stone
   text("Score: " + s + " stones", 0, 25); //score
   t++;
   timer=15-t/60;
   text("Time: " + timer + "s", 295, 60); //timer
  
   for(int i=0; i<5; i++)
   { 
     for(int j=0; j<5; j++)
     {
      image(pipe[pipe5[i][j]], 225+50*j, 75+50*i);
     }
   } 
   
   if(timer>0 && pipe5[2][0]==1 && pipe5[1][0]==4 && pipe5[0][0]==3 && pipe5[0][1]==5 && pipe5[0][2]==0 && pipe5[1][2]==4 && pipe5[2][2]==6 && pipe5[3][2]==4 && pipe5[4][2]==2 && pipe5[4][3]==5 && pipe5[4][4]==1 && pipe5[3][4]==4 && pipe5[2][4]==3)
   {
     win.play();
     win.rewind();
     
     pipe5[2][0]=36;
     pipe5[1][0]=39;
     pipe5[0][0]=38;
     pipe5[0][1]=40;
     pipe5[0][2]=35;
     pipe5[1][2]=39; 
     pipe5[2][2]=41;
     pipe5[3][2]=39;
     pipe5[4][2]=37; 
     pipe5[4][3]=40; 
     pipe5[4][4]=36;
     pipe5[3][4]=39;
     pipe5[2][4]=38;
     s++;
     passno=5;
     t=0;
     counter=0;
   
   }
   else if(timer<=0)
   {
     gameover.play();
     gameover.rewind();
     stage=8;
   } 
   
   if(counter/60==2)
   {
     if(passno==5)
     {
       stage=9;
     }
   }
 }
 
 void level6()
 {
   background1();
   cursor(HAND);

   image(thanos[3], 50, 130, 75, 125);
   image(stone2[5], 580, 140, 60, 90);
   image(row[5], 155, 182, 30, 20);
   image(row[5], 510, 182, 30, 20);

   fill(255, 0, 0);
   textSize(25);
   textAlign(LEFT);
   text("Level 6: Power stone", 230, 30); //name of the stone
   text("Score: " + s + " stones", 0, 25); //score
   t++;
   timer=15-t/60;
   text("Time: " + timer + "s", 295, 60); //timer
  
   for(int i=0; i<5; i++)
   { 
     for(int j=0; j<5; j++)
     {
      image(pipe[pipe6[i][j]], 225+50*j, 75+50*i);
     }
   } 
   
   if(timer>0 && pipe6[2][0]==1 && pipe6[1][0]==3 && pipe6[1][1]==0 && pipe6[2][1]==2 && pipe6[2][2]==1 && pipe6[1][2]==3 && pipe6[1][3]==0 && pipe6[2][3]==2 && pipe6[2][4]==5)
   {
     win.play();
     win.rewind();
     
     pipe6[2][0]=43;
     pipe6[1][0]=45;
     pipe6[1][1]=42;
     pipe6[2][1]=44;
     pipe6[2][2]=43;
     pipe6[1][2]=45;
     pipe6[1][3]=42;
     pipe6[2][3]=44;
     pipe6[2][4]=47;
     s++;
     counter=0;
     passno=6;
   }
   else if(timer<=0)
   {
     gameover.play();
     gameover.rewind();
     stage=8;
   } 
   
   if(counter/60==2)
   {
     if(passno==6)
     {
       stage=10;
     }
   }
 }
 
 void gameOver() //game over page
 {
  background1();
  
  //gameover.play();
  //gameover.rewind();
  
  image(thanos[4], 50, 130, 200, 200);
  fill(255, 0, 0);
  textSize(25);
  textAlign(LEFT);
  text("Game Over :(", 275, 70);
  textSize(20);
  text("Thanos could not collect all stones", 200, 100);
  text("Your score is " + s + " stones", 240, 140); //score
  text("Try one more time!", 260, 180);
  
  fill(0,0,13);
  stroke(255,255,255);
  rect(restartX, restartY, restartWidth, restartHeight); //restart button
  rect(restartX, 260, restartWidth, restartHeight); //exit button
  
  fill(255,0,0);
  textSize(25);
  textAlign(LEFT);
  text("Restart", 305, 225);
  text("Exit", 325, 295);
  //cursor image
  if(mouseX>restartX && mouseX<restartX+restartWidth && mouseY>260 && mouseY<260+restartHeight)
   { 
     noCursor();
     image(cursor, mouseX, mouseY);
   }
   else if(mouseX>restartX && mouseX<restartX+restartWidth && mouseY>restartY && mouseY<restartY+restartHeight)
   {
     noCursor();
     image(cursor, mouseX, mouseY);
   }
   else
   {
    cursor(ARROW);
   }
   
 }
 
 void gameWin() //winning page
 {
  background1();
  
  image(stone2[0], 10, 10, 50, 80);
  image(stone2[1], 90, 80, 50, 80);
  image(stone2[2], 200, 320, 50, 80);
  image(stone2[3], 430, 320, 50, 80);
  image(stone2[4], 610, 250, 50, 80);
  image(stone2[5], 550, 50, 50, 80);
  
  image(thanos[0], 50, 130, 200, 250);
  image(gauntlet[3], 475, 130, 200, 250);
  fill(255, 0, 0);
  textSize(25);
  textAlign(LEFT);
  text("Congratulations!", 245, 40);
  text("You Win!", 290, 70);
  text("Score: 6 stones", 270, 145); //full score
  textSize(20);
  text("Thanos collected all stones", 220, 100);
  
  
  fill(0,0,13);
  stroke(255,255,255);
  rect(restartX, restartY, restartWidth, restartHeight); //restart button
  rect(restartX, 260, restartWidth, restartHeight); //exit button
  
  fill(255,0,0);
  textSize(25);
  textAlign(LEFT);
  text("Restart", 305, 225);
  text("Exit", 325, 295);
  //cursor images
  if(mouseX>restartX && mouseX<restartX+restartWidth && mouseY>260 && mouseY<260+restartHeight)
   { 
     noCursor();
     image(cursor, mouseX, mouseY);
   }
   else if(mouseX>restartX && mouseX<restartX+restartWidth && mouseY>restartY && mouseY<restartY+restartHeight)
   {
     noCursor();
     image(cursor, mouseX, mouseY);
   }
   else
   {
    cursor(ARROW);
   }
 }
 
 void pass() //passing of level page
 {
   background1();
  
  image(thanos[3], 490, 100, 150, 250);
  fill(255, 0, 0);
  textSize(25);
  textAlign(LEFT);
  text("You have passed", 250, 70);
  text("the level", 290, 100);
  text("Score: "+s  + " stones", 245, 140); //score
  
  fill(0,0,13);
  stroke(255,255,255);
  rect(restartX, restartY, restartWidth, restartHeight); //restart button
  rect(restartX, 260, restartWidth, restartHeight); //exit button
  
  fill(255,0,0);
  textSize(25);
  textAlign(LEFT);
  text("Next", 325, 225);
  text("Exit", 325, 295);
  //cursor images
  if(mouseX>restartX && mouseX<restartX+restartWidth && mouseY>260 && mouseY<260+restartHeight)
   { 
     noCursor();
     image(cursor, mouseX, mouseY);
   }
   else if(mouseX>restartX && mouseX<restartX+restartWidth && mouseY>restartY && mouseY<restartY+restartHeight)
   {
     noCursor();
     image(cursor, mouseX, mouseY);
   }
   else
   {
    cursor(ARROW);
   }
 }
 
 void mousePressed() //conditions if mouse is pressed
 {
   if(mouseX>startX && mouseX<startX+buttonWidth && mouseY>startY && mouseY<startY+buttonHeight && stage==0)
   {
     stage=11;    
     button1.play(); //button click sound
     button1.rewind(); 
   }
   else if(mouseX>instrX && mouseX<instrX+buttonWidth && mouseY>instrY && mouseY<instrY+buttonHeight && stage==0)
   {
     stage=7;    
     button1.play();
     button1.rewind();  
   }
   else if(mouseX>exitX && mouseX<exitX+buttonWidth && mouseY>exitY && mouseY<exitY+buttonHeight && stage==0)
   {
     exit();
     button1.play();
     button1.rewind();      
   }
   else if(mouseX>backX && mouseX<backX+backWidth && mouseY>backY && mouseY<backY+backHeight && stage==7)
   {
     setup();
     stage=0;
     button1.play();
     button1.rewind();  
   } 
   else if(mouseX>restartX && mouseX<restartX+restartWidth && mouseY>260 && mouseY<260+restartHeight && stage==8)
   {
     exit();
     button1.play();
     button1.rewind();      
   }
   else if(mouseX>restartX && mouseX<restartX+restartWidth && mouseY>restartY && mouseY<restartY+restartHeight && stage==8)
   {
     setup();
     stage=0; 
   } 
   else if(mouseX>restartX && mouseX<restartX+restartWidth && mouseY>260 && mouseY<260+restartHeight && stage==10)
   {
     exit();
     button1.play();
     button1.rewind();      
   }
   else if(mouseX>restartX && mouseX<restartX+restartWidth && mouseY>restartY && mouseY<restartY+restartHeight && stage==10)
   {
     setup();
     stage=0;
     button1.play();
     button1.rewind();  
   } 
   else if(mouseX>restartX && mouseX<restartX+restartWidth && mouseY>260 && mouseY<260+restartHeight && stage==9)
   {
     exit();
     button1.play();
     button1.rewind();      
   }
   else if(mouseX>restartX && mouseX<restartX+restartWidth && mouseY>restartY && mouseY<restartY+restartHeight && stage==9) //choosing the next level
   {
     button1.play();
     button1.rewind(); 
     if(passno==1)
     {
       stage=2;  
     }   
     else if(passno==2)
     {
       stage=3;  
     }  
     else if(passno==3)
     {
       stage=4;  
     }
     else if(passno==4)
     {
       stage=5;  
     }
     else if(passno==5)
     {
       stage=6;  
     }
     else if(passno==6)
     {
       stage=10;  
     }
   }
   
   
   for(int i=0; i<5; i++) //changing the pipe colors to that of the stones if the road is complete 
   { 
     for(int j=0; j<5; j++)
     {
       if(stage==1 && pipe1[i][j]>=0 && pipe1[i][j]<3 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe1[i][j]++;
         button2.play();
         button2.rewind();  
       }
       else if(stage==1 && pipe1[i][j]==3 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe1[i][j]=0;
         button2.play();
         button2.rewind();  
       }
       else if(stage==1 && pipe1[i][j]==4 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe1[i][j]=5;
         button2.play();
         button2.rewind();  
       }
       else if(stage==1 && pipe1[i][j]==5 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe1[i][j]=4;
         button2.play();
         button2.rewind();  
       }
       
       
       if(stage==2 && pipe2[i][j]>=0 && pipe2[i][j]<3 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe2[i][j]++; 
         button2.play();
         button2.rewind();  
       }
       else if(stage==2 && pipe2[i][j]==3 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe2[i][j]=0;
         button2.play();
         button2.rewind();  
       }
       else if(stage==2 && pipe2[i][j]==4 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe2[i][j]=5;
         button2.play();
         button2.rewind();  
       }
       else if(stage==2 && pipe2[i][j]==5 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe2[i][j]=4;
         button2.play();
         button2.rewind();  
       }
       
       
       if(stage==3 && pipe3[i][j]>=0 && pipe3[i][j]<3 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe3[i][j]++; 
         button2.play();
         button2.rewind();  
       }
       else if(stage==3 && pipe3[i][j]==3 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe3[i][j]=0;
         button2.play();
        button2.rewind();  
       }
       else if(stage==3 && pipe3[i][j]==4 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe3[i][j]=5;
         button2.play();
         button2.rewind();  
       }
       else if(stage==3 && pipe3[i][j]==5 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe3[i][j]=4;
         button2.play();
         button2.rewind();  
       }
       
       
       if(stage==4 && pipe4[i][j]>=0 && pipe4[i][j]<3 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe4[i][j]++; 
         button2.play();
         button2.rewind();  
       }
       else if(stage==4 && pipe4[i][j]==3 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe4[i][j]=0;
         button2.play();
         button2.rewind();  
       }
       else if(stage==4 && pipe4[i][j]==4 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe4[i][j]=5;
         button2.play();
        button2.rewind();  
       }
       else if(stage==4 && pipe4[i][j]==5 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe4[i][j]=4;
         button2.play();
         button2.rewind();  
       }
       
       
       if(stage==5 && pipe5[i][j]>=0 && pipe5[i][j]<3 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
        pipe5[i][j]++; 
        button2.play();
        button2.rewind();  
       }
       else if(stage==5 && pipe5[i][j]==3 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe5[i][j]=0;
         button2.play();
         button2.rewind();  
       }
       else if(stage==5 && pipe5[i][j]==4 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe5[i][j]=5;
         button2.play();
         button2.rewind();  
       }
       else if(stage==5 && pipe5[i][j]==5 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe5[i][j]=4;
         button2.play();
         button2.rewind();  
       }

       
       if(stage==6 && pipe6[i][j]>=0 && pipe6[i][j]<3 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
        pipe6[i][j]++; 
        button2.play();
        button2.rewind();  
       }
       else if(stage==6 && pipe6[i][j]==3 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe6[i][j]=0;
         button2.play();
         button2.rewind();  
       }
       else if(stage==6 && pipe6[i][j]==4 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe6[i][j]=5;
         button2.play();
         button2.rewind();  
       }
       else if(stage==6 && pipe6[i][j]==5 && mouseX>225+50*j && mouseX<275+50*j && mouseY>75+50*i && mouseY<125+50*i)
       {
         pipe6[i][j]=4;
         button2.play();
         button2.rewind();  
       }
     }
   }
       
 }
 //finish


