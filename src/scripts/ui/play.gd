extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	$Click.play()
	await $Click.finished
	get_tree().change_scene_to_file("res://scenes/levels/the_level.tscn")

func _on_mouse_entered() -> void:
	$Hover.play()
	self.material.set_shader_parameter("active", true)


func _on_mouse_exited() -> void:
	self.material.set_shader_parameter("active", false)
