
class Agent {

  // current position
  float x = randX;
  float y = randY;

  // curve parameters
  float l = 1;
  float t;

  // stroke weight and shade
  float weight; 
  float shade;
  float hue;
  float myProbTurn;
  float myMaxStep;
  
  // base colour
  float baseHue = random(0, 359);
  
  int count=5;


  // create a new agent
  Agent() {
    reset();
  }

  void update() {
    setseed();
    
    float px = x;
    float py = y;

    if(MODE==3)l += random(0, 2*maxStep);
    else if(MODE==5)l += random(-myMaxStep, myMaxStep);
    else l += random(-maxStep, maxStep);
    x = x + l * cos(t);
    y = y + l * sin(t);

    line(px, py, x, y);
    
    if(MODE==5) t += myProbTurn;
    t += probTurn;

    // draw the line
    strokeWeight(weight);
    stroke(hue, 100, shade, 33);
    line(px, py, x, y);

    // reset the agent if it leaves the canvas
    if (x < 0 || x > width - 1 || y < 0 || y > height - 1) {
      reset();
    }

    // reset the agent if it gets too big
    //if (weight > 0.25 * height) {
      //reset();
    //}
  }

  void reset() {
    count++;
    
    switch(MODE){
      case 1:
        x = randX;
        y = randY;
        setseed();
        weight = random(0, 10)+1;
        //setseed();
        probTurn = random(0.02, 0.07);
        //setseed();
        maxStep = random(0.1, 0.2);
        break;
      case 2:
        setseed();
        float m = 0.02 * height; // margin
        x = random(m, width - m);
        y = random(m, height - m);
        weight = random(10, 25)+1;
        probTurn = 0.01;
        maxStep = 0.3;
        break;
      case 3:
        x = randX;
        y = randY;
        weight = random(0, 16)+1;
        probTurn = 0.1;
        maxStep = 0.1;
        break;
      case 4:
        //randomSeed(System.currentTimeMillis());
        x = randX;
        y = randY;
        weight = random(3, 50)+1;
        probTurn = random(0.01, 0.03);
        maxStep = random(0.1, 0.2);
        break;
      case 5:
        x = randX;
        y = randY;
        setseed();
        weight = random(0, 8)+1;
        myProbTurn = random(0.01, 0.1);
        myMaxStep = random(0.1, 0.3);
        break;
    }
    t = random(TWO_PI);
    shade = random(0, 255);
    
    //setseed();
    
    // pick a hue
    if(count % 10 == 0)baseHue = (baseHue + random(20, 30)) % 360; 
    hue = (baseHue + random(-15, 15)) % 360;
  }

  void draw() {
  }
}