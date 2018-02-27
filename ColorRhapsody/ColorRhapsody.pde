/*
 * Agents move around the canvas leaving a trail.
 * 
 *
 */

Gui gui;

int MODE = 1;
int Presentation=1;

// list of agents
ArrayList<Agent> agents;

int agentsCount;

// maximum step size to take
float maxStep = 0.2;
// the probability % to turn
float probTurn;


int randX;
int randY;

// controls if agents interact with each other
// which creates other interesting effects
boolean interact = false;

int starttime;

void setup() {
  starttime = millis();

  //size(1280, 720);
  fullScreen();

  setseed();

  switch(MODE) {
  case 4:
  case 1:
    maxStep = random(0.1, 0.2);
    probTurn = random(0.02, 0.08);
    break;
  case 2:
    maxStep = 0.5;
    probTurn = random(0.01, 0.1);
  case 3:
    maxStep = 0.3;
    probTurn = random(0.01, 0.1);
    break;
  case 5:
    break;
  }

  randX = (int)random(width*0.25, width*0.75);
  randY = (int)random(height*0.25, height*0.75);
  agentsCount = height / 3;

  // setup the simple Gui
  gui = new Gui(this);

  gui.addSlider("MODE", 1, 5);
  gui.addSlider("Presentation", 1, 2);

  colorMode(HSB, 360, 100, 100, 100);
  if(modeIndex==0)background(0);

  createAgents();
}

void createAgents() {

  agents = new ArrayList<Agent>();
  for (int i = 0; i < agentsCount; i++) {
    setseed();
    Agent a = new Agent();
    agents.add(a);
  }
}

int[] modeSeq = {1, 2, 3, 4, 5};
int modeIndex=0;

void draw() {

  if (Presentation==1) {
    if (millis() - starttime >= modeTimeMin()*60000) {  //5min
      nextMode();
    }
  }

  if (MODE==4) background(0);

  // update all agents
  // draw all the agents
  for (Agent a : agents) {
    //setseed();
    a.update();
  }

  // draw all the agents
  for (Agent a : agents) {
    a.draw();
  }

  // draw Gui last
  gui.draw();

  // interactively adjust agent parameters
  //maxStep = map(mouseX, 0, width, 0.1, 3);
  //probTurn = map(mouseY, 0, height, 0.01, 0.1);
}

// enables shortcut keys for the Gui
// 'm' or 'M' to show menu, 'm' to partially hide, 'M' to fully hide
void keyPressed() {
  gui.keyPressed();

  if (key == ' ') {
    setup();
  }
}

void agentsCount(int n) {
  agentsCount = n;
  createAgents();
}

void MODE(int n) {
  MODE = n;
  setup();
}

void nextMode() {
  modeIndex++;
  MODE = modeSeq[modeIndex%modeSeq.length];
  println("Switch to mode: "+MODE);
  setup();
}

int modeTimeMin() {
  switch(MODE) {
  case 1:
    return 5;
  case 2:
    return 2;
  case 3:
    return 2;
  case 4:
    return 5;
  case 5:
    return 5;
  default:
    return 0;
  }
}

public void setseed() {
  randomSeed(System.currentTimeMillis());
}