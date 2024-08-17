extends Sprite2D
@onready var open_medium: Sprite2D = $Mouths/OpenMedium
@onready var open_mouth: Sprite2D = $Mouths/OpenMouth
@onready var open_close: Sprite2D = $Mouths/OpenClose

@onready var mouths: Array = [open_close, open_medium, open_mouth]
@onready var current_mouth: Sprite2D = open_close
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:		
	current_mouth.visible = false
	
	current_mouth = mouths.pick_random()
	current_mouth.visible = true
	pass
