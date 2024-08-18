extends Control
const BOSS = preload("res://scenes/boss/boss.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var intro_boss : Boss = BOSS.instantiate()
	intro_boss.initialize(["Yooo, congratulations on your new job as mayor!", "The people will move in today"])
	add_child(intro_boss)
	intro_boss.start_talking = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
