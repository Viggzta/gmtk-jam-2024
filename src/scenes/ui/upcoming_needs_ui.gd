extends Control

const DUDE_TEMPLATE_UI = preload("res://scenes/ui/DudeTemplateUI.tscn")
@onready var v_box_container: VBoxContainer = $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_level_definition(day: int) -> void:
	print("set level definition for: ", day)
	for c: Node in v_box_container.get_children():
		v_box_container.remove_child(c)

	var definition: Array = Globals.level_needs[day]
	var total_dudes: int = 0
	for t: Pair in definition:
		total_dudes += t.count
	
	for t: Pair in definition:
		var dude_ui: DudeTemplateUi = DUDE_TEMPLATE_UI.instantiate()
		dude_ui.set_template(t, total_dudes)
		v_box_container.add_child(dude_ui)
		pass
	pass
