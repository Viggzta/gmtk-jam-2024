extends Control

@onready var color_rect: ColorRect = $ColorRect

func _on_camera_zoom_changed(new_zoom_factor: Vector2) -> void:
	color_rect.material.set_shader_parameter("scale", new_zoom_factor)
