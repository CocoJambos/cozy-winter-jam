extends CanvasLayer

@export var shader_material: ShaderMaterial; 

func _ready() -> void:
	_size_changed();
	get_viewport().size_changed.connect(_size_changed);
	
func _size_changed() -> void:
	print(get_viewport().size);
	shader_material.set_shader_parameter("screen_size", get_viewport().size);
