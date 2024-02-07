spawn_timer--;
randomize();
if(spawn_timer <= 0) {
	repeat(random(2)) {
		var _random_x = random_range(200, 2800);

		instance_create_layer(_random_x, 2400, "Enemys", obj_enemy);
	}
	spawn_timer = spawn_time;
}