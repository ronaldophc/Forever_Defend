if (keyboard_check_pressed(vk_escape)) {
	if(global.menu == noone) {
		if(room == rm_game) {
			room_goto(rm_esc);
		} else if(room = rm_esc) {
			room_goto(rm_game);	
		}
	} else {
		global.menu = noone;
	}
}
if(room = rm_esc) {
	state();
}