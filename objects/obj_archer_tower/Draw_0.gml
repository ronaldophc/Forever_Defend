draw_self();
draw_sprite_ext(sprite, image_ind, x, y - 120, xscale, 1, 1, c_white, 1);

draw_set_valign(1);
draw_set_halign(1);
//draw_text(x, y + 16, state_txt);
draw_set_valign(-1);
draw_set_halign(-1);
draw_circle(x, y, area, true);