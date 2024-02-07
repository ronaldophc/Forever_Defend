
if(position_meeting(mouse_x, mouse_y, self) && state_txt == "idle") outline_draw_sprite(spr_gold_mine_outline, 1, x , y, ol_config(2, c_white, 1, 1));

draw_sprite_ext(sprite, image_ind, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
var _w = sprite_get_width(sprite);
var _h = sprite_get_height(sprite);
if(life > 0 && life < 3 && state = state_idle) {
	var _x1 = x - (_w / 7);
	var _y1 = y - (_h / 6);
	var _x2 = x + (_w / 7);
	var _y2 = y - (_h / 6) + 3;
	var _pc = life / 3 * 100;
	draw_healthbar(_x1, _y1, _x2, _y2, _pc, c_black, c_red, c_lime, 0, true, true);
}
outline_end()
