tile_size = 64;
grid_width = room_width div tile_size;
grid_height = room_height div tile_size;
wave = 1;
spawn_time = 20 * game_get_speed(gamespeed_fps);
spawn_timer = spawn_time;
spawn_ini = 5;
spawn = 5;

for (var index_1 = 0; index_1 < grid_width; index_1++) {
	for (var index_2 = 0; index_2 < grid_height; index_2++) {
		grid[index_1][index_2] = undefined;
		weights[index_1][index_2] = 1;
	}
}

global.buy = noone;