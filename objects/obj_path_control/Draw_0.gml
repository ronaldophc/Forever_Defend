//var cur_x = floor(tile_size / 2);
//var cur_y = floor(tile_size / 2);

//for (var index_1 = 0; index_1 < grid_width; index_1++) {
//	for (var index_2 = 0; index_2 < grid_height; index_2++) {
			
//		if (is_undefined(grid[index_1][index_2])) {
//			draw_set_valign(1);
//			draw_set_halign(1);
//			draw_text(cur_x, cur_y, weights[index_1][index_2]);
//			draw_set_valign(-1);
//			draw_set_halign(-1);
//		}
			
//		cur_y += tile_size;
			
//	}
		
//	cur_x += tile_size;
//	cur_y = floor(tile_size / 2);
		
//}

// Começa no 9 e 25
// Termina no 37 e 36


var _ix = 9;
var _iy = 25;
var _ex = 37;
var _ey = 36;
var _col = c_green;
var _col2 = c_red;

if(global.buy = spr_archer_buy) {
	_col = c_red;
	_col2 = c_red;
	for(var _i = _ix; _i <= _ex; _i++) {
		for(var _j = _iy; _j <= _ey; _j++) {
			var _x = _i * 64;
			var _y = _j * 64;
			if (is_undefined(grid[_i][_j])) {	
				draw_set_alpha(0.3);
				draw_rectangle_color(_x, _y, _x + 64, _y + 64, _col, _col, _col, _col, false);	
				draw_set_alpha(1);
			} else {
				draw_set_alpha(0.3);
				var _lands = grid[_i][_j];
				if(is_undefined(_lands)) {
					_col2 = c_red;
				} else {
					if(_lands.object_index == obj_land) {
						if(_lands.hold == noone) _col2 = c_green;
					} else {
						_col2 = c_red;	
					}
				}
				if(mouse_check_button_released(mb_left)) {
					var _land = grid[mouse_x div 64, mouse_y div 64];
					if(!is_undefined(_land)) {
						if(_land.object_index == obj_land) {
							if(_land.hold == noone) {
								var _valuef = global.archer_f + (instance_number(obj_archer) * 10);
								var _valueg = global.archer_g + (instance_number(obj_archer) * 10);
								obj_player.gold -= _valueg;
								obj_player.food -= _valuef;
								var _archer = instance_create_layer(_land.x + 32, _land.y + 48, "Battle", obj_archer);
								_land.hold = _archer;
								global.buy = noone;
								global.menu = noone;
								if(instance_exists(obj_buy)) instance_destroy(obj_buy);
							}
						}
					}
				}
				draw_rectangle_color(_x, _y, _x + 64, _y + 64, _col2, _col2, _col2, _col2, false);	
				draw_set_alpha(1);
			}
		}
	}
}

if(global.buy = spr_lands) {
	_col = c_green;
	_col2 = c_red;
	

	for(var _i = _ix; _i <= _ex; _i++) {
		for(var _j = _iy; _j <= _ey; _j++) {
			var _x = _i * 64;
			var _y = _j * 64;
			if (is_undefined(grid[_i][_j])) {	
				draw_set_alpha(0.3);				
				draw_rectangle_color(_x, _y, _x + 64, _y + 64, _col, _col, _col, _col, false);	
				draw_set_alpha(1);
			} else {
				draw_set_alpha(0.3);
				draw_rectangle_color(_x, _y, _x + 64, _y + 64, _col2, _col2, _col2, _col2, false);	
				draw_set_alpha(1);
			}
		}
	}
	if(mouse_check_button_released(mb_left)) {
		var _mx = mouse_x div 64;
		var _my = mouse_y div 64;
		if(obj_path_control.grid[_mx][_my] == undefined) {
			obj_path_control.grid[_mx][_my] = id;
		
			var _start = [floor(610 div 64), floor(2400 div 64)];
			var _stop = [floor(1472 div 64), floor(1472 div 64)];
			var _path = script_execute(scr_a_star_search, obj_path_control.grid, obj_path_control.weights, _start, _stop);
			if(is_undefined(_path)) {
				obj_path_control.grid[_mx][_my] = undefined;
			} else {
				instance_create_layer(_mx * 64, _my * 64, "Battle", obj_land);
				with(obj_enemy) {
					path = create_path(x, y, obj, obj);
				}
			}
		}

	}
}