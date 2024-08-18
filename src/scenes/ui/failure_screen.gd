extends Control

var center : Vector2
@onready var node : Control = $Control
@onready var boss: Boss = $Boss

signal pressed_try_again

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	var text : Array[String] = ["You're fired!"]
	boss.initialize(text)
	center = Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tween : Tween = node.create_tween()
	var offset : Vector2 = center - get_global_mouse_position() * 0.1
	tween.tween_property(node, "position", offset, 1.0)

func show_screen() -> void:
	show()
	boss.start_talking = true
	

func _on_button_pressed() -> void:
	get_tree().paused = false
	pressed_try_again.emit()
