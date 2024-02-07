#region Anotations
	/*
		Opções 1: Voltar, Graphic, Sound, Hotkeys, Main Menu.
		Voltar: volta ao game
		Graphic: Full-Screen, Resolution, V-Sync, Anti-Aliasing.
		Sound: Volume, Music.
		Hotkeys:
		Main Menu.
	*/
#endregion
#region Setando full screen
if(read_ini("graphics", "full_screen") == "0") {
	window_set_fullscreen(true);
} else {
	window_set_fullscreen(false);
}
#endregion
#region variables
width = display_get_width();
height = display_get_height();
resw_atual = read_ini("graphics", "resolution_width");
resh_atual = read_ini("graphics", "resolution_height");
tamw = width / 4;
tamh = (height / 2);
tamspr = sprite_get_height(spr_ribbon_blue_full);
tamsprw = sprite_get_width(spr_ribbon_blue_full);
x1 = width / 2 - ((width / 4) / 2);
y1 = height / 2 - ((height / 4));
ytitle = y1 - (tamspr / 2);
settingsy = ytitle + (string_height("T") / 2);
marg = 16;
state = noone;
state_txt = "ini";
anti_ali = read_ini_real("graphics", "anti_aliasing");
vsync = read_ini_real("graphics", "vsync");
destroyed = false;
desenhou = false;
#endregion

lang_ini = read_ini("language", "lang");

text_lang = function(_text) {
	if(lang_ini = "en") {
		if(_text == "voltar") return			global.lang.en.voltar;
		if(_text == "graficos") return			global.lang.en.graficos;
		if(_text == "som") return				global.lang.en.som;
		if(_text == "atalhos") return			global.lang.en.atalhos;
		if(_text == "menu_principal") return	global.lang.en.menu_principal;
		if(_text == "opcoes") return			global.lang.en.opcoes;
		if(_text == "full_screen") return		global.lang.en.full_screen;
		if(_text == "resolucao") return			global.lang.en.resolucao;
		if(_text == "vsync") return				global.lang.en.vsync;
		if(_text == "aa") return				global.lang.en.aa;
		if(_text == "janela") return			global.lang.en.janela;
	}
	if(lang_ini = "pt_br") {
		if(_text == "voltar") return			global.lang.pt_br.voltar;
		if(_text == "graficos") return			global.lang.pt_br.graficos;
		if(_text == "som") return				global.lang.pt_br.som;
		if(_text == "atalhos") return			global.lang.pt_br.atalhos;
		if(_text == "menu_principal") return	global.lang.pt_br.menu_principal;
		if(_text == "opcoes") return			global.lang.pt_br.opcoes;
		if(_text == "full_screen") return		global.lang.pt_br.full_screen;
		if(_text == "resolucao") return			global.lang.pt_br.resolucao;
		if(_text == "vsync") return				global.lang.pt_br.vsync;
		if(_text == "aa") return				global.lang.pt_br.aa;
		if(_text == "janela") return			global.lang.pt_br.janela;
	}
}

muda_button_ini = function () {
	if(mouse_check_button_pressed(mb_left)) {
		var _obj = instance_position(mouse_x, mouse_y, obj_button_pause);
		if(_obj) {
			var _opt = _obj.text;
			if(state == state_ini) 
			{
				if(_opt == text_lang("voltar")) room_goto(rm_game);
				if(_opt == text_lang("graficos")) {
					state = state_graphics;
					desenhou = false;
					destroyed = false;
				}
			} else if(state == state_graphics) {
				if(_opt == text_lang("voltar")) {
					state = state_ini;
					desenhou = false;
					destroyed = false;
				} else if(_opt == text_lang("full_screen")) {
					state = state_fullscreen;
					desenhou = false;
					destroyed = false;
				} else if(_opt == text_lang("resolucao")) {
					state = state_resolution;
					desenhou = false;
					destroyed = false;
				} else if(_opt == text_lang("vsync")) {
					if(vsync == 0) {
						vsync = 1;
						write_ini("graphics", "vsync", "1")
						display_reset(anti_ali, true);
						destroyed = false;
						desenhou = false;
					} else {
						vsync = 0;
						write_ini("graphics", "vsync", "0")
						display_reset(anti_ali, false);
						destroyed = false;
						desenhou = false;
					}
				} else if(_opt == text_lang("aa")) {
					if(anti_ali == 0) {
						if(display_aa >= 2) {
							set_anti_ali(2);
						}
					} else if(anti_ali == 2) {
						if(display_aa >= 6) {
							set_anti_ali(4);
						} else {
							set_anti_ali(0);
						}
					} else if(anti_ali == 4) {
						if(display_aa >= 12) {
							set_anti_ali(8);
						} else {
							set_anti_ali(0);
						}
					} else if(anti_ali == 8) {
						set_anti_ali(0);
					}
				}
			} else if(state == state_fullscreen) {
				if(_opt == text_lang("voltar")) {
					state = state_graphics;
					desenhou = false;
					destroyed = false;
				} else if(_opt == text_lang("janela")) {
					write_ini("graphics", "full_screen", "1");
					destroyed = false;
					desenhou = false;
					event_user(0);
				} else if(_opt == text_lang("full_screen")) {
					write_ini("graphics", "full_screen", "0");
					destroyed = false;
					desenhou = false;
					event_user(0);
				}
			
			#region Resolution
			} else if(state == state_resolution) {
				if(_opt == text_lang("voltar")) {
					state = state_graphics;
					desenhou = false;
					destroyed = false;
				} else if(_opt == "1920 x 1080") {
					if(resw_atual != "1920" || resh_atual != "1080") {
						write_ini("graphics", "resolution_width", "1920");
						write_ini("graphics", "resolution_height", "1080");
						destroyed = false;
						desenhou = false;
						resw_atual = read_ini("graphics", "resolution_width");
						resh_atual = read_ini("graphics", "resolution_height");
						obj_cam.atualizar();
					}
				} else if(_opt == "1280 x 720") {
					if(resw_atual != "1280" || resh_atual != "720") {
						write_ini("graphics", "resolution_width", "1280");
						write_ini("graphics", "resolution_height", "720");
						destroyed = false;
						desenhou = false;
						resw_atual = read_ini("graphics", "resolution_width");
						resh_atual = read_ini("graphics", "resolution_height");
						obj_cam.atualizar();
					}
				} else if(_opt == "1024 x 576") {
					if(resw_atual != "1024" || resh_atual != "576") {
						write_ini("graphics", "resolution_width", "1024");
						write_ini("graphics", "resolution_height", "576");
						destroyed = false;
						desenhou = false;
						resw_atual = read_ini("graphics", "resolution_width");
						resh_atual = read_ini("graphics", "resolution_height");
						obj_cam.atualizar();
					}
				} else if(_opt == "640 x 360") {
					if(resw_atual != "640" || resh_atual != "360") {
						write_ini("graphics", "resolution_width", "640");
						write_ini("graphics", "resolution_height", "360");
						destroyed = false;
						desenhou = false;
						resw_atual = read_ini("graphics", "resolution_width");
						resh_atual = read_ini("graphics", "resolution_height");
						obj_cam.atualizar();
					}
				}
			}
			#endregion
		}
	}
}

