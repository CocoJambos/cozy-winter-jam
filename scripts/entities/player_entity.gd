@tool
extends CharacterBody3D;
class_name PlayerEntity;

@export var acceleration: float = 300;
@export var max_speed: float = 300;
@export var deceleration: float  = 300;
@export var gravity: float = 9.81;
@export var spring_arm: SpringArm3D;
@export var camera: Camera3D;

var input_data: InputData = null;

func _ready() -> void:
	camera.make_current();

func _process(delta: float) -> void:
	if input_data == null:
		return;
	
	if !is_on_floor():
		velocity.y = move_toward(velocity.y, max_speed, -gravity * delta);
	else:
		velocity.y = 0;
		
	move_and_slide();
		

func handle_input(input_data: InputData) -> void:
	self.input_data = input_data;

func transform_input(movement: Vector2) -> Vector3:
	var vec3_movement: Vector3 = Vector3(movement.x, 0, movement.y);
	vec3_movement = global_transform.inverse() * vec3_movement;
	return vec3_movement;
