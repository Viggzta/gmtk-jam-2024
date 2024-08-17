extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	self_modulate.darkened(0.2)


func _on_mouse_entered() -> void:
	self.material.set_shader_parameter("active", true)

func _on_mouse_exited() -> void:
	self.material.set_shader_parameter("active", false)
