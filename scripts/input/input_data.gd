extends RefCounted;
class_name InputData;

var movement_input: Vector2 = Vector2.ZERO:
	set(value):
		is_dirty = true;
		movement_input = value;
	get:
		return movement_input;
		
var pause_input: bool:
	set(value):
		is_dirty = true;
		pause_input = value;
	get:
		return pause_input;
		
var action_input: bool:
	set(value):
		is_dirty = true;
		action_input = value;

var mouse_input: Vector2 = Vector2.ZERO:
	set(value):
		is_dirty = true;
		mouse_input = value;
	get:
		return mouse_input;

var is_dirty: bool;
var mouse_input_triggered: bool = false;
