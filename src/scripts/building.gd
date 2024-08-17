class_name Building
extends Node2D

var need_type: Dude.NeedType
var capacity: int
var sprite: Sprite2D

func initialize(position: Vector2) -> void:
	self.position = position
	
func _ready() -> void:
	sprite.z_index = position.y
