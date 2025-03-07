extends Node;
class_name InputProvider;

signal input_chaged(input_data: InputData);
@onready var input_data: InputData = InputData.new();

func _input(event: InputEvent) -> void:	
	if _is_movement_input(event):
		var movement_vector = Input.get_vector("left", "right", "up", "down");
		input_data.movement_input = movement_vector;
	
	if event.is_action_pressed("action"):
		input_data.action_input = true;
	
	if event.is_action_released("action"):
		input_data.action_input = false;
	
	if event.is_action_pressed("pause"):
		input_data.pause_input = true;
	
	if event.is_action_released("pause"):
		input_data.pause_input = false;
	
	if event is InputEventMouseMotion:
		var mouse_event: InputEventMouseMotion = event as InputEventMouseMotion;
		input_data.mouse_input = mouse_event.relative;
		input_data.mouse_input_triggered = true;
		
	input_chaged.emit(input_data);
	

func _is_movement_input(event: InputEvent) -> bool:
	return event.is_action("up") || event.is_action("down") || event.is_action("left") || event.is_action("right");
