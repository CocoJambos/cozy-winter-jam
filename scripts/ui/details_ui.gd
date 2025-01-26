extends Control
class_name DetailsUI;
signal state_changed(state: bool);
@export var texture_rect: TextureRect;

var is_visible: bool = false;

func show_ui() -> void:
	show();
	is_visible = true;
	state_changed.emit(is_visible);

func hide_ui() -> void:
	is_visible = false;
	state_changed.emit(is_visible);
	hide();

func _on_input_changed(input: InputData) -> void:
	if !input.pause_input:
		return;
	
	if is_visible:
		hide_ui();
	else:
		show_ui();
