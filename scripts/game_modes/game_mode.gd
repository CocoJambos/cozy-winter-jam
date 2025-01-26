extends Node;
class_name GameMode;
signal game_is_finished;

@export var player_spawner: PlayerSpawner;
@export var input_provider: InputProvider;
@export var game_map: Node3D;
@export var loading_ui: LoadingUI;
@export var loop: AudioStreamPlayer;
@export var ambient: AudioStreamPlayer;
@export var dams: Array[DamEntity];

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
	
	pause_game();
	
	await loading_ui._start_closing().close;
	loading_ui.hide();
	
	loop.play();
	ambient.play();
	
	for dam: DamEntity in dams:
		dam.dam_progress.connect(dam_progress);
	
	unpause_game();
	await game_is_finished;
	
	#display end screen;
	pause_game();

func pause_game() -> void:
	for to_disable: ProcessDisable in GameData.node_disablers.values():
		to_disable.disable();

func unpause_game() -> void:
	for to_disable: ProcessDisable in GameData.node_disablers.values():
		to_disable.enable();
	
func _on_input_changed(input_data: InputData) -> void:
	player_entity.handle_input(input_data);

func dam_progress(current: int, total: int) -> void:
	var are_finished = dams.all(func(dam: DamEntity): dam.is_finished);
	if are_finished:
		game_is_finished.emit();
