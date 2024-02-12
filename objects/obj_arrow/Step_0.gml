if(target != noone) {
	if(!instance_exists(target)) {
		instance_destroy();
		exit;
	}
	var _dist = point_distance(x, y, target.x, target.y);
	if(_dist < 30) {
		target.life -= usou.damage;
		instance_destroy();
		exit;
	}
}
if(point_distance(x, y, xstart, ystart) > usou.area + 75) instance_destroy();