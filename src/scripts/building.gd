class_name Building
extends Node2D

var need_type: Dude.NeedType
var capacity: int
var sprite: Sprite2D
var body : StaticBody2D
var is_replaceable: bool = true
signal pressed(building: Building)
var animation_step: float = 0.0

func initialize(position: Vector2) -> void:
	self.position = position
	
func _ready() -> void:
	sprite.z_index = position.y
	body.input_pickable = true
	body.input_event.connect(_on_clicked)
	body.mouse_entered.connect(_on_hover)
	body.mouse_exited.connect(_on_hover_exit)
	
func _on_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_mouse_click"):
		print("clicked on building")
		pressed.emit(self)
		
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
