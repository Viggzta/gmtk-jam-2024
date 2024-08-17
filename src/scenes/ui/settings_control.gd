extends Control

func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE && event.pressed:
			visible = !visible

func _on_sound_fx_slider_value_changed(value: float) -> void:
	Globals.sound_fx_volume = value


func _on_music_slider_value_changed(value: float) -> void:
	Globals.music_volume = value
