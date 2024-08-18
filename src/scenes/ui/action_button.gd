class_name ActionButton

extends TextureButton
@onready var glow_texture: TextureRect = $GlowTexture

var building_type: BuildingType.Type
var _is_selected: bool = false 
var is_selected: bool:
	get:
		return _is_selected
	set(value):
		if value:
			glow_texture.show()
		else:
			glow_texture.hide()
		_is_selected = value

var _hoover: bool = false
var _animation_step: float = 0.0

var _parent_action_bar: ActionBar

func initialize(texture: Texture2D, type: BuildingType.Type, action_bar: ActionBar) -> void:
	$BuildingTexture.texture = texture
	building_type = type
	_parent_action_bar = action_bar
	set_level_count(0)
	
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
	if count <= 0:
		hide()
	else:
		show()
	$Count.text = str(count)

func _on_pressed() -> void:
	_parent_action_bar.reset_selection()
	is_selected = true
	Globals.current_building_type = building_type
