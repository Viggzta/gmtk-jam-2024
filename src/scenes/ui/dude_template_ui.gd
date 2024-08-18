class_name DudeTemplateUi
extends HBoxContainer

@onready var rich_text_label: Label = $RichTextLabel

var template: Pair
var max_count: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var percent_count: float = roundf((float(template.count) / float(max_count)) * 100.0)
	rich_text_label.text = str(percent_count) + "%"

	for n: Dude.NeedType in template.needs_array:
		var tex: Texture2D = Helper.get_texture_for_need(n)
		var tr: TextureRect = TextureRect.new()
		tr.texture = tex
		add_child(tr)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_template(t: Pair, max: int) -> void:
	template = t
	max_count = max
