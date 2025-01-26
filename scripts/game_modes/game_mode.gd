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
@export var details_ui: DetailsUI;
@export var end_ui: EndUI;

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
	
	details_ui.show_ui();
	details_ui.state_changed.connect(details_ui_state);
	input_provider.input_chaged.connect(details_ui._on_input_changed);
	
	var is_closed: bool = await details_ui.state_changed;
	
	for dam: DamEntity in dams:
		dam.dam_progress.connect(dam_progress);
	
	unpause_game();
	await game_is_finished;
	
	input_provider.input_chaged.disconnect(details_ui._on_input_changed);
	details_ui.state_changed.disconnect(details_ui_state);
	details_ui.hide_ui();
	#display end screen;
	pause_game();
	end_ui.show();

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
		
func details_ui_state(state: bool) -> void:
	if state:
		pause_game();
		return;
	
	unpause_game();
