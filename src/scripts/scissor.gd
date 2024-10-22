class_name Scissor extends Node2D
@onready var scissor_closed: Sprite2D = $ScissorClosed
@onready var scissor_open: Sprite2D = $ScissorOpen

const FIRE_AND_FORGET_SOUND = preload("res://scenes/fx/fire_and_forget_sound.tscn")
var rope_that_is_touched:Area2D 
var time_after_cut_to_start_game : bool = false
var has_cut :bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_to_visible(scissor_open)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	
	if self.visible:
		if Input.is_action_pressed("left_mouse_click"):
			_set_to_visible(scissor_closed)
		else:
			_set_to_visible(scissor_open)
			
		if Input.is_action_just_pressed("left_mouse_click"):
			_cut()			
	
func _set_to_visible(scissor_image :Sprite2D)->void:
	scissor_closed.visible = false
	scissor_open.visible = false
	scissor_image.visible = true
	
func _cut()-> void:
	
	if rope_that_is_touched != null:
		has_cut = true
		rope_that_is_touched.get_parent().queue_free()
		_play_rope_sound(FireAndForgetSound.SoundClips.CutRope)
	else:
		_play_rope_sound(FireAndForgetSound.SoundClips.Cut)



func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	rope_that_is_touched = area


func _on_area_2d_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	rope_that_is_touched = null
	
func _play_rope_sound(sound_clip: FireAndForgetSound.SoundClips)->void:
	var sound: FireAndForgetSound = FIRE_AND_FORGET_SOUND.instantiate()
	sound.set_and_play(sound_clip)
	add_child(sound)
