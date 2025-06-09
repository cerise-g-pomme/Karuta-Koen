function math_ease(value){//Returns a gaussian curved normalized between 0 and 1
	return (sin(2*pi*((value*0.5)-0.25))+1)*0.5;
}