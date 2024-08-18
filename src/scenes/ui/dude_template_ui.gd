class_name DudeTemplateUi
extends HBoxContainer

@onready var rich_text_label: Label = $RichTextLabel

var template: Pair

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rich_text_label.text = "x" + str(template.count)

	for n: Dude.NeedType in template.needs_array:
		var tex: Texture2D = Helper.get_texture_for_need(n)
		var tr: TextureRect = TextureRect.new()
		tr.texture = tex
		add_child(tr)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_template(t: Pair) -> void:
	template = t
