class_name Boss extends Control
@onready var open_medium: Sprite2D = $Boss/Mouths/OpenMedium
@onready var open_mouth: Sprite2D = $Boss/Mouths/OpenMouth
@onready var open_close: Sprite2D = $Boss/Mouths/OpenClose

@onready var mouths: Array = [open_medium, open_mouth]
@onready var current_mouth: Sprite2D = open_close
@onready var message: RichTextLabel = $message

var boss_message: String = "temp"
var time_per_character : float = 0.01
var wait_time_for_space: float = 0.2
var timer : float = 0
var text_fully_rendered : bool = false
var mouth_should_be_closed: bool = false

var character_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	message.text = ""
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:		
	
	if not text_fully_rendered:
		_write_text(delta)
		_talk()
	else:
		_close_mouth()
	
	pass
	
func initialize(boss_message : String) -> void:
	self.boss_message = boss_message
	pass
	
func _write_text(delta:float) -> void:
	if timer <= 0:
		mouth_should_be_closed = false
		message.text += boss_message[character_index]
		character_index += 1
		timer = time_per_character
		if character_index == (boss_message.length()):
			text_fully_rendered = true
		else:
			if boss_message[character_index] == " ":
				timer += wait_time_for_space
				_close_mouth()
	else:
		timer-= delta
	
func _talk()->void:
	if mouth_should_be_closed:
		return
	current_mouth.visible = false
	current_mouth = mouths.pick_random()
	current_mouth.visible = true

func _close_mouth()->void:
	current_mouth.visible = false
	current_mouth = open_close
	current_mouth.visible = true
	mouth_should_be_closed = true
	
	
	
	
