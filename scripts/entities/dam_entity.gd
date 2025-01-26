extends Node3D
class_name DamEntity;
signal dam_progress(current: int, total: int);

@export var branches: Array[Node3D];
@export var dam_trigger: DamTrigger = null;
@export var enable_on_start: bool;
@export var dam_player_scene: PackedScene;

var dam_player: AudioStreamPlayer3D;

var current_progress: int = 0;

func _ready() -> void:
	for branch: Node3D in branches:
		branch.hide();
	
	if !enable_on_start:
		dam_trigger.call_deferred("disable_dam");
	
	dam_player = dam_player_scene.instantiate() as AudioStreamPlayer3D;
	add_child(dam_player);
	dam_trigger.branch_entered.connect(_on_branch_enter);

func _on_branch_enter() -> void:
	current_progress += 1;
	branches[current_progress - 1].show();
	
	dam_progress.emit(current_progress, branches.size());
	dam_player.play();
	
	if current_progress >= branches.size():
		dam_trigger.call_deferred("disable_dam");

	
func enable_dam() -> void:
	dam_trigger.call_deferred("enable_dam");
