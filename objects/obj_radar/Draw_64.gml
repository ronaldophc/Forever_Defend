//draw_set_color(make_color_rgb(121, 168, 99));
//draw_rectangle(x, y, x + width, y + height, false);

////Drawing Instances
//for(var i = 0; i < array_length(objects_to_draw); i += 2) {
//	var map_object_index = objects_to_draw[i],
//		map_object_color = objects_to_draw[i + 1];
	
//	draw_set_color(map_object_color);
	
//	for(var j = 0; j < instance_number(map_object_index); j++) {
//		var instance = instance_find(map_object_index, j),
//			current_left = (instance.bbox_left - 64 * 2) * scale,
//			current_top = (instance.bbox_top - 1472) * scale,
//			current_right = (instance.bbox_right - 64 * 2) * scale,
//			current_bottom = (instance.bbox_bottom - 1472) * scale;
//		if(instance.y > 1472 && instance.y < room_height - 5){
//			draw_rectangle(x + current_left, x + current_top, x + current_right, x + current_bottom, false);
//		}
//	}
	
//	draw_set_color(-1);
//}

// Desenhar fundo
draw_set_color(make_color_rgb(121, 168, 99));
draw_rectangle(x, y, x + width, y + height, false);

// Desenhar instâncias
for(var _i = 0; _i < array_length(objects_to_draw); _i += 2) {
    var _map_object_index = objects_to_draw[_i];
    var _map_object_color = objects_to_draw[_i + 1];
    
    draw_set_color(_map_object_color);
    
    for(var _j = 0; _j < instance_number(_map_object_index); _j++) {
        var _instance = instance_find(_map_object_index, _j);
        
        // Pré-calcular coordenadas
        var _current_left = (_instance.bbox_left - 64 * 2) * scale;
        var _current_top = (_instance.bbox_top - 1472) * scale;
        var _current_right = (_instance.bbox_right - 64 * 2) * scale;
        var _current_bottom = (_instance.bbox_bottom - 1472) * scale;

        // Verificar se a instância está na área visível
        if(_instance.y > 1472 && _instance.y < room_height - 5){
			var _x1 = x + _current_left;
			var _y1 = x + _current_top;
			var _x2 = x + _current_right;
			var _y2 = x + _current_bottom;
           draw_rectangle(_x1, _y1, _x2, _y2, false);
        }
    }
}

// Restaurar cor de desenho padrão
draw_set_color(c_white);
