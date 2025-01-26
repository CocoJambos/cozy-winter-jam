extends Control;
class_name LoadingUI;
signal close;

@export var close_time: float = 2;

func _start_closing() -> LoadingUI:
	get_tree().create_timer(close_time).timeout.connect(func(): close.emit());
	return self;
