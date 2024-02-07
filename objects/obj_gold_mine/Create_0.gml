state = noone;
state_txt = "";
idepth = depth;
recovery_time = game_get_speed(gamespeed_fps) * 10;
recovery_timer = 0;
image_ind = 0;
sprite = spr_gold_mine;
life = 0;

inc_life = function() {
	if(life < 3) life++;
}

state_idle = function () {
	state_txt = "idle";
	image_ind = 0;
	if(life >= 3) {
		state = state_load;	
		recovery_timer = recovery_time;
		if(instance_exists(obj_player)) {
			obj_player.gold += 5;
			instance_create_layer(x, y + (sprite_height / 1.7), "Resources", obj_g_spawn);
		}
	}
}

state_load = function () {
	state_txt = "load";
	image_ind = 2;
	recovery_timer--;
	life = 3;
	if(recovery_timer <= 0) {
		life = 0;
		state = state_idle;	
	}
}

state = state_idle;