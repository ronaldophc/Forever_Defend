function scr_a_star_search(grid, weights, start, destination) {

	/* Based on the psuedocode found at
	 * https://en.wikipedia.org/wiki/A*_search_algorithm
	 */

	var open_set = ds_priority_create();
	var data;

	for (var index_1 = 0; index_1 < array_length(grid); index_1++) {
		for (var index_2 = 0; index_2 < array_length(grid[index_1]); index_2++) {
			data[index_1][index_2] = {
				g_score: 999,
				f_score: 999,
				parent: undefined,
				in_open_set: false
			};
		}
	}

	// Calculate the f and g scores for the start and add it to the open set
	data[start[0]][start[1]].g_score = 0;
	data[start[0]][start[1]].f_score = sqrt(
	    sqr(start[0] - destination[0]) + sqr(start[1] - destination[1])
	);

	ds_priority_add(open_set, start, data[start[0]][start[1]].f_score);
	data[start[0]][start[1]].in_open_set = true;

	while (ds_priority_size(open_set)) {
	
		// Find the open grid square with the lowest f score	
		var current = ds_priority_find_min(open_set);
	
		// If that grid square is the end, build the path and return it
		if (array_equals(current, destination)) {
			var output = scr_reconstruct_path(start, destination, data);
			ds_priority_destroy(open_set);
			return output;
		}
	
		// Remove the square from the open set since its no longer "open"
		ds_priority_delete_min(open_set);
		data[current[0]][current[1]].in_open_set = false;
	
		// Get the square's neighbors and check them for more efficient paths
		var neighbors = scr_get_neighbors(grid, current, destination);
	
		for (var index = 0; index < array_length(neighbors); index++) {
		
			var neighbor = neighbors[index];
		
			var tentative_g_score = data[current[0]][current[1]].g_score + weights[neighbor[0]][neighbor[1]];
		
			// If the tenative g score is lower than the actual, it means a more
			// efficient path to that square has been found
			if (tentative_g_score < data[neighbor[0]][neighbor[1]].g_score) {
			
				data[neighbor[0]][neighbor[1]].parent = current;
				data[neighbor[0]][neighbor[1]].g_score = tentative_g_score;
				data[neighbor[0]][neighbor[1]].f_score = tentative_g_score + sqrt(
				    sqr(neighbor[0] - destination[0]) + sqr(neighbor[1] - destination[1])
				);
			
				// Because you can't iterate over a priority queue to check if the
				// neighbor is in it, we reference the "in_open_set" array instead
				if (!data[neighbor[0]][neighbor[1]].in_open_set) {
					ds_priority_add(open_set, neighbor, data[neighbor[0]][neighbor[1]].f_score);
					data[neighbor[0]][neighbor[1]].in_open_set = true;
				}
			
			}
		
		}

	}

	// If the queue size ever hits zero, it means no path is possible
	ds_priority_destroy(open_set);

	return undefined;

}

function scr_depth_first_search(grid, start, destination) {

	/* Based on the psuedocode found at
	 * https://en.wikipedia.org/wiki/Depth-first_search
	 */

	// Using GML's built in stack data structure results in memory leaks, so
	// instead a very basic psuedo-stack is used
	var stack = [];
	var stack_pointer = -1;
	var data;

	for (var index_1 = 0; index_1 < array_length(grid); index_1++) {
		for (var index_2 = 0; index_2 < array_length(grid[index_1]); index_2++) {
			data[index_1][index_2] = {
				discovered: false,
				parent: undefined,
			};
		}
	}

	stack[++stack_pointer] = start;

	while (stack_pointer > -1) {
	
		// Pop the current location off the top of the stack
		var v = stack[stack_pointer--];
	
		// If the current location is the end, build the path and return it
		if (array_equals(v, destination)) {
			var output = scr_reconstruct_path(start, destination, data);
			return output;
		}
	
		// If this location has been discovered before, ignore it and go onto the
		// next
		if (!data[v[0]][v[1]].discovered) {
		
			data[v[0]][v[1]].discovered = true;
		
			// Get the current location's neighbors and push them onto the stack
			// if they have not been discovered before
			var neighbors = scr_get_sorted_neighbors(grid, v, destination);
		
			for (var index = ds_list_size(neighbors) - 1; index >= 0; index--) {
				var neighbor = ds_list_find_value(neighbors, index);
				if (!data[neighbor[0]][neighbor[1]].discovered) {
					data[neighbor[0]][neighbor[1]].parent = v;
					stack[++stack_pointer] = neighbor;
				}
			}
		
			ds_list_destroy(neighbors);
		
		}
	
	}

	// If the stack size ever hits zero, it means no path is possible
	return undefined;

}


