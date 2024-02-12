img = 0;

if(place_meeting(x, y - 1, obj_land_none)) img += 1;
if(place_meeting(x + 1, y, obj_land_none)) img += 2;
if(place_meeting(x, y + 1, obj_land_none)) img += 4;
if(place_meeting(x - 1, y, obj_land_none)) img += 8;

image_index = img;

if(room = rm_game) {
	if(x >= 0 && x <= room_width && y >= 0 && y <= room_height) {
		var _relative_x = (x div 64);
		var _relative_y = (y div 64);
		obj_path_control.grid[_relative_x][_relative_y] = id;
	}
}