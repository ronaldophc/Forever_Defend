collision_list = ds_list_create();
hitbox_list = ds_list_create();
var _ctree = instance_place_list(x, y, obj_tree, collision_list, false);
var _csheep = instance_place_list(x, y, obj_sheep, collision_list, false);
if(_ctree > 0) {
	for (var _i = 0; _i < ds_list_size(collision_list); _i++) {
	    var _target = collision_list[| _i];
		if(!ds_list_find_value(hitbox_list, _target)) {
			ds_list_add(hitbox_list, _target);
			if(_target.state == _target.state_idle) {
				_target.state = _target.state_damage;
			}
		}
	}	
}
if(_csheep > 0) {
	for (var _i = 0; _i < ds_list_size(collision_list); _i++) {
	    var _target = collision_list[| _i];
		if(!ds_list_find_value(hitbox_list, _target)) {
			ds_list_add(hitbox_list, _target);
			_target.take_damage();
		}
	}	
}

//if(instance_exists(obj_tree)){
//		with(obj_tree) {
//			if(place_meeting(x, y, obj_player)) damage = true;	
//		}
//	}
//	if(instance_exists(obj_sheep)){
//		with(obj_sheep) {
//			if(place_meeting(x, y, obj_player)) take_damage();
//		}
//	}