if(alpha <= 0.07) {
	alpha = 0;
} else {
	alpha = lerp(alpha, 0, 0.08);
}
if(y > obj_player.y) {
	depth = -y;
} else {
	depth = idepth;	
}
state();