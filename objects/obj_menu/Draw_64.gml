if(global.menu != noone && instance_exists(obj_player)) {
	var _id = global.menu;
	var _guiw = display_get_gui_width();
	var _guih = display_get_gui_height();

	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);

	var _tamw = 250;
	var _tamh = 64;
	var _invx = _guiw / 2 - (_tamw / 2);
	var _invy = _guih / 2 - (_tamh / 2);
	var _objind = global.menu.object_index;	
	if(_objind == obj_tree || _objind == obj_gold_mine || _objind == obj_sheep) {
		if(_objind == obj_tree) {	
			if(!point_in_rectangle(_mx, _my, _invx, _invy - 150, _invx + _tamw, _invy + 150)
			&& mouse_check_button_pressed(mb_left)
			&& !point_in_rectangle(mouse_x, mouse_y, _id.x - 35, _id.y - 70, _id.x + 35, _id.y + 10)) {
				global.menu = noone;
			}
		} else {		
			if(!point_in_rectangle(_mx, _my, _invx, _invy - 150, _invx + _tamw, _invy + 150)
			&& mouse_check_button_pressed(mb_left)
			&& !instance_position(mouse_x, mouse_y, obj_sheep)
			&& !instance_position(mouse_x, mouse_y, obj_gold_mine)) {
				global.menu = noone;
			}		
		}
		draw_sprite_stretched(spr_banner_horizontal, 0, _invx, _invy - 95, _tamw, 200);
		draw_sprite_stretched(spr_ribbon_blue_full, 0, _invx - 48, _invy - 100, _tamw + 96, _tamh);
		draw_set_valign(1);
		draw_set_halign(0);
		draw_set_font(fnt_options);
		draw_set_color(c_black); 
		draw_text(_invx + (_tamw / 2) - 50, _invy - 80, "Level: " + string(_id.level));
		draw_set_font(fnt_upgrade);
		draw_set_color(c_dkgray);
		var _h = string_height("T");
		draw_text(_invx + (_tamw / 2) - 105, _invy - _h, "Drop(+1): " + string(_id.qtd));
		if(_objind == obj_gold_mine || _objind == obj_sheep) draw_text(_invx + (_tamw / 2) - 105, _invy, "Cooldown(-5s): " + string(_id.cooldown));
		if(_objind == obj_tree) draw_text(_invx + (_tamw / 2) - 105, _invy, "Cooldown(-2s): " + string(_id.cooldown));
		if(_id.level < 5) {
			draw_sprite(spr_g_idle, 0, _guiw / 2 - 60, _guih / 2 + 15);
			draw_text(_invx + (_tamw / 2) - 20, _invy + 45, string(_id.upgrade_cost));
		} else {
			draw_text(_guiw / 2 - 95, _guih / 2 + 15, "Max Level!");
		}	
		draw_set_color(c_white)
		draw_set_valign(-1);
		draw_set_halign(-1);
		draw_set_font(-1);
		var _posx = _guiw / 2 + 60;
		var _posy = _guih / 2 + 15;
		var _sprite = spr_button_red
		var _inda = 0;
		if(obj_player.gold >= _id.upgrade_cost && _id.level < 5) {
			_sprite = spr_button_blue;
		}
		var _btnw = sprite_get_width(_sprite);
		var _btnh = sprite_get_height(_sprite);
		if(point_in_rectangle(_mx, _my, _posx - _btnw / 2 + 6, _posy - _btnh / 2, _posx + _btnw / 2 - 6, _posy + _btnh / 2 - 6)) {
			if(mouse_check_button(mb_left)) _inda = 1;
			if(_sprite == spr_button_blue && mouse_check_button_released(mb_left)) {
				obj_player.gold -= _id.upgrade_cost;
				_id.att_upgrade();
			}
		}
		
		draw_sprite(_sprite, _inda, _posx - _btnw / 2, _posy - _btnh / 2);
		draw_sprite(spr_shop, _inda,  _posx, _posy - 3);
	}
	if(_objind == obj_archer) {
		if(!point_in_rectangle(_mx, _my, _invx, _invy - 150, _invx + _tamw, _invy + 150)
			&& mouse_check_button_pressed(mb_left)
			&& !instance_position(mouse_x, mouse_y, obj_archer_tower)
			&& !instance_position(mouse_x, mouse_y, obj_archer)) {
				global.menu = noone;
			}
			draw_sprite_stretched(spr_banner_horizontal, 0, _invx, _invy - 95, _tamw, 200);
			draw_sprite_stretched(spr_ribbon_blue_full, 0, _invx - 48, _invy - 100, _tamw + 96, _tamh);
			draw_set_valign(1);
			draw_set_halign(0);
			draw_set_font(fnt_options);
			draw_set_color(c_black); 
			draw_text(_invx + (_tamw / 2) - 50, _invy - 80, "Level: " + string(_id.level));
			draw_set_font(fnt_upgrade);
			draw_set_color(c_dkgray);
			var _h = string_height("T");
			draw_text(_invx + (_tamw / 2) - 105, _invy - _h, "Dano(+1): " + string(_id.damage));
			draw_text(_invx + (_tamw / 2) - 105, _invy, "Range(+10): " + string(_id.area));
			if(_id.level < 5) {
				draw_sprite(spr_g_idle, 0, _guiw / 2 - 60, _guih / 2 + 15);
				draw_text(_invx + (_tamw / 2) - 20, _invy + 45, string(_id.upgrade_cost));
			} else {
				draw_text(_guiw / 2 - 95, _guih / 2 + 15, "Max Level!");
			}	
			draw_set_color(c_white)
			draw_set_valign(-1);
			draw_set_halign(-1);
			draw_set_font(-1);
			var _posx = _guiw / 2 + 60;
			var _posy = _guih / 2 + 15;
			var _sprite = spr_button_red
			var _inda = 0;
			if(obj_player.gold >= _id.upgrade_cost && _id.level < 5) {
				_sprite = spr_button_blue;
			}
			var _btnw = sprite_get_width(_sprite);
			var _btnh = sprite_get_height(_sprite);
			if(point_in_rectangle(_mx, _my, _posx - _btnw / 2 + 6, _posy - _btnh / 2, _posx + _btnw / 2 - 6, _posy + _btnh / 2 - 6)) {
				if(mouse_check_button(mb_left)) _inda = 1;
				if(_sprite == spr_button_blue && mouse_check_button_released(mb_left)) {
					obj_player.gold -= _id.upgrade_cost;
					_id.att_upgrade();
				}
			}
		
			draw_sprite(_sprite, _inda, _posx - _btnw / 2, _posy - _btnh / 2);
			draw_sprite(spr_shop, _inda,  _posx, _posy - 3);
	}
	if(_objind == obj_player) {
		var _w = 465;
		var _h = 392;
		var _x = _guiw / 2 - _w / 2;
		var _y = _guih / 2 - _h / 2;
		var _ribbonx = _x + 390;
		var _ribbony = _y - 47;
		
		var _ribbonw = sprite_get_width(spr_ribbon_connec_top);
		var _ribbonh = sprite_get_height(spr_ribbon_connec_top);
		var _closex = _ribbonx + 9;
		var _closey = _ribbony + 17;
		var _inde = 0;
		if(point_in_rectangle(_mx, _my, _ribbonx, _ribbony, _ribbonx + _ribbonw, _ribbony + _ribbonh) && mouse_check_button(mb_left)) {
			_inde = 1;
		}
		if(point_in_rectangle(_mx, _my, _ribbonx, _ribbony, _ribbonx + _ribbonw, _ribbony + _ribbonh) && mouse_check_button_released(mb_left)) {
			global.menu = noone;
		}
		draw_sprite(spr_ribbon_connec_top, _inde, _ribbonx, _ribbony);
		draw_sprite(spr_regular_01, _inde, _closex, _closey);
		draw_sprite_stretched(spr_banner_horizontal, 0, _x, _y, _w, _h);
		var _x1 = _x + 63;
		
		//heroes
		var _dist = 80;
		var _yh = _y + 75;
		for(var _j = 0; _j < 3; _j ++) {
			var _xx = _x1 + _dist * _j;
			draw_sprite(spr_carved_regular, 0, _xx, _yh);
			if(_j == 0) draw_sprite(spr_archer_icon, 0, _x + 45, _y + 52);
			if(_j == 1) draw_sprite(spr_tower_icon, 0, _x + 143, _y + 95);
			if(_j == 2) draw_sprite(spr_warrior_icon, 0, _x + 203, _y + 52);
			if(_j == ind) draw_sprite(spr_pointer_select, 0 , _xx, _yh); 
			if(point_in_rectangle(_mx, _my, _xx - 32, _yh - 32, _xx + 32, _yh + 32) && mouse_check_button_released(mb_left)) ind = _j;
		}
		
		
		

		//obstaculos
		draw_sprite(spr_carved_regular, 0, _x1, _y + 235);
		draw_sprite(spr_carved_regular, 0, _x1 + 80, _y + 235);
		
		var _xla = _x1 - (sprite_get_width(spr_lands) / 2);
		var _yla = _y + 235 - (sprite_get_height(spr_lands) / 2);
		var _xla2 = _xla + 80;
		draw_sprite_ext(spr_lands, 0, _xla + 8, _yla + 8, 0.7, 0.7, 1, c_white, 1);
		draw_sprite_ext(spr_lands_none, 0, _xla2 + 8, _yla + 8, 0.7, 0.7, 1, c_white, 1);
		
		if(point_in_rectangle(_mx, _my, _xla, _yla, _xla + 64, _yla + 64) && mouse_check_button_released(mb_left)) ind = 3;
		if(point_in_rectangle(_mx, _my, _xla2, _yla, _xla2 + 64, _yla + 64) && mouse_check_button_released(mb_left)) ind = 4;
		if(ind == 3) draw_sprite(spr_pointer_select, 0 , _x1, _y + 235);
		if(ind == 4) draw_sprite(spr_pointer_select, 0 , _x1 + 80, _y + 235);
		
		//lado
		var _xl = _x + 259;
		var _yl = _y + 12;
		var _widthl = 178;
		var _heightl = 342;
		draw_sprite_stretched(spr_button_blue_9slides, 0, _xl, _yl, _widthl, _heightl);
		draw_set_valign(1);
		draw_set_halign(1);
		draw_set_color(c_white);
		draw_set_font(fnt_upgrade);
		outline_set_text();
		var _es = string_height("T");
		var _spr = spr_button_blue;
		switch(ind) {
			case 0:
				draw_text(_xl + _widthl / 2, _yl + 32, "Archer");
				draw_set_halign(0);
				draw_text(_x1, _y + 128, "Damage: " + string(2));
				draw_text(_x1, _y + 128 + _es, "Life: " + string(3));
				draw_text(_x1, _y + 128 + _es * 2, "Range: " + string(150));
				draw_sprite(spr_archer, 0, _xl + 58, _yl + 51);
				// 10 carnes e 40 ouros
				draw_sprite(spr_sheep_icon, 0, _xl + 40, _yl + 193);
				draw_sprite(spr_g_idle, 0, _xl + 40, _yl + 193 + 48);
				var _valuec = global.archer_f + (instance_number(obj_archer) * 10);
				var _valueg = global.archer_g + (instance_number(obj_archer) * 10);
				if(obj_player.food < _valuec || obj_player.gold < _valueg) _spr = spr_button_red;
				draw_text(_xl + 70, _yl + 193, string(_valuec));
				draw_text(_xl + 70, _yl + 193 + 48, string(_valueg));
			break;
			case 1:
				draw_set_halign(1);
				draw_text(_xl + _widthl / 2, _yl + 32, "Tower Archer");
				draw_set_halign(0);
				draw_text(_x1, _y + 128, "Damage: " + string(3));
				draw_text(_x1, _y + 128 + _es, "Life: " + string(5));
				draw_text(_x1, _y + 128 + _es * 2, "Range: " + string(200));
				draw_sprite(spr_tower_shop, 0, _xl + 58, _yl + 51);
			break;
			case 3:
				draw_text(_xl + _widthl / 2, _yl + 32, "Land");
				draw_set_halign(1);
				draw_set_font(fnt_shop);
				draw_sprite(spr_lands, 0, _xl + 58, _yl + 51);
				outline_draw_text(_xl + 88, _yl + 51 + 80, "Obstaculo");
				outline_draw_text(_xl + 88, _yl + 48 + 80 + _es, "Suporta heróis");
			break;
			case 4:
				draw_text(_xl + _widthl / 2, _yl + 32, "Land");
				draw_set_halign(1);
				draw_set_font(fnt_shop);
				draw_sprite(spr_lands_none, 0, _xl + 58, _yl + 51);
				outline_draw_text(_xl + 88, _yl + 51 + 80, "Apenas um obstaculo");
			break;
		}
		if(ind != -1) {	
			var _xb = _xl + _widthl / 2 - 70;
			var _yb = _yl + _heightl - 70;
			var _indb = 0;
			if(point_in_rectangle(_mx, _my, _xb, _yb, _xb + 140, _yb + 45) && _spr == spr_button_blue) {
				if(mouse_check_button(mb_left)) _indb = 1;
				if(mouse_check_button_released(mb_left)) {
					global.menu = noone;					
					var _buy = instance_create_layer(mouse_x, mouse_y, "Player", obj_buy);
					switch(ind) {
						case 0: global.buy = spr_archer_buy; _buy.sprite = spr_archer_buy; break;
						case 3: global.buy = spr_lands; _buy.sprite = spr_lands; break;
					}
					
				}
			}
			draw_sprite_stretched(_spr, _indb, _xb, _yb, 140, 45);
			draw_sprite_ext(spr_shop, _indb, _xl + _widthl / 2, _yl + _heightl - 50, 0.9, 0.7, 1, c_white, 1);	
		}
		outline_end();
		draw_set_valign(-1);
		draw_set_halign(-1);
		draw_set_color(c_white);
		draw_set_font(-1);
	}
}