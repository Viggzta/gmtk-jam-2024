extends Control

const DUDE_TEMPLATE_UI = preload("res://scenes/ui/DudeTemplateUI.tscn")
@onready var v_box_container: VBoxContainer = $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func calculate_upcoming_needs() -> void:
	var total_shit_nr : int = 0
	var total_food_nr : int = 0
	
	for needsForADay: Array in Globals.level_needs[Globals.current_day]:
		for needPair: Pair in needsForADay:
			for need : Dude.NeedType in needPair.needs_array:
				match need:
					Dude.NeedType.Poop:
						total_shit_nr += needPair.count
					Dude.NeedType.Eat:
						total_food_nr += needPair.count

	var total_need_nr : int = total_shit_nr + total_food_nr
	print(total_need_nr)
	var food_percent : float = 0
	var shit_percent : float = 0
	if(total_food_nr > 0):
		food_percent = ((float(total_food_nr) / total_need_nr)) * 100

	if(total_shit_nr > 0):
		shit_percent = ((float(total_shit_nr) / total_need_nr)) * 100

	$FoodTxt.text = str(int(food_percent)) + "%"
	$ShitTxt.text = str(int(shit_percent)) + "%"
