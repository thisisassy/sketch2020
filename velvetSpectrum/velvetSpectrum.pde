/*
 * 2020/01/12
 * Velvet Spectrum
 */

int numberOfDots;
int minNumberOfDots = 100;
int maxNumberOfDots = 200;

float startColor;
Vec4f[] colors;
float[] sizes;
PVector[] offsets;

PVector easeMouse;
PVector prevMouse;
float easing = 0.09;
boolean isMousePressed = false;

void setup() {
  size(640, 640);
  noStroke();
  colorMode(HSB, 100);
  background(20, 100, 100);
  restartValues();
}

void restartValues() {
  int numberOfDots = (int)random(100, 200);
  
  colors = new Vec4f[numberOfDots];
  sizes = new sizes[numberOfDots];
  offsets = new PVector[numberOfDots];

  for (int i =0; i < numberOfDots; i++) {
    colors[i] = new Vec4f(0, 100, 100, 100);
    sizes[i] = random(2, 6);
    offsets[i] = new PVector(random(-5, 5), random(-5, 5));
  }

  startColor = random(0, 60);

  easeMouse = new PVector(mouseX, mouseY);
  prevMouse = new PVector(mouseX, mouseY);
}

void updateValues() {
  float hue = sin(frameCount/100) * 20 + startColor;
  for (int i=0; i < numberOfDots; i++) {
    float colour = hue + sin(i/numberOfDots*TWO_PI)*20;
    float brightness = abs(sin(i/numberOfDots*PI+PI/2)*100);
    colors[i].x = abs(colour);
    colors[i].y = brightness;
  }
}

void drawBrush(float x, float y) {
  for (int i=0; i<numberOfDots; i++) {
    fill(colors[i].x, colors[i].y, colors[i].z, colors[i].w);
    float angle = i/numberOfDots*TWO_PI;
    float _x = sin(angle) * 30 + x + offsets[i].x;
    float _y = cos(angle) * 30 + y + offsets[i].y;
    ellipse(_x, _y, sizes[i], sizes[i]);
  }
}

void draw() {
  easeMouse.x += (mouseX - easeMouse.x) * easing;
  easeMouse.y += (mouseY - easeMouse.y) * easing;

  updateValues();

  float distance = dist(prevMouse.x, prevMouse.y, easeMouse.x, easeMouse.y);
  if (distance<1) distance = 1;
  for (float i = 0; i < 1; i += 1.0/distance) {
    PVector pos = PVector.lerp(prevMouse, easeMouse, i);
    drawBrush(pos.x, pos.y);
  }

  prevMouse.x = easeMouse.x;
  prevMouse.y = easeMouse.y;
}

void keyPressed() {
  if (key == 's') { 
    saveFrame("images/####.jpg");
  } else {
    background(20, 100, 100);
    restartValues();
  }
}
