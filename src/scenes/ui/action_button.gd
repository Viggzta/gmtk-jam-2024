class_name ActionButton

extends TextureButton

var building_type: BuildingType.Type

var _hoover: bool = false
var _animation_step: float = 0.0

func initialize(texture: Texture2D, type: BuildingType.Type) -> void:
	$BuildingTexture.texture = texture
	building_type = type
	
func _process(delta: float) -> void:
	if _hoover:
		_animation_step += delta
		var current_animation: float = abs(sin(0.525 + _animation_step * 2))
		rotation_degrees = -10 + Interpolation.smooth_start(current_animation) * 20;


func _on_mouse_entered() -> void:
	_animation_step = 0
	_hoover = true

func _on_mouse_exited() -> void:
	_animation_step = 0
	rotation_degrees = 0
	_hoover = false

func set_level_count(count : int) -> void:
	$Count.text = str(count)

func _on_pressed() -> void:
	Globals.current_building_type = building_type