function scr_get_neighbors(grid, current_location, destination) {

	var neighbors = [];

	var curr_x = current_location[0];
	var curr_y = current_location[1];

	// Neighbor to the left
	if (curr_x > 0 &&
	    (is_undefined(grid[curr_x - 1][curr_y]) ||
		 array_equals([curr_x - 1, curr_y], destination))) {

		neighbors[0] = [curr_x - 1, curr_y];

	}

	// Neighbor above
	if (curr_y > 0 &&
	    (is_undefined(grid[curr_x][curr_y - 1]) ||
		 array_equals([curr_x, curr_y - 1], destination))) {

		neighbors[array_length(neighbors)] = [curr_x, curr_y - 1];

	}

	// Neighbor to the right
	if (curr_x < array_length(grid) - 1 &&
	    (is_undefined(grid[curr_x + 1][curr_y]) ||
		 array_equals([curr_x + 1, curr_y], destination))) {

		neighbors[array_length(neighbors)] = [curr_x + 1, curr_y];

	}

	// Neighbor below
	if (curr_y < array_length(grid[curr_x]) - 1 &&
	    (is_undefined(grid[curr_x][curr_y + 1]) ||
		 array_equals([curr_x, curr_y + 1], destination))) {

		neighbors[array_length(neighbors)] = [curr_x, curr_y + 1];

	}

	return neighbors;

}


function scr_reconstruct_path(start, destination, data) {

	var current = destination;

	var reversed_output;
	var output_index = 0;

	// So long as the current node's parent is not the start, keep backtracking
	// through the path
	while (!array_equals(current, start)) {
			
		reversed_output[output_index][0] = current[0];
		reversed_output[output_index][1] = current[1];
		output_index++;

		current = data[current[0]][current[1]].parent;
			
	}

	// Reverse the constructed path so that its "start -> end" instead of
	// "end -> start"
	var output;

	for (var index = 0; index < array_length(reversed_output); index++) {
			
		output_index = array_length(reversed_output) - index - 1;
			
		output[output_index][0] = reversed_output[index][0];
		output[output_index][1] = reversed_output[index][1];
			
	}

	return output;

}


function scr_get_sorted_neighbors(grid, current_location, destination) {

	var neighbors = ds_list_create();
	var distances = ds_list_create();

	var curr_x = current_location[0];
	var curr_y = current_location[1];
	var end_x = destination[0];
	var end_y = destination[1];

	// Neighbor to the left
	if (curr_x > 0 &&
	    (is_undefined(grid[curr_x - 1][curr_y]) ||
		 array_equals([curr_x - 1, curr_y], destination))) {

		ds_list_add(neighbors, [curr_x - 1, curr_y]);
		ds_list_add(distances, sqrt(sqr(curr_x - 1 - end_x) + sqr(curr_y - end_y)));

	}

	// Neighbor above
	if (curr_y > 0 &&
	    (is_undefined(grid[curr_x][curr_y - 1]) ||
		 array_equals([curr_x, curr_y - 1], destination))) {
	
		scr_insert_neighbor(
		    neighbors,
			distances,
			[curr_x, curr_y - 1],
			sqrt(sqr(curr_x - end_x) + sqr(curr_y - 1 - end_y))
		);

	}

	// Neighbor to the right
	if (curr_x < array_length(grid) - 1 &&
	    (is_undefined(grid[curr_x + 1][curr_y]) ||
		 array_equals([curr_x + 1, curr_y], destination))) {
	
		scr_insert_neighbor(
		    neighbors,
			distances,
			[curr_x + 1, curr_y],
			sqrt(sqr(curr_x + 1 - end_x) + sqr(curr_y - end_y))
		);

	}

	// Neighbor below
	if (curr_y < array_length(grid[curr_x]) - 1 &&
	    (is_undefined(grid[curr_x][curr_y + 1]) ||
		 array_equals([curr_x, curr_y + 1], destination))) {
	
		scr_insert_neighbor(
		    neighbors,
			distances,
			[curr_x, curr_y + 1],
			sqrt(sqr(curr_x - end_x) + sqr(curr_y + 1 - end_y))
		);

	}

	ds_list_destroy(distances);

	return neighbors;

}


function scr_insert_neighbor(neighbors, distances, neighbor, distance) {

	for (var index = 0; index < ds_list_size(neighbors); index++) {
		if (distance < ds_list_find_value(distances, index)) {
			ds_list_insert(neighbors, index, neighbor);
			ds_list_insert(distances, index, distance);
			return;
		}
	}

	ds_list_add(neighbors, neighbor);
	ds_list_add(distances, distance);

}

