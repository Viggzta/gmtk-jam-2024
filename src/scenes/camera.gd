extends Camera2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom /= 2
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom *= 2
