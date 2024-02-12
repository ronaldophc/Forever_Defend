adepth();
var _colisoes = [obj_colision, obj_tree];
var _sprite = spr_worker_idle;
var _chao = instance_place(x + velh, y, _colisoes);
if(_chao) {
	var _ww = sprite_get_bbox_right(_sprite) - sprite_get_bbox_left(_sprite);
	if(velh > 0) {
		if(_chao.bbox_left <= x + _ww) {
			x = _chao.bbox_left - _ww / 2;
		}
	} else if(velh < 0) {
		if(_chao.bbox_right >= x - _ww) {
			x = _chao.bbox_right + (sprite_get_xoffset(_sprite) - sprite_get_bbox_left(_sprite));	
		}
	}
	velh=0;
}
x += velh;

_chao = instance_place(x, y + velv, _colisoes);
if(_chao) {
	if(velv > 0) {
		if(_chao.bbox_top <= y - (sprite_get_height(_sprite) - sprite_get_yoffset(_sprite))) {
			y = _chao.bbox_top - (sprite_get_height(_sprite) - sprite_get_yoffset(_sprite));
		}
	} else if(velv < 0) {
		if(_chao.bbox_bottom >= y - sprite_get_bbox_top(_sprite)) {
			y = _chao.bbox_bottom + (sprite_get_yoffset(_sprite) - sprite_get_bbox_top(_sprite));
		}
	}
	velv = 0;
}
y += velv;