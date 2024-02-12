if(mouse_check_button_pressed(mb_left)) {
	if(point_in_rectangle(mouse_x, mouse_y, x - 35, y - 70, x + 35, y + 10)
	&& obj_player.weapon == obj_player.weapons[0]
	&& global.buy == noone) {
		global.menu = id;
	}
}
state();
