/*
 * 2020/01/01
 * Cube / Sphere
 */
import gifAnimation.*;

GifMaker gifExport;

float t;
float theta;
int maxFrameCount = 60;

int a = 1;
int space = 50;

color c1;
color c2;

int numFrames = 50;

void setup() {
  size(500, 500, P3D);
  frameRate(30);

  gifExport = new GifMaker(this, "sphere.gif");
  gifExport.setRepeat(0);
  gifExport.setQuality(10);
  gifExport.setDelay(20);
}

void draw() {
  background(10);
  translate(width/2, height/2, 200);
  t = (float)frameCount/maxFrameCount;
  theta = PI * t;

  float t = 1.0 * (frameCount - 1)/numFrames;

  //lights
  directionalLight(245, 245, 245, 300, -200, -200);
  ambientLight(240, 240, 240);

  //rotate the whole cube
  rotateY(radians(145));
  rotateX(radians(45));

  for (int x = -space; x <= space; x += 20) {
    for (int y = -space; y <= space; y += 20) {
      for (int z = -space; z <= space; z += 20) {

        float offSet = ((x*y*z))/a;
        float sz = map(sin(-theta+offSet), -1, 1, -0, 20);

        color c1 = color(250, 44, 50);
        color c2 = color(210, 90, 10);

        if ((x*y*z)%30 == 0) {
          fill(c1);
          //stroke(c2);
          noStroke();
        } else {
          fill(c2);
          noStroke();
        }

        shp(x, y, z, sz);
        shp(y, z, x, sz);
        shp(z, x, y, sz);
      }
    }
  }
  //if (frameCount <= numFrames) {
  //  saveFrame("frames/###.jpg");
  //}
  if (frameCount <= 30*5) {
    gifExport.addFrame();
  } else {
    gifExport.finish();
  }
}

void shp(float x, float y, float z, float d) {
  pushMatrix();
  translate(x, y, z);
  //box(d);
  sphere(d);
  popMatrix();
}
