extends AudioStreamPlayer2D

func _ready() -> void:
	play(0)

func _on_finished() -> void:
	play(0)
