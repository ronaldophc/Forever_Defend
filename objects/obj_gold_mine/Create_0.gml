state = noone;
state_txt = "";
cooldown = 30;
recovery_time = game_get_speed(gamespeed_fps) * cooldown;
recovery_timer = 0;
image_ind = 0;
sprite = spr_gold_mine;
life = 0;
qtd = 3;
level = 1;
area = 100;
dist = undefined;
menu = false;
button_ind = 0;
upgrade_cost = 20;
button = function() {
	if(sprite_exists(spr_button_e)) {
		button_ind += 2 / game_get_speed(gamespeed_fps);
		button_ind %= 2;
	}
}

att_upgrade = function () {
	cooldown -= 5;
	qtd += 1;
	recovery_time = game_get_speed(gamespeed_fps) * cooldown;
	upgrade_cost += 10;
	level += 1;
}

inc_life = function() {
	if(life < 5) life++;
}

ver_dist = function() {
	if(instance_exists(obj_player)) {
		dist = point_distance(obj_player.x, obj_player.y, x, y);
	} else {
		dist = undefined;	
	}
	if(dist <= area) {
		if(keyboard_check_pressed(ord("E"))) inc_life();	
	}
}

state_idle = function () {
	state_txt = "idle";
	image_ind = 0;
	ver_dist();
	button();
	if(life >= 5) {
		state = state_load;	
		recovery_timer = recovery_time;
		if(instance_exists(obj_player)) {
			obj_player.gold += qtd;
			instance_create_layer(x, y + (sprite_height / 1.7), "Resources", obj_g_spawn);
		}
	}
}

state_load = function () {
	state_txt = "load";
	image_ind = 2;
	recovery_timer--;
	life = 5;
	if(recovery_timer <= 0) {
		life = 0;
		state = state_idle;	
	}
}

state = state_idle;