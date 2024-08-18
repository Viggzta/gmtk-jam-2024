extends Control

const modifier: float = 0.08
const max_percent_per_second: float = 25
const day_modifier:float = 0.005

signal lose
signal win

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ($"/root/Globals".current_state == $"/root/Globals".GameState.Rush):
		var dudes : int = Globals.dude_count
		var needs : int =  Globals.total_needs
		var current_day : int = Globals.current_day

		_debug_print(dudes, needs)
		if(dudes <= 0):
			win.emit()
			return

		var decrease: float = needs * modifier * delta + current_day * day_modifier
		$ProgressBar.value -= clampf(decrease, 0, max_percent_per_second * delta)
		if($ProgressBar.value == 0):
			lose.emit()


func _debug_print(dudes: int, needs:int)->void:
	print("Total dudes: " + str(dudes) + " needs: " + str(needs))
