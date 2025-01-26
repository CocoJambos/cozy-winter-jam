extends Node3D
class_name TreeEntity;

@export var interaction_receiver: InteractionReceiver;
@export var chop_total_time_sec: float = 3.0;
@export var bark: Node3D;
@export var bark_entity: BarkEntity;
@export var chop_force_scalar: float;
@export var audio_stream: AudioStreamPlayer3D;
@export var audio_stream_branch: AudioStreamPlayer3D;

@export var bites: Array[AudioStreamOggVorbis];

var node: Node;
var current_chop_time: float = 0;
var cached_bark_scale: Vector3;

func _ready() -> void:
	interaction_receiver.interaction_started.connect(_on_started);
	interaction_receiver.interaction_stopped.connect(_on_stopped);
	interaction_receiver.interaction_tick.connect(_on_tick);
	cached_bark_scale = bark.scale;

func _on_tick(delta: float) -> void:
	current_chop_time += delta;
	
	var normalized_time: float = current_chop_time / chop_total_time_sec;
	var bark_scale: float = 1 - normalized_time;
	bark.scale = bark_scale * cached_bark_scale;
	
	if !audio_stream_branch.playing:
		var rand: int = randi() % bites.size() - 1;
		var sound: AudioStreamOggVorbis = bites[rand];
		audio_stream_branch.stream = sound;
		audio_stream_branch.play();
	
	if current_chop_time < chop_total_time_sec:
		return;
	
	audio_stream.play();
	var caller: Node3D = node as Node3D;
	var impulse: Vector3 = (bark_entity.global_position - caller.global_position).normalized() * chop_force_scalar;
	bark_entity.awake_bark(impulse);
	interaction_receiver.can_interact = false;
	interaction_receiver.queue_free();

func _on_started(_node: Node) -> void:
	node = _node;

func _on_stopped() -> void:
	node = null;
