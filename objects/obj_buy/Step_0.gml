var _ix = 9;
var _iy = 25;
var _ex = 37;
var _ey = 36;

x = (mouse_x div 64) * 64;
x = clamp(x, _ix * 64, _ex * 64);
y = (mouse_y div 64) * 64;
y = clamp(y, _iy * 64, _ey * 64);
