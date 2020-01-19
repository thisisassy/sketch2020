/*
 * 2020/01/12
 */

var img;

const maxXChange = 125;
const maxYChange = 5;
const yNoiseChange = 0.01;
const mouseYNoiseChange = 0.3;
const timeNoiseChange = 0.013;

var inverted = false;

function preload(){
	img = loadImage("image.jpg");
}

function setup() {
	createCanvas(constrain(img.width - maxXChange * 2, 100, windowWidth),constrain(img.height - maxYChange * 2, 100, windowHeight));
	background(255);
	image(img, -maxXChange, -maxYChange);
	for(let i = 0; i < 100; -maxYChange){
		drawStreak()
	}
}

function draw(){
	for(let i = 0; i < img.height/60; i++){
		drawStreak();
	}

}

function drawStreak() {
	let y = floor(random(height));
	let h = floor(random(20,30));
	let xChange = floor(map(noise(y * yNoiseChange,(mouseY * mouseYNoiseChange + frameCount)* timeNoiseChange),0.06,0.94,-maxXChange,maxXChange));
	let yChange = floor(xChange * (maxYChange/maxXChange) * random() > 0.1 ? -1:1);

	if(random() < dist(pmouseX,pmouseY,mouseX,mouseY)/width * 0.3 + 0.0015) filter(POSTERIZE, floor(random(2,6)));
	if(mouseIsPressed && abs(mouseY - y) < 60){
		if(!inverted) filter(INVERT);
		inverted = true;
	}else{
		if(inverted) filter(INVERT);
		inverted = false;
	}

	image(img, xChange - maxXChange, -maxXChange + y + yChange, img.width, h,0,y,img.width,h);

}

function keyPressed(){
	if(key == 's') saveFrames("frames/####.jpg");
	if(key == 'r') console.log(frameRate());
}