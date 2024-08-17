extends Control

const modifier: float = 0.05

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ($"/root/Globals".current_state == $"/root/Globals".GameState.Rush):
		var dudes : int = $"/root/Globals".dude_count
		$ProgressBar.value -= dudes * modifier * delta
		if($ProgressBar.value == 0):
			$"/root/Globals".current_state = $"/root/Globals".GameState.Failure
