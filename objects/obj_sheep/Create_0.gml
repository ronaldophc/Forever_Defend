randomize();
cooldown = 45;
recovery_time = game_get_speed(gamespeed_fps) * cooldown;
recovery_timer = 0;
state = noone;
state_txt = "";
dir_y = 0;
dir_x = 0;
sprite = spr_sheep_idle;
image_ind = 0;
image_spd = 10 / game_get_speed(gamespeed_fps);
image_numb = sprite_get_number(sprite);
xscale = 1;
life = 3;
walk_time = random_range(2.7, 3.3) * game_get_speed(gamespeed_fps);
walk_timer = walk_time;
alpha = 0;
alpha2 = 1;
qtd = 2;
upgrade_cost = 20;
level = 1;

att_upgrade = function () {
	cooldown -= 5;
	qtd += 1;
	recovery_time = game_get_speed(gamespeed_fps) * cooldown;
	upgrade_cost += 10;
	level += 1;
}

ajusta_sprite = function(_sprite) {
	if(sprite != _sprite) image_ind = 0;
	sprite = _sprite;
	image_numb = sprite_get_number(sprite);
	image_ind += image_spd;
	image_ind %= image_numb;
}

walk_loss = function () {
	if(walk_timer <= 0) {
		state = state_walking;
	} else {
		walk_timer--;	
	}
}

walking = function () {
	xscale = dir_x;
	move_and_collide(dir_x, dir_y, obj_colision);
	x = clamp(x, 734, 2400);
	y = clamp(y, 94, 930);
}
	
take_damage = function () {
	if(state != state_die) {
		alpha = 1;
		life--;
	}
}
	
die = function () {
	if(life <= 0) {
		if(instance_exists(obj_player)) {
			obj_player.food += qtd;
		}
		var _i = instance_create_layer(x, y, "Resources", obj_sheep_spawn);
		_i.qtd = qtd;
		recovery_timer = recovery_time;
		state = state_die;
	}
}

state_idle = function () {
	state_txt = "idle";
	ajusta_sprite(spr_sheep_idle);
	walk_loss();
	die();
}

state_walking = function () {
	state_txt = "walking";
	if(sprite = spr_sheep_idle) {
		dir_x = choose(1, -1);
		dir_y = choose(.2, -.2);
	}
	ajusta_sprite(spr_sheep_bouncing);
	walking();
	die();
	if(image_ind + image_spd >= image_numb) {
		walk_timer = walk_time;
		state = state_idle;
	}
}

state_die = function () {
	state_txt = "die";
	if(alpha2 <= 0) {
		recovery_timer--;
		if(recovery_timer <= 0) {
			life = 3;
			alpha2 = 1;
			x = xstart;
			y = ystart;
			state = state_idle;
		}
	} else {
		alpha2 -= 0.03;
	}
}


state = state_idle;