extends RigidBody3D
class_name BranchEntity;

@export var interaction_receiver: InteractionReceiver;
var node: Node;

func _ready() -> void:
	interaction_receiver.can_interact = false;
	interaction_receiver.interaction_started.connect(_on_start);
	interaction_receiver.interaction_stopped.connect(_on_stop);
	interaction_receiver.interaction_tick.connect(_on_tick);

func prepare_branch() -> void:
	freeze = false;
	interaction_receiver.can_interact = true;

func _on_start(_node: Node) -> void:
	if _node is PlayerEntity:
		var player: PlayerEntity = _node;
		player.grab_mouth.node_b = self.get_path();
		node = _node;
		

func _on_stop() -> void:
	if node is PlayerEntity:
		var player: PlayerEntity = node;
		player.grab_mouth.node_b = NodePath("");
	pass;
	
func _on_tick(delta: float) -> void:
	pass;
