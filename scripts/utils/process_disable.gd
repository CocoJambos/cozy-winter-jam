extends Node;
class_name ProcessDisable;

@export var nodes_to_disable: Array[Node];

func enable() -> void:
	for node: Node in nodes_to_disable:
		node.set_process(true);
		node.set_physics_process(true);

func disable() -> void:
	for node: Node in nodes_to_disable:
		node.set_process(false);
		node.set_physics_process(false);
