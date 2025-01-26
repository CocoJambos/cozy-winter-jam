extends Area3D
class_name DamTrigger;
signal branch_entered;

@export var collision_shape: CollisionShape3D;

func _ready() -> void:
	area_entered.connect(_on_area_entered);

func mark_as_good(node: Node) -> void:
	node.queue_free();
	branch_entered.emit();
	
func enable_dam() -> void:
	collision_shape.disabled = false;

func disable_dam() -> void:
	collision_shape.disabled = true;

func _on_area_entered(area: Area3D) -> void:
	if area is not InteractionReceiver:
		return;
	
	var interaction_receiver: InteractionReceiver = area as InteractionReceiver;
	interaction_receiver._interaction_started(self);
