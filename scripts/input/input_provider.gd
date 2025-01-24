extends Node;
class_name InputProvider;

signal input_chaged(input_data: InputData);


func _input(event: InputEvent) -> void:
	var input_data = InputData.new();
	
	if _is_movement_input(event):
		var movement_vector = Input.get_vector("left", "right", "up", "down");
		input_data.movement_input = movement_vector;
	
	if event.is_action("action"):
		input_data.action_input = event.is_action_pressed("action");
	
	if event.is_action("pause"):
		input_data.pause_input = event.is_action_pressed("pause");
		
	input_chaged.emit(input_data);
	

func _is_movement_input(event: InputEvent) -> bool:
	if event is not InputEventAction:
		return false;
	
	var action_event: InputEventAction = event as InputEventAction;
	
	return action_event.is_action("up") || action_event.is_action("down") || action_event.is_action("left") || action_event.is_action("right");
