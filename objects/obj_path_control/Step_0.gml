spawn_timer--;
if(spawn_timer <= 0) {
	spawn = spawn_ini;
	alarm[0] = 1;
	spawn_timer = spawn_time;
}