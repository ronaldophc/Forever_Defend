if (keyboard_check_pressed(vk_escape)) {
	if(room == rm_game) {
		
		room_goto(rm_esc);
	} else if(room = rm_esc) {
		room_goto(rm_game);	
	}
}
if(room = rm_esc) {
	state();
}