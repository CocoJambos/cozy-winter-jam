extends Node
class_name WaterPlane;

@export var water_plane: Node3D;
@export var starting_height: Marker3D;
@export var target_dam: DamEntity;

var starting_water_hight: float;
var current_tween: Tween;

func _ready() -> void:
	starting_water_hight = water_plane.global_position.y;
	water_plane.global_position.y = starting_height.global_position.y;
	target_dam.dam_progress.connect(_on_dam_progress);

func _on_dam_progress(current: int, total: int) -> void:
	if current_tween != null && current_tween.is_running():
		current_tween.stop();
		
	
	var starting_height: float = starting_height.global_position.y;
	var target_height: float = starting_water_hight;
	var normalized_value: float = float(current) / float(total);
	var desired_height: float = lerpf(starting_height, target_height, normalized_value);
	
	# TODO: add water animation
	water_plane.global_position.y = desired_height;
