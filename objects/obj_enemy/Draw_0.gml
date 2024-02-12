draw_sprite_ext(sprite, image_ind, x, y, xscale, 1, 1, c_white, 1);
draw_text(x, y + 16, string(life))
var _w = sprite_get_width(sprite);
var _h = sprite_get_height(sprite);
if(life > 0 && life < 5) {
	var _x1 = x - (_w / 7);
	var _y1 = y - (_h / 6);
	var _x2 = x + (_w / 7);
	var _y2 = y - (_h / 6) + 3;
	var _pc = life / 5 * 100;
	draw_healthbar(_x1, _y1, _x2, _y2, _pc, c_black, c_red, c_lime, 0, true, true);
}