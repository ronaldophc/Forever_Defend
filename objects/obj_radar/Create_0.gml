x = 8;
y = 8;
scale = 0.12;
room_width_scaled = room_width - 64 * 4;
room_height_scaled = room_height - 1472;
width = round(room_width_scaled * scale);
height = round(room_height_scaled * scale);
objects_to_draw = [
	obj_colision, c_dkgray,
	obj_player, c_red,
	obj_enemy, c_maroon,
	obj_archer, c_blue,
	]