destroy_buttons = function () {
	if(!destroyed) {
		destroyed = true;
		if(instance_exists(obj_button_pause)) {
			with(obj_button_pause) {
				instance_destroy();
			}
		}
	}
}

set_anti_ali = function (_level) {
	anti_ali = _level;
	write_ini("graphics", "anti_aliasing", string(_level));
	display_reset(anti_ali, vsync);
	destroyed = false;
	desenhou = false;
}

state_reset = function () {
	state_txt = "reset";	
}

state_ini = function () {
	state_txt = "ini";
	destroy_buttons();
	if(!desenhou) {
		var _button = instance_create_layer(width / 2, settingsy + 64 +  marg, "Buttons", obj_button_pause, {indice: 0});
		_button.text = text_lang("voltar");
		var _button2 = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 1});
		_button2.text = text_lang("graficos");
		var _button3 = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 2});
		_button3.text = text_lang("som");
		var _button4 = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 3});
		_button4.text = text_lang("atalhos");
		var _button5 = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 4});
		_button5.text = text_lang("menu_principal");
		desenhou = true;
	}
	muda_button_ini();
}

state_graphics = function () {
	state_txt = "graphics";
	destroy_buttons();
	if(!desenhou) {
		var _button = instance_create_layer (width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 0});
		_button.text = text_lang("full_screen");
		var _button2 = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 1});
		_button2.text = text_lang("resolucao");
		var _button3 = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 2, opt: "vsync"});
		_button3.text = text_lang("vsync");
		_button3.option = true;
		var _button4 = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 3, opt: "aa"});
		_button4.text = text_lang("aa");
		_button4.option = true;
		var _button5 = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 4});
		_button5.text = text_lang("voltar");
		desenhou = true;
	}
	muda_button_ini();
}

state_fullscreen = function () {
	state_txt = "full_screen";
	destroy_buttons();
	if(!desenhou) {
		var _button = instance_create_layer (width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 0, opt: "full_screen"});
		_button.text = text_lang("full_screen");
		_button.option = true;
		var _button2 = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 1, opt: "full_screen"});
		_button2.text = text_lang("janela");
		_button2.option = true;
		var _button5 = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 4});
		_button5.text = text_lang("voltar");
		desenhou = true;
	}
	muda_button_ini();
}

state_resolution = function () {
	state_txt = "resolution";
	destroy_buttons();
	if(!desenhou) {																							  
		var _button = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 0, opt: "resolution"});
		_button.text = "1920 x 1080";
		_button.option = true;
		var _button1 = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 1, opt: "resolution"});
		_button1.text = "1280 x 720";
		_button1.option = true;
		var _button2 = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 2, opt: "resolution"});
		_button2.text = "1024 x 576";
		_button2.option = true;
		var _button3 = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 3, opt: "resolution"});
		_button3.text = "640 x 360";
		_button3.option = true;
		var _button4 = instance_create_layer(width / 2, settingsy + 64 + marg, "Buttons", obj_button_pause, {indice: 4});
		_button4.text = text_lang("voltar");
		desenhou = true;
	}
	muda_button_ini();
}

state = state_ini;
