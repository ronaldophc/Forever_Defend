function debug_message(_message, _x, _y) {
	draw_set_valign(1);
	draw_set_halign(1);
	draw_set_font(fnt_debug);
	draw_text(_x, _y, string(_message));
	draw_set_font(-1);
	draw_set_valign(-1);
	draw_set_halign(-1);
}

function tira_grid(_x, _y) {
	var _node_x = floor(_x / 64);
	var _node_y = floor(_y / 64);
	obj_path_control.grid[_node_x][_node_y] = undefined;
}

function coloca_grid(_x, _y, _obj) {
	if(room = rm_game) {
		if(_x >= 0 && _x <= room_width && _y >= 0 && _y <= room_height) {
			var _relative_x = (_x div 64);
			var _relative_y = (_y div 64);
			obj_path_control.grid[_relative_x][_relative_y] = _obj;
		}
	}
}



