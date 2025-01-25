extends Node

var node_disablers: Dictionary[int, ProcessDisable] = {};

func register_node_disabler(node_disabler: ProcessDisable) -> void:
	var node_id: int = node_disabler.get_instance_id();
	
	if node_disablers.has(node_id):
		return;
	
	node_disablers[node_id] = node_disabler;

func unregister_node_disabler(node_disabler: ProcessDisable) -> void:
	var node_id: int = node_disabler.get_instance_id();
	node_disablers.erase(node_id);

func clear_game_data() -> void:
	node_disablers.clear();
