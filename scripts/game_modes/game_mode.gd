extends Node;
class_name GameMode;

@export var player_spawner: PlayerSpawner;
@export var input_provider: InputProvider;
@export var game_map: Node3D;
@export var loading_ui: LoadingUI;

var player_entity: PlayerEntity;

func _ready() -> void:
	_start_game();

func _start_game() -> void:
	var player: Node3D = await player_spawner.spawn_player().player_spawned;
	assert(player);
	player_entity = player as PlayerEntity;
	assert(player_entity);
	game_map.add_child(player_entity);
	input_provider.input_chaged.connect(_on_input_changed);
	
	for to_disable: ProcessDisable in GameData.node_disablers.values():
		to_disable.disable();
	
	await loading_ui._start_closing().close;
	loading_ui.hide();
	
func _on_input_changed(input_data: InputData) -> void:
	player_entity.handle_input(input_data);
