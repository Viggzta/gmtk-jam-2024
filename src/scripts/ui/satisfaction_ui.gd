extends Control

const modifier: float = 0.14
const max_percent_per_second: float = 50

signal lose
signal win

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Globals.current_state == Globals.GameState.Rush):
		var dudes : int = Globals.dude_count
		if(dudes <= 0):
			win.emit()
			return
		
		$ProgressBar.value -= clampf(dudes * modifier * delta, 0, max_percent_per_second * delta)
		if($ProgressBar.value == 0):
			lose.emit()
