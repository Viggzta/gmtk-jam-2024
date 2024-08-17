class_name TalkBubble
extends VBoxContainer

@onready var texture_rect: TextureRect = $NinePatchRect/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_texture(t: Texture2D)->void:
	texture_rect.texture = t
