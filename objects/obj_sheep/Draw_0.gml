draw_sprite_ext(sprite, image_ind, x, y, xscale, 1, 1, c_white, alpha2);
//draw_text(x, y - 16, state_txt);
var _w = sprite_get_width(sprite);
var _h = sprite_get_height(sprite);
if(life > 0 && life < 3) {
	var _x1 = x - (_w / 5);
	var _y1 = y - (_h / 5);
	var _x2 = x + (_w / 5);
	var _y2 = y - (_h / 5) + 2;
	var _pc = life / 3 * 100
	draw_healthbar(_x1, _y1, _x2, _y2, _pc, c_black, c_red, c_lime, 0, false, true);
}
if(alpha > 0) {
	gpu_set_fog(true, c_white, 0 ,0);
	draw_sprite_ext(sprite, image_ind, x, y, xscale, 1, 1, c_white, alpha);
	gpu_set_fog(false, c_white, 0 ,0)
}