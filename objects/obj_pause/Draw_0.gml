if(room = rm_game) exit;
draw_sprite_stretched_ext(spr_banner_horizontal, 1, x1, y1, tamw, tamh, c_white, 1);
draw_sprite_stretched(spr_ribbon_blue_full, 1, x1 - 48, ytitle, tamw + 96, tamspr);
	

draw_set_valign(1);
draw_set_halign(1);
draw_set_font(fnt_options);
settingsy = ytitle + (string_height("T") / 2);
draw_text(width / 2, settingsy, text_lang("opcoes"));
draw_set_valign(-1);
draw_set_halign(-1);
draw_set_font(-1);

