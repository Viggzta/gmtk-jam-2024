class_name Cinema extends AuraBuilding

func _ready() -> void:
	sprite = $Cinema
	body = $Collider
	need_type = Dude.NeedType.Entertainment
	super._ready()
	
func _on_dude_enter() -> void: 
	print("call _add_satisfaction in progress bar from here")
	
	
