#region Variables
global.menu = noone;
state = noone;
state_txt = "idle"
debug = true;
velh = 0;
velv = 0;
vel = 5;
weapons = [ "hand", "axe", "hammer"];
weapon = weapons[0];
sprite = spr_worker_idle;
xscale = 1;
image_ind = 0;
image_spd = 10 / game_get_speed(gamespeed_fps);
image_numb = 1;
axespr = "chopp";
#region resources
wood = 20;
//gold = 30;
gold = 30;
food = 15;
#endregion
sprites = {
		idle: spr_worker_idle,
		run: spr_worker_run,
		chopp: spr_worker_chopp,
		chopp_top: spr_worker_chopp_back,
		build: spr_worker_build,
		carry_idle: spr_worker_carry_idle,
		carry_run: spr_worker_carry_run
}
#endregion

#region Anotations
/*
O player podera:
Coletar madeira, ouro e comida.

Consegue:
Construir, quebrar arvore, pegar ouro da mina e matar ovelha.

Madeira:
Cortara a madeira com a animação de chop, ele ira mirar na arvore e caso esteja no range fara a animação cortando
Usara o botao esquerdo do mouse e tera que apertar 3 vezes na arvore
Cortando 3 vezes a arvore ira quebrar e dropar os troncos no chao, o player irá pegar os troncos e levar no estoque
Ouro:
Ele chegara no range da mina e clicara 3 vezes na mina com o botao esquerdo do mouse, irá dropar um ouro da mina e
o jogador ira clicar na bolsa de ouro e tera que levar para o estoque
Comida:
O usara o ataque com o mouse esquerdo, caso a ovelha esteja no range do ataque irá dar dano nela
Dando dano 3 vezes irá matar a ovelha e dropar a carne no chao, o jogador tera que pegar a carne e levar no estoque

*/
#endregion

#region KeyMap
keyboard_set_map(vk_up, ord("W"));
keyboard_set_map(vk_down, ord("S"));
keyboard_set_map(vk_right, ord("D"));
keyboard_set_map(vk_left, ord("A"));
#endregion

#region Functions
walk = function() {
	var _up = keyboard_check(ord("W"));
	var _down = keyboard_check(ord("S"));
	var _left = keyboard_check(ord("A"));
	var _right = keyboard_check(ord("D"));
	if(_up xor _down or _left xor _right) {
		var _dir = point_direction(0, 0, (_right - _left), (_down - _up));			
		velh = lengthdir_x(vel, _dir);
		velv = lengthdir_y(vel, _dir);
	} else {
		velh = 0;
		velv = 0;
	}
	
}

olhar_mouse = function () {
	var _dire = point_direction(x, y, mouse_x, y);
	direction = _dire;
	switch(_dire) {
		case 180: xscale = -1; break;
		case 0: xscale = 1; break;
	}
}
	
ajusta_sprite = function(_state) {
	if(sprite != sprites[$ _state]) image_ind = 0;
	sprite = sprites[$ _state];
	image_numb = sprite_get_number(sprite);
	image_ind += image_spd;
	image_ind %= image_numb;
}
#endregion

#region Actions

action = function() {
	if(global.buy != noone) exit;
	if(mouse_check_button_pressed(mb_left)) {
		if(!instance_position(mouse_x, mouse_y, obj_gold_mine) && global.menu == noone) {
			if(weapon == weapons[1]) {
				if(mouse_x < x) xscale = -1; else xscale = 1;
				if(mouse_y > y) axespr = "chopp"; else axespr = "chopp_top";
				state = state_axe;
			}
		}
	}
	if(mouse_check_button_pressed(mb_right)) {
		if(weapon == weapons[2]) {
			global.menu = id;
		}
	}
}

change_weapon = function () {
	if(keyboard_check(ord("1"))) {
		weapon = weapons[0];
	} else if(keyboard_check(ord("2"))) {
		weapon = weapons[1];
	} else if(keyboard_check(ord("3"))) {
		weapon = weapons[2];
	}
}

#endregion

state_idle = function () {
	mask_index = spr_worker_idle;
	walk();
	state_txt = "idle";
	velv = 0;
	velh = 0;
	ajusta_sprite("idle");
	olhar_mouse();
	change_weapon();
	var _up = keyboard_check(ord("W"));
	var _down = keyboard_check(ord("S"));
	var _left = keyboard_check(ord("A"));
	var _right = keyboard_check(ord("D"));
	if(_up xor _down or _left xor _right) {
		state = state_walking;	
	}
	action();
}

state_walking = function () {
	walk();
	state_txt = "walking";
	change_weapon();
	ajusta_sprite("run");
	switch(sign(velh)) {
		case 1: xscale = 1; break;
		case -1: xscale = -1;	break;
	}
	if(velv == 0 && velh == 0) {
		state = state_idle;	
	}
	action();
}

state_axe = function () {
	state_txt = "axe";
	velv = 0;
	velh = 0;
	ajusta_sprite(axespr);
	if(image_ind >= 4) {
		if(!instance_exists(obj_axe_hitbox)) {
			if(axespr == "chopp_top") instance_create_layer(x, y, "Battle", obj_axe_hitbox); else instance_create_layer(x, y + (sprite_get_height(spr_worker_chopp_hitbox) / 2), "Battle", obj_axe_hitbox);
		}
	}
	if(image_ind + image_spd >= image_numb) {
		if(instance_exists(obj_axe_hitbox)) instance_destroy(obj_axe_hitbox);
		state = state_idle;
	}
}

state_hammer = function () {
	//state_txt = "hammer";
	//velv = 0;
	//velh = 0;
	//if(dire >= 180) {
	//	ajusta_sprite("build");	
	//} else if(dire < 180) {
	//	ajusta_sprite("build");	
	//}
	//if(dire > 90 && dire < 270) {
	//	xscale = -1;	
	//} else {
	//	xscale = 1;	
	//}
	//if(image_ind + image_spd >= image_numb) {
	//	state = state_idle;
	//}
}

state = state_idle;