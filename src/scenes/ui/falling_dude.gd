extends Control

var dude_texture: Array[Texture2D] = [
	preload("res://art/dude1.png"),
	preload("res://art/dude2.png"),
	preload("res://art/dude3.png"),
	preload("res://art/dude4.png"),
]

var fall_speed: float = 5.0
var rotation_speed: float = 0

func _ready() -> void:
	var random_index: int = randi_range(0, len(dude_texture) - 1)
	$Sprite2D.texture = dude_texture[random_index]
	$Sprite2D.modulate = Color(randf(), randf(), randf())
	fall_speed = randf_range(4, 10)
	rotation_speed = randf_range(-5, 5)

func _process(delta: float) -> void:
	position.y += fall_speed
	rotation_degrees += rotation_speed
	if position.y >= get_viewport_rect().size.y + 200:
		self.queue_free()
