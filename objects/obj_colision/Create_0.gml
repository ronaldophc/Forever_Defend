
if(room = rm_game) {
	if(x >= 0 && x <= room_width && y >= 0 && y <= room_height) {
		var _relative_x = (x div 64);
		var _relative_y = (y div 64);
		obj_path_control.grid[_relative_x][_relative_y] = id;
	}
}
