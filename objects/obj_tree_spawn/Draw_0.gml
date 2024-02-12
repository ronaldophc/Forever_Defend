draw_set_valign(1);
draw_set_halign(1);
draw_set_font(fnt_debug);
draw_set_alpha(image_alpha);
draw_sprite(spr_tree_icon, 1, x, y - 16);
draw_text(x - 49, y - 16 ," + " + string(qtd))
draw_set_alpha(1);
draw_set_font(-1);
draw_set_valign(-1);
draw_set_halign(-1);