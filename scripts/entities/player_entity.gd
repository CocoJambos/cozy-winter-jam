extends CharacterBody3D;
class_name PlayerEntity;

@export var acceleration: float = 300;
@export var max_speed: float = 300;
@export var deceleration: float  = 300;

var input_data: InputData = null;

func _process(delta: float) -> void:
	pass;

func handle_input(input_data: InputData) -> void:
	pass;
