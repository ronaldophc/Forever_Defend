if(read_ini("graphics", "full_screen") == "0") {
	window_set_fullscreen(true);
} else {
	window_set_fullscreen(false);
}