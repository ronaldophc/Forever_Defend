var _height = display_get_gui_height();
var _width = display_get_gui_width();
var _sprite = spr_banner_horizontal;
var _tamh = sprite_get_height(_sprite);
var _tamw = sprite_get_width(_sprite);
var _qtd = 3;
if(instance_exists(obj_player)) {
	#region Equips
	var _y = _height - _tamh - 32;
	if(_qtd - 1 == 0) {
		draw_sprite_stretched(_sprite, 1, 32, _y, _tamw * (_qtd), _tamh);
	} else {
		draw_sprite_stretched(_sprite, 1, 32, _y, _tamw * (_qtd - 1), _tamh);
	}

	_sprite = spr_carved_regular;
	var _tam2h = sprite_get_height(_sprite);
	var _tam2w = sprite_get_width(_sprite);
	var _itens = ["hand", "axe", "hammer"];
	for(var _i = 1; _i < _qtd + 1; _i++) {
		draw_sprite(_sprite, 1, 64 * _i + 32, _y + (_tamh / 2) - 16);
		if(_itens[_i - 1] == "hand") {
			if(obj_player.weapon == "hand") {
				draw_sprite(spr_pointer_select, 1, 64 * _i + 32, _y + (_tamh / 2) - 16);
			}
		} else if(_itens[_i - 1] == "axe") {
			draw_sprite(spr_axe, 1,  64 * _i + 32, _y + (_tamh / 2) - 16);
			if(obj_player.weapon == "axe") {
				draw_sprite(spr_pointer_select, 1, 64 * _i + 32, _y + (_tamh / 2) - 16);
			}
		} else if(_itens[_i - 1] == "hammer") {
			draw_sprite(spr_hammer, 1,  64 * _i + 32, _y + (_tamh / 2) - 16);
			if(obj_player.weapon == "hammer") {
				draw_sprite(spr_pointer_select, 1, 64 * _i + 32, _y + (_tamh / 2) - 16);
			}
		}
	}
	#endregion
	
	#region Resources
	draw_sprite_stretched(spr_banner_horizontal, 1, _width / 2, 16, _width / 2 - 16, _tamh / 1.5);
	draw_sprite(spr_tree_icon, 1, _width - 130, _tamh / 3);
	draw_sprite(spr_g_idle, 1, _width - 260, _tamh / 3);
	draw_sprite(spr_sheep_icon, 1, _width - 400, _tamh / 3);
	draw_set_valign(1);
	draw_set_halign(1);
	draw_set_font(fnt_resources_ui);
	draw_set_color(make_color_rgb(62, 134, 152));
	draw_text(_width - 120 + sprite_get_width(spr_tree_icon), _tamh / 3, string(obj_player.wood));
	draw_text(_width - 230 + sprite_get_width(spr_tree_icon) / 2, _tamh / 3, string(obj_player.gold));
	draw_text(_width - 360 + sprite_get_width(spr_tree_icon) / 2, _tamh / 3, string(obj_player.food));
	draw_set_color(c_white);
	draw_set_font(-1);
	draw_set_valign(-1);
	draw_set_halign(-1);
	#endregion
	//debug_message(game_get_speed(gamespeed_fps), 64, 96);
}