extends Node;
class_name GameMode;

@export var player_spawner: PlayerSpawner;
@export var input_provider: InputProvider;

var player_entity: PlayerEntity;

func _start_game() -> void:
	var player: Node3D = await player_spawner.spawn_player().player_spawned;
	assert(player);
	player_entity = player as PlayerEntity;
	assert(player_entity);
