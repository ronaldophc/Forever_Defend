randomize();
cooldown = 15;
recovery_time = game_get_speed(gamespeed_fps) * cooldown;
recovery_timer = 0;
lifes = 3;
state = noone;
state_txt = "idle";
image_ind = 0;
image_spd = random_range(9, 11) / game_get_speed(gamespeed_fps);
image_numb = 1;
sprite = spr_tree;
qtd = 3;
upgrade_cost = 20;
level = 1;

att_upgrade = function () {
	cooldown -= 2;
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

state_idle = function () {
	state_txt = "idle";
	image_spd = random_range(1, 12) / game_get_speed(gamespeed_fps);
	ajusta_sprite(spr_tree);
}

state_damage = function () {
	state_txt = "damage";
	image_spd = 4 / game_get_speed(gamespeed_fps);
	if(sprite != spr_tree_damaged) {
		lifes--;
	}
	ajusta_sprite(spr_tree_damaged);
	
	if(image_ind >= 1.8) {
		if(lifes <= 0) {
			recovery_timer = recovery_time;
			lifes = 3;
			obj_player.wood += qtd;
			var _i = instance_create_layer(x, y, "Resources", obj_tree_spawn);
			_i.qtd = qtd;
			state = state_chopped;
		} else {
			state = state_idle;
		}
	}
}

state_chopped = function () {
	ajusta_sprite(spr_tree_chopped);
	state_txt = "chopped";
	recovery_timer--;
	if(recovery_timer <= 0) {
		lifes = 3;
		state = state_idle;
	}
}

state = state_idle;