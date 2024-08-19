extends Node2D
@onready var boss: Boss = $Boss
@onready var scissor: Node2D = $Scissor


var intro_speech: Array[String] = [
	"Hello! Welcome to the tourist island!",
	"Your new job is to be a mayor of this town.",
	"It's quite easy, just remember to keep the tourists satisfied.",
	"Go on now, cut the rope!"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boss.initialize(intro_speech)
	boss.start_talking = true
	
