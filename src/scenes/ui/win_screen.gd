extends Control

const FALLING_DUDE = preload("res://scenes/ui/falling_dude.tscn")

@onready var node : Control = $Control
@onready var boss: Boss = $Boss
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

signal pressed_play_again

var total_time_passed: float = 0
var time_passed: float = 0
var target_time_passed: float = 0

var talk_completed: bool = false
var please_leave_timer: float = 0
var please_leave_timer_target: float = 10

var leave_messages: Array[String] = [
	"Please leave.",
	"Press the button.",
	"You can go now.",
	"I don't want to stand here all day.",
	"Hurry up.",
	"Gubben i lådan, gubben i lådan",
	"I love you.",
	"Go play something else. You did it!",
	"Check out \"Perfect Fit\" on Itch.",
	"I need to go get my laundry, please leave.",
	"Poop",
	"Meow",
	"A big thank you to the devs: Victor Jelmlin. Henrik Hedström. Viktor Rörlien. Felix Kaaman. Oliver Dageson",
	"This game was made during the Game Maker's Toolkit Jam 2024"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	var text : Array[String] = [
		"You did it! We survived the tourist rush.", "You're a great mayor, I knew I could count on you dude.",
		"Imagine that our city grew so big because of all these tourists.", "I wonder what we should do about all these toilets now...",
		"Ah well see you next season, dude!"
	]
	boss.initialize(text)
	boss.is_started = false
	

func _process(delta: float) -> void:
	total_time_passed += delta
	time_passed += delta
	if time_passed >= target_time_passed:
		time_passed = 0
		target_time_passed = randf_range(0.05, 0.2)
		for i in range(0, 10):
			_spawn_a_fall_dude()
	
	if talk_completed:
		please_leave_timer += delta
		if please_leave_timer >= please_leave_timer_target:
			boss.reset([leave_messages.pick_random()])
			boss.start_talking = true
			talk_completed = false
			please_leave_timer = 0

func _spawn_a_fall_dude() -> void:
	var dude: Control = FALLING_DUDE.instantiate()
	$Control.add_child(dude)
	dude.position = Vector2(randf_range(0, get_viewport_rect().size.x), 0)

func show_screen() -> void:
	show()
	boss.is_started = true
	boss.start_talking = true
	audio_stream_player_2d.play()
	

func _on_button_pressed() -> void:
	$Click.play()
	await $Click.finished
	get_tree().paused = false
	pressed_play_again.emit()


func _on_boss_talk_completed() -> void:
	talk_completed = true
