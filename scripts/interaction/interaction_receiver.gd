extends Area3D;
class_name InteractionReceiver;

signal interaction_tick(delta: float);
signal interaction_started(node: Node);
signal interaction_stopped();

@export var block_movement: bool = false;

var can_interact: bool = true;

func _interaction_started(node: Node) -> void:
	interaction_started.emit(node);

func _interaction_tick(delta: float) -> void:
	interaction_tick.emit(delta);

func _interaction_stopped() -> void:
	interaction_stopped.emit();
