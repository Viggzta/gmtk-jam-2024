class_name Building
extends Node2D

var need_type: Dude.NeedType
var capacity: int
var sprite: Sprite2D
var body : StaticBody2D

func initialize(position: Vector2) -> void:
	self.position = position
	
	
func _ready() -> void:
	sprite.z_index = position.y
	body.input_pickable =true
	body.input_event.connect(_on_clicked)
	body.mouse_entered.connect(_on_hover)
	
func _on_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_mouse_click"):
		print("clicked on building")
		
func _on_hover() -> void:
	print("hovering on building")
