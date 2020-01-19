/*
 * 2020/01/19
 * Glitch image
 */

var img;

function preload() {
  img = loadImage('data/pool.jpg');
}

function setup() {
  createCanvas(windowWidth, windowHeight);
  image(img, 0, 0);
}


function draw() {
  var x1 = floor(random(width));
  var y1 = floor(random(height));

  var x2 = round(x1 + random(-17, 17));
  var y2 = round(y1 + random(-5, 5));

  var w = floor(random(10, 50));
  var h = height - 150;

  set(x2, y2, get(x1, y1, w, h));
}

function keyReleased() {
  if (key == 's' || key == 'S') saveCanvas(gd.timestamp(), 'png');
  if (keyCode == DELETE || keyCode == BACKSPACE) {
    clear();
    image(img, 0, 100);
  }
}
