extends Control
@onready var boss: Boss = $Boss
@onready var scissor: Scissor = $Scissor
var has_started_time: bool = false
var time_after_cut_to_start_game : int = 5


var intro_speech: Array[String] = [
	"Hello! Welcome to the tourist island!",
	"Your new job is to be a mayor of this town.",
	"It's quite easy, just remember to keep the tourists satisfied.",
	"Now time for the boring stuff:",
	"Left-click to select a building from the bottom bar.",
	"Left-click on a house to replace it with the currently selected building.",
	"Right-click a special building to pick it up.",
	"Middle-click + drag to pan the camera.",
	"WASD/←↑↓→ to pan the camera.",
	"Scroll-wheel to zoom.",
	"Esc in the island scene brings up volume sliders.",
	"Go on now, cut the rope!"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boss.initialize(intro_speech)
	boss.start_talking = true
	boss.talk_completed.connect(_on_boss_finished)
	
func _process(delta: float) -> void:
	if scissor.has_cut and not has_started_time:
		has_started_time = true
		await get_tree().create_timer(time_after_cut_to_start_game).timeout
		print("START GAME")
		get_tree().change_scene_to_file("res://scenes/levels/the_level.tscn")

	
func _on_boss_finished() -> void:
	scissor.visible = true
	
	
