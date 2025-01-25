extends Node3D;
class_name PlayerSpawner;

@export var player_scene: PackedScene = null;
@export var spawn_point: Marker3D = null;

var player_node: Node3D = null;

signal player_spawned(player: Node3D);

func spawn_player() -> PlayerSpawner:
	player_node = player_scene.instantiate() as Node3D;
	
	if player_node == null:
		printerr("Could not spawn player!!");
	
	player_node.position = spawn_point.position;
	player_node.rotation = spawn_point.rotation;
	# Moźna tutaj dodać jakas sekwencje spawnowania
	get_tree().create_timer(0.5).timeout.connect(func(): player_spawned.emit(player_node));
	return self;
