extends Node2D

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed && event.keycode == KEY_A:
			$CanvasLayer/WinScreen.show_screen()
