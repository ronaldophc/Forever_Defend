var _x = x1 - 130;
var _y = y1 - 32 + (indice * 96);
draw_sprite_stretched(sprite, 1, _x, _y, 260, 80);
draw_set_valign(1);
draw_set_halign(1);
draw_set_font(fnt_options);
if(!option) {
	if(sprite == spr_button_blue_pressed) {
		draw_set_color(c_gray);
		draw_text(x1, y1 + (indice * 96) + 5, text);
		draw_set_color(c_white);
	} else {
		draw_text(x1, y1 + (indice * 96), text);
	}
} else {
	if(opt == "aa") {
		if(is_on) {
			draw_text(x1, y1 + (indice * 96), aa + "x");
		} else {
			draw_text(x1, y1 + (indice * 96), text);
		}
	} else if(opt == "vsync") {
		if(vsync == "0") {
			sprite = spr_button_blue_pressed;
			draw_set_color(c_gray);
			draw_text(x1, y1 + (indice * 96) + 5, text + " off");
			draw_set_color(-1);
		} else {
			draw_text(x1, y1 + (indice * 96), text + " on");
		}	
	} else if(opt == "full_screen" || opt == "janela") {
		if(indice == fullscreen) {
			sprite = spr_button_blue_pressed;
			draw_set_color(c_gray);
			draw_text(x1, y1 + (indice * 96) + 5, text);
			draw_set_color(-1);
		} else {
			draw_text(x1, y1 + (indice * 96), text);
		}	
	} else if(opt == "resolution") {
		if (res_width == 1920 && res_height == 1080 && indice == 0) {
			sprite = spr_button_blue_pressed;
			draw_set_color(c_gray);
			draw_text(x1, y1 + (indice * 96) + 5, text);
			draw_set_color(-1);
		} else if (res_width == 1280 && res_height == 720 && indice == 1) {
			sprite = spr_button_blue_pressed;
			draw_set_color(c_gray);
			draw_text(x1, y1 + (indice * 96) + 5, text);
			draw_set_color(-1);
		} else if (res_width == 1024 && res_height == 576 && indice == 2) {
			sprite = spr_button_blue_pressed;
			draw_set_color(c_gray);
			draw_text(x1, y1 + (indice * 96) + 5, text);
			draw_set_color(-1);
		} else if (res_width == 640 && res_height == 360 && indice == 3) {
			sprite = spr_button_blue_pressed;
			draw_set_color(c_gray);
			draw_text(x1, y1 + (indice * 96) + 5, text);
			draw_set_color(-1);
		} else {
			draw_text(x1, y1 + (indice * 96), text);
		}
	}
}
draw_set_valign(-1);
draw_set_halign(-1);
draw_set_font(-1);