extends Control
class_name DetailsUI;


func _on_input_changed(input: InputData) -> void:
	if !input.pause_input:
		return;
