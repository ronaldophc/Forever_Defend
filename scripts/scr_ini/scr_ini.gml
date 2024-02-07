ini_open("settings.ini");
if(!ini_key_exists("language", "lang"))					ini_write_string("language", "lang",				"en");

if(!ini_key_exists("graphics", "full_screen"))			ini_write_string("graphics", "full_screen",			"0");
if(!ini_key_exists("graphics", "resolution_width"))		ini_write_string("graphics", "resolution_width",	"1280");
if(!ini_key_exists("graphics", "resolution_height"))	ini_write_string("graphics", "resolution_height",	"720");
if(!ini_key_exists("graphics", "vsync"))				ini_write_string("graphics", "vsync",				"0");
if(!ini_key_exists("graphics", "anti_aliasing"))		ini_write_string("graphics", "anti_aliasing",		"0");
																  
if(!ini_key_exists("sound", "volume"))					ini_write_string("graphics", "volume",				"0.5");
if(!ini_key_exists("sound", "music"))					ini_write_string("graphics", "music",				"0.5");


ini_close();

/// @function					read_ini(section, key)
/// @param {string} _section		language/graphics/sound
/// @param {string} _key			lang/full_screen/resolution_width_height/vsync/aa/vol/music
function read_ini(_section, _key) {
	ini_open("settings.ini");
	var _value = ini_read_string(_section, _key, "0");
	ini_close();
	return _value;
}

function read_ini_real(_section, _key) {
	ini_open("settings.ini");
	var _value = ini_read_real(_section, _key, 0);
	ini_close();
	return _value;
}

/// @function						wirte_ini(section, key)
/// @param {string} _section		language/graphics/sound
/// @param {string} _key			lang/full_screen/resolution_width_height/vsync/aa/vol/music
function write_ini(_section, _key, _value) {
	ini_open("settings.ini");
	ini_write_string(_section, _key, _value)
	ini_close();
}
/*
	Opções 1: Voltar, Graphic, Sound, Hotkeys, Main Menu.
	Voltar: volta ao game
	Graphic: Full-Screen, Resolution, V-Sync, Anti-Aliasing.
	Sound: Volume, Music.
	Hotkeys:
	Main Menu.
*/