extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	get_tree().quit()

func _on_mouse_entered() -> void:
	print("Hello?")
	self.material.set_shader_parameter("active", true)

func _on_mouse_exited() -> void:
	self.material.set_shader_parameter("active", false)
