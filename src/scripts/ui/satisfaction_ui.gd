extends Control

const modifier: float = 0.08

signal lose
signal win

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ($"/root/Globals".current_state == $"/root/Globals".GameState.Rush):
		var dudes : int = $"/root/Globals".dude_count
		var needs : int =  $"/root/Globals".total_needs
		_debug_print(dudes, needs)
		if(dudes <= 0):
			win.emit()
			return
		
		$ProgressBar.value -= needs * modifier * delta
		if($ProgressBar.value == 0):
			lose.emit()


func _debug_print(dudes: int, needs:int)->void:
	print("Total dudes: " + str(dudes) + " needs: " + str(needs))
