w = getWidth(); // get width of active image in pixels
h = getHeight(); // get height of active image in pixels
n = 0; // row counter
for(x=0; x<w; x++){
	for(y=0; y<h; y++){
		z = getPixel(x, y);
		setResult("X", n, x);
		setResult("Y", n, y);
		setResult("Z", n, z);
		n++;
	}
}
updateResults();