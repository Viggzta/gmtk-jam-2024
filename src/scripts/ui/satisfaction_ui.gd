extends Control

const modifier: float = 0.08
const max_percent_per_second: float = 7
const day_modifier:float = 0.005

signal lose
signal win
@onready var progress_bar: ProgressBar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if (Globals.current_state == Globals.GameState.Rush):
		var dudes : int = Globals.dude_count
		var needs : int =  Globals.total_needs
		var current_day : int = Globals.current_day

		if(dudes <= 0):
			win.emit()
			return

		var decrease: float = needs * modifier * delta + clampf(current_day * day_modifier, 0, 0.025)
		progress_bar.value -= clampf(decrease, 0, max_percent_per_second * delta)
		if Globals.incoming_satisfaction_buff > 0:
			progress_bar.value += Globals.incoming_satisfaction_buff
			Globals.incoming_satisfaction_buff = 0
		
		if(progress_bar.value == 0):
			lose.emit()

func _add_satisfaction(delta : float) -> void:
		progress_bar.value += delta
	
