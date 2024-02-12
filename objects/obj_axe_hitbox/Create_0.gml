collision_list_t = ds_list_create();
collision_list_c = ds_list_create();
hitbox_list = ds_list_create();
var _ctree = instance_place_list(x, y, obj_tree, collision_list_t, false);
var _csheep = instance_place_list(x, y, obj_sheep, collision_list_c, false);
if(_ctree > 0) {
	for (var _i = 0; _i < ds_list_size(collision_list_t); _i++) {
	    var _target = collision_list_t[| _i];
		if(!ds_list_find_value(hitbox_list, _target)) {
			ds_list_add(hitbox_list, _target);
			if(_target.state == _target.state_idle) {
				_target.state = _target.state_damage;
			}
		}
	}	
}
if(_csheep > 0) {
	for (var _i = 0; _i < ds_list_size(collision_list_c); _i++) {
	    var _target = collision_list_c[| _i];
		if(!ds_list_find_value(hitbox_list, _target)) {
			ds_list_add(hitbox_list, _target);
			_target.take_damage();
		}
	}	
}