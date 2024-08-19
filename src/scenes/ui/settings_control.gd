extends Control
@onready var fx_slider: HSlider = $SoundFX/Slider
@onready var music_slider: HSlider = $Music/Slider

func _ready() -> void:
	hide()
	
	print("setting fx to " + str(db_to_linear(Globals.sound_fx_volume)) )
	print("setting music to " + str(db_to_linear(Globals.music_volume)) )
	fx_slider.value = db_to_linear(Globals.sound_fx_volume)
	music_slider.value = db_to_linear(Globals.music_volume)
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE && event.pressed:
			visible = !visible

func _on_sound_fx_slider_value_changed(value: float) -> void:
	Globals.sound_fx_volume = value


func _on_music_slider_value_changed(value: float) -> void:
	Globals.music_volume = value
