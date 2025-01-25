extends CharacterBody3D;
class_name PlayerEntity;

@export var acceleration: float = 300;
@export var max_speed: float = 300;
@export var deceleration: float  = 300;
@export var min_camera_degree: float = -45;
@export var max_camera_degree: float = 45;
@export var rotate_speed: float = 10;
@export var gravity: float = 9.81;
@export var spring_arm: SpringArm3D;
@export var camera: Camera3D;

var input_data: InputData = null;

func _ready() -> void:
	camera.make_current();

func _process(delta: float) -> void:
	if input_data == null:
		return;
	
	camera_movement(delta);
	body_movement(delta);

func handle_input(input_data: InputData) -> void:
	self.input_data = input_data;

func transform_input(movement: Vector2) -> Vector3:
	var vec3_movement: Vector3 = Vector3(-movement.x, 0, -movement.y);
	vec3_movement = basis.z * vec3_movement.z + basis.x * vec3_movement.x;
	return vec3_movement;

func body_movement(delta: float) -> void:
	if !is_on_floor():
		velocity.y = move_toward(velocity.y, max_speed, -gravity * delta);
	else:
		velocity.y = 0;
	
	var transformed_input = transform_input(input_data.movement_input);
	velocity.x = move_toward(velocity.x, transformed_input.x * max_speed, acceleration * delta);
	velocity.z = move_toward(velocity.z, transformed_input.z * max_speed, acceleration * delta);
	
	move_and_slide();

func camera_movement(delta: float) -> void:
	if input_data.mouse_input.is_zero_approx() || !input_data.mouse_input_triggered:
		return;
	
	rotate_y(rotate_speed * input_data.mouse_input.x * delta);
	spring_arm.rotate_x(rotate_speed * input_data.mouse_input.y * delta);
	var x_rotation = spring_arm.rotation_degrees.x;
	spring_arm.rotation_degrees.x = clampf(x_rotation, min_camera_degree, max_camera_degree);
	input_data.mouse_input_triggered = false;
