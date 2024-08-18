extends Control

@onready var platform: ColorRect = $ColorRectPlatform
@onready var water: ColorRect = $ColorRectWater

func _ready() -> void:
	process_mode = Node.ProcessMode.PROCESS_MODE_DISABLED
