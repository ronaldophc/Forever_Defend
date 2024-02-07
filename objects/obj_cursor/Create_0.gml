#region Cursor
window_set_cursor(cr_none)
target = noone;
cursor_sprite = spr_pointer_arrow;
change_cursor = function () {
	if(instance_position(mouse_x, mouse_y, obj_tree)) {
		var _tree = instance_position(mouse_x, mouse_y, obj_tree);
		if(!instance_exists(obj_player)) exit;
		var _x1 = obj_player.x;
		var _y1 = obj_player.y;
		var _x2 = _tree.x;
		var _y2 = _tree.y;
		if(point_distance(_x1, _y1, _x2, _y2) < 96) {
			cursor_sprite = noone;
			draw_sprite(spr_pointer_select, 1, _tree.x, _tree.y);
			target = id;
		}
	} else {
		cursor_sprite = spr_pointer_arrow;
	}
}

#endregion