width = read_ini("graphics", "resolution_width");
height = read_ini("graphics", "resolution_height");
game_width = 1920;
game_height = 1080;
window_set_size(width, height);
surface_resize(application_surface, game_width, game_height);
display_set_gui_size(game_width, game_height)
alarm[0]= 1;
view_target = noone;
view_vel = .1;
ini_open("settings.ini");
anti_ali = ini_read_real("graphics", "anti-aliasing", 0);
vsync = ini_read_real("graphics", "vsync", 0);
ini_close();
display_reset(anti_ali, vsync);
passou = 0;



follow_player = function () {
	if(instance_exists(obj_player) && room == rm_game) {
		view_target = obj_player;
		var _x1 = view_target.x - game_width / 2;	
		var _y1 = view_target.y - game_height / 2;
		var _c_x = camera_get_view_x(view_camera[0]);
		var _c_y = camera_get_view_y(view_camera[0]);
		var _c_w = camera_get_view_width(view_camera[0]);
		var _c_h = camera_get_view_height(view_camera[0]);
		var _cam_x = lerp(_c_x, _x1, view_vel);
		var _cam_y = lerp(_c_y, _y1, view_vel);
		//_cam_x = clamp(_cam_x, 0, room_width - _c_w);
		//_cam_y = clamp(_cam_y, 0, room_height - _c_h);
		camera_set_view_pos(view_camera[0], _cam_x, _cam_y);
	} else {
		state = no_follow;
	}
}

atualizar = function () {
	width = read_ini("graphics", "resolution_width");
	height = read_ini("graphics", "resolution_height");
	window_set_size(width, height);
	surface_resize(application_surface, 1920, 1080);
	display_set_gui_size(1920, 1080);
	window_center();
}

no_follow = function () {
	view_target = noone;
}

state = follow_player;
