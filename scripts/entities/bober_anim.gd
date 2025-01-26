extends Node3D
class_name BoberAnim;

@export var player: AnimationPlayer;

func play() -> void:
	if player.is_playing():
		return;
		
	player.play("Beaver_Run");
	
func stop() -> void:
	player.stop(false);
