extends Control

@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	process_mode = Node.ProcessMode.PROCESS_MODE_DISABLED
