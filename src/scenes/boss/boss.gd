class_name Boss extends Control

signal talk_completed

@onready var open_medium: Sprite2D = $Boss/Mouths/OpenMedium
@onready var open_mouth: Sprite2D = $Boss/Mouths/OpenMouth
@onready var open_close: Sprite2D = $Boss/Mouths/OpenClose

@onready var mouths: Array = [open_medium, open_mouth]
@onready var current_mouth: Sprite2D = open_close
@onready var message: RichTextLabel = $message

var boss_conversation: Array[String] = ["temp"]
var time_per_character : float = 0.01
var wait_time_for_space: float = 0.2
var timer : float = 0
var text_fully_rendered : bool = false
var mouth_should_be_closed: bool = false

var character_index: int = 0
var conversation_index:int = 0
var wait_for_input: bool = false

var start_talking : bool = false
var _wait_timer: float = 0
var target_wait_timer : float = 2.0

@onready var _talker: Talker = $Talker

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	message.text = "" 
	pass # Replace with function body.
	
func reset(convo: Array[String])->void:
	message.text = ""
	boss_conversation = convo
	time_per_character = 0.01
	wait_time_for_space = 0.2
	timer = 0
	text_fully_rendered = false
	mouth_should_be_closed = false

	character_index = 0
	conversation_index = 0
	wait_for_input = false

	start_talking = false
	_wait_timer = 0
	target_wait_timer = 2.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("conversation_skip"):
		if wait_for_input:
			_move_on_to_next_line()
		else:
			_skip_to_end_of_line()
			
	if wait_for_input:
		_wait_timer += delta
		if _wait_timer > target_wait_timer:
			_move_on_to_next_line()
	
	if not text_fully_rendered and not wait_for_input and start_talking:
		_write_text(delta)
		_talk()
	else:
		_close_mouth()
	
	pass
	
func initialize(boss_conversation : Array[String]) -> void:
	self.boss_conversation = boss_conversation
	pass
	
func _write_text(delta:float) -> void:
	if timer <= 0:
		mouth_should_be_closed = false
		var current_message: String = boss_conversation[conversation_index]
		message.text += current_message[character_index]
		var wait_time_char: float = _talker.play_and_get_length(current_message[character_index])
		if wait_time_char > 0.0:
			timer = wait_time_char / 2
		else:
			timer = time_per_character
		character_index += 1
		if character_index == (current_message.length()):
			_handle_end_of_line()
		else:
			if current_message[character_index] == " ":
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

func _move_on_to_next_line()->void:
	conversation_index += 1
	character_index = 0
	message.text = ""
	wait_for_input = false
	_wait_timer = 0

func _close_mouth()->void:
	current_mouth.visible = false
	current_mouth = open_close
	current_mouth.visible = true
	mouth_should_be_closed = true
	
func _handle_end_of_line()->void:
	if (conversation_index + 1) < boss_conversation.size():
		wait_for_input = true
	else:
		text_fully_rendered = true
		talk_completed.emit()
		
func _skip_to_end_of_line()->void:
	message.text = boss_conversation[conversation_index]
	_handle_end_of_line()
