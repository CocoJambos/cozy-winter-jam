extends RigidBody3D
class_name BranchEntity;

@export var interaction_receiver: InteractionReceiver;
@export var pivot: Node3D;
var node: Node;

func _ready() -> void:
	interaction_receiver.can_interact = false;
	interaction_receiver.interaction_started.connect(_on_start);
	interaction_receiver.interaction_stopped.connect(_on_stop);
	interaction_receiver.interaction_tick.connect(_on_tick);
	set_process(false);

func _process(delta: float) -> void:
	if node == null || node is not PlayerEntity:
		return;
	
	var player: PlayerEntity = node as PlayerEntity;
	global_rotation = player.grab_mouth.global_rotation;
	global_position = player.grab_mouth.global_position;

func prepare_branch() -> void:
	freeze = false;
	interaction_receiver.can_interact = true;

func _on_start(_node: Node) -> void:
	if _node is PlayerEntity:
		var player: PlayerEntity = _node;
		
		global_rotation = player.grab_mouth.global_rotation;
		global_position = player.grab_mouth.global_position;
		
		freeze = true;
		freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC;
		
		add_collision_exception_with(_node);
		
		node = _node;
		set_process(true);
		return;
	
	if _node is DamTrigger:
		var dam: DamTrigger = _node;
		dam.mark_as_good(self);
		

func _on_stop() -> void:
	if node is PlayerEntity:
		var player: PlayerEntity = node;
		set_process(false);
		remove_collision_exception_with(node);
		freeze = false;
		
	node = null;
	
func _on_tick(delta: float) -> void:
	pass;
