if(target != noone) {
	if(!instance_exists(target)) {
		instance_destroy();
		exit;
	}
	var _dist = point_distance(x, y, target.x, target.y);
	if(_dist < 30) {
		instance_destroy();
		target.life -= 50;
		exit;
	}
}
if(point_distance(x, y, _x, _y) > usou.area + 50) instance_destroy();