extends Control

@onready var color_rect: ColorRect = $ColorRect

func _on_camera_zoom_changed(new_zoom_factor: float) -> void:
	color_rect.material.set_shader_param("scale", new_zoom_factor)
