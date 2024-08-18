class_name Building
extends Node2D

var need_type: Dude.NeedType
var capacity: int
var sprite: Sprite2D
var body : StaticBody2D
var is_replaceable: bool = true
signal pressed(building: Building)
signal right_pressed(building: Building)
var animation_step: float = 0.0
var building_type: BuildingType.Type

func initialize(position: Vector2, building_type: BuildingType.Type) -> void:
	self.position = position
	self.building_type = building_type
	
func _ready() -> void:
	sprite.z_index = position.y
	body.input_pickable = true
	body.input_event.connect(_on_clicked)
	body.mouse_entered.connect(_on_hover)
	body.mouse_exited.connect(_on_hover_exit)
	var pos: Vector2 = Vector2(sprite.position.x, sprite.position.y)
	sprite.position.y -= 150
	sprite.scale = Vector2(2.5, 2.5)
	var animation_time: float = 0.3 + randf() * 0.5
	get_tree().create_tween().tween_property(sprite, "position", Vector2(pos.x, pos.y), animation_time).set_trans(Tween.TRANS_ELASTIC)
	get_tree().create_tween().tween_property(sprite, "scale", Vector2(1, 1), animation_time).set_trans(Tween.TRANS_ELASTIC)
	
func _on_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_mouse_click"):
		print("Left clicked building")
		pressed.emit(self)
	if event.is_action_pressed("right_mouse_click"):
		print("Right clicked building")
		right_pressed.emit(self)
		
func _on_hover() -> void:
	if !is_replaceable || Globals.current_state != Globals.GameState.Setup:
		return
	print("hovering on building")
	sprite.scale = Vector2(1.2, 1.2)

func _on_hover_exit() -> void:
	if !is_replaceable || Globals.current_state != Globals.GameState.Setup:
		return
	print("hovering exoit on building")
	sprite.scale = Vector2(1, 1)
	
func _process(delta: float) -> void:
	if Globals.current_state == Globals.GameState.Setup && is_replaceable:
		animation_step += delta * 4
		var temp_scale: float = 1 + (sin(animation_step) * 0.1)
		sprite.scale.y = temp_scale
		return
	scale = Vector2.ONE
