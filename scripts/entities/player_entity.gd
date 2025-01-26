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
@export var interaction_cast: ShapeCast3D;
@export var grab_mouth: Node3D;

var interaction_receiver: InteractionReceiver;
var input_data: InputData = null;
var blocked_movement: bool = false;

func _ready() -> void:
	camera.make_current();
	input_data = InputData.new();

func _process(delta: float) -> void:
	if blocked_movement:
		velocity = Vector3.ZERO;
		return;
	
	camera_movement(delta);
	body_movement(delta);
	
func _physics_process(delta: float) -> void:
	blocked_movement = interaction(delta);

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

func clear_interaction() -> void:
	if interaction_receiver == null:
		return;

	interaction_receiver._interaction_stopped();
	interaction_receiver = null;

func interaction(delta: float) -> bool:
	if !input_data.action_input:
		clear_interaction();
		return false;
	
	if !interaction_cast.is_colliding():
		clear_interaction();
		return false;
	
	if interaction_receiver == null:
		var collision_object: CollisionObject3D = null;
		var closest_distance: float = 99999;
		
		for data: Dictionary in interaction_cast.collision_result:
			var point: Vector3 = data["point"] as Vector3;
			var collision: CollisionObject3D = data["collider"] as CollisionObject3D;
			var distance: float = point.distance_to(interaction_cast.global_position);
			
			if distance > closest_distance:
				continue;
				
			collision_object = collision;
			closest_distance = distance;
		
		var interaction: InteractionReceiver = collision_object as InteractionReceiver;
		
		if interaction == null || !interaction.can_interact:
			return false;
		
		interaction._interaction_started(self);
		interaction_receiver = interaction;
	
	interaction_receiver._interaction_tick(delta);
	return interaction_receiver.block_movement;
	
		
	
