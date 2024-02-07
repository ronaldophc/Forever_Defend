state = noone;
state_txt = "";
obj = 1472;
image_numb = 0;
image_ind = 0;
image_spd = 10 / game_get_speed(gamespeed_fps);
sprite = spr_torch_red_idle;
xscale = 1;
life = 100;
path = undefined;
ind = 0;


run_sprite = function () {
	image_numb = sprite_get_number(sprite);
	image_ind += image_spd;
	image_ind %= image_numb;
}

chegou_dest = function () {
	obj_cam.passou++;
	instance_destroy();
}

state_idle = function () {
	state_txt = "idle";
	sprite = spr_torch_red_idle;
	run_sprite();
	if(room = rm_game) {
		if(point_distance(x, y, obj, obj) <= 64) {
			chegou_dest();	
		} else {
			path = create_path(x, y, obj, obj);
			state = state_inpath;	
		}
	}
}

state_inpath = function () {
	state_txt = "inpath";
	sprite = spr_torch_red_run;
	var _x = path[ind][0] * 64 + 32;
	var _y = path[ind][1] * 64;
	if(point_distance(x, y, obj, obj) <= 64) chegou_dest();
	move_towards_point(_x, _y, 3);
	if(point_distance(x, y, _x, _y) < speed) {
		if(ind < array_length(path) - 1) {
			ind++;
		} else {
			ind = 0;
			speed = 0;
			path = undefined;
			state = state_idle;
		}
		var _x1 = x div 64;
		var _x2 = path[ind][0];
		if(_x2 > _x1) xscale = 1;
		if(_x2 < _x1) xscale = -1;
	}
	run_sprite();
}

state = state_idle;

create_path = function(_x, _y, _targetx, _targety) {
		var _start = [floor(_x div 64), floor(_y div 64)];
		var _stop = [floor(_targetx div 64), floor(_targety div 64)];
		var _path = script_execute(scr_a_star_search, obj_path_control.grid, obj_path_control.weights, _start, _stop);
		return _path;
}