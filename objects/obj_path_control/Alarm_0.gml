var _en = instance_create_layer(610, 2400, "Enemys", obj_enemy);
_en.life += floor(wave / 2);
spawn--;
if(spawn > 0) {
	alarm[0] = 60;
} else {
	wave++;
	if(wave % 3 == 0) spawn_ini += 1;
}