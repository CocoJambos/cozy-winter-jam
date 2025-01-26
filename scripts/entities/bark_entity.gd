extends RigidBody3D;
class_name BarkEntity;

@export var impulse_position: Node3D;
@export var branches: Array[BranchEntity];


func awake_bark(impulse: Vector3) -> void:
	freeze = false;
	apply_impulse(impulse, impulse_position.global_position);
	
	for branch: BranchEntity in branches:
		remove_child(branch);
		get_parent().add_child(branch);
		branch.prepare_branch();
	
