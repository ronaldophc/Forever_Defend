state = noone;
state_txt = "";
image_numb = 0;
image_ind = 0;
image_spd = 10 / game_get_speed(gamespeed_fps);
sprite = spr_archer_idle;
xscale = 1;
area = 200;
enemy = noone;
atacou = false;
idepth = depth;
if(!place_snapped(64, 64)) move_snap(64, 64);
run_sprite = function () {
	image_numb = sprite_get_number(sprite);
	image_ind += image_spd;
	image_ind %= image_numb;
}

run_sprite_attack = function () {
	if(direction > 337.5 || direction <= 22.5) {
		sprite = spr_archer_shoot_right;
		xscale = 1;
	} else if(direction > 22.5 && direction <= 67.5) {
		sprite = spr_archer_shoot_northeast;
		xscale = 1;
	} else if(direction > 67.5 && direction <= 112.5) {
		sprite = spr_archer_shoot_top;
		xscale = 1;
	} else if(direction > 112.5 && direction <= 157.5) {
		sprite = spr_archer_shoot_northeast;
		xscale = -1;
	} else if(direction > 157.5 && direction <= 202.5) {
		sprite = spr_archer_shoot_right;
		xscale = -1;
	} else if(direction > 202.5 && direction <= 247.5) {
		sprite = spr_archer_shoot_southeast;
		xscale = -1;
	} else if(direction > 247.5 && direction <= 292.5) {
		sprite = spr_archer_shoot_down;
		xscale = 1;
	} else if(direction > 292.5 && direction <= 337.5) {
		sprite = spr_archer_shoot_southeast;
		xscale = 1;
	}
	image_numb = sprite_get_number(sprite);
	image_ind += image_spd;
	image_ind %= image_numb;
}

search_enemy = function () {
	if(enemy == noone) {
		var _teste = collision_circle(x, y, area, obj_enemy, false, true);
		if(_teste) {
			enemy = _teste;
		}
	}
}

state_idle = function () {
	state_txt = "idle";
	image_spd = 10 / game_get_speed(gamespeed_fps);
	sprite = spr_archer_idle;
	run_sprite();
	search_enemy();
	if(enemy != noone) {
		if(point_distance(x, y, enemy.x, enemy.y) >= area) {
			enemy = noone;	
		} else {
			state = state_attack;
			image_ind = 0;	
		}
	}
}

state_attack = function () {
	state_txt = "attack";
	image_spd = 10 / game_get_speed(gamespeed_fps);
	if(instance_exists(enemy)) {
		if(point_distance(x, y, enemy.x, enemy.y) >= area) {
			enemy = noone;
			state = state_idle;
			atacou = false;
		} else {
			direction = point_direction(x, y - 20, enemy.x, enemy.y);
			if(image_ind + image_spd == image_numb - 1 && !atacou) {
				var _arrow = instance_create_layer(x, y - 22, "Battle", obj_arrow, {speed: 50, direction: direction, image_angle: direction, dest_y: enemy.y, dest_x: enemy.x})
				_arrow.target = enemy;
				_arrow.usou = obj_archer;
				atacou = true;
			}
		}
	} else {
		enemy = noone;
		state = state_idle;
		atacou = false;
	}
	run_sprite_attack();
	if(image_ind + image_spd >= image_numb) {
		enemy = noone;
		atacou = false;
		state = state_idle;
	}
}

state = state_idle;