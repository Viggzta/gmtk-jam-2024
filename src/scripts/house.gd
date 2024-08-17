class_name House extends Building

func _ready() -> void:
	need_type = Dude.NeedType.Eat
	sprite = $House
	body = $Collider
	super._ready()


#func _on_collider_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#if event.is_action_pressed("left_mouse_click"):
		#print("clicked on house")
