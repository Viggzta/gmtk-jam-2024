class_name ShitHouse extends Building

@onready var drop_particles: CPUParticles2D = $DropParticles
@onready var drop_sound: AudioStreamPlayer2D = $DropSound

func _ready() -> void:
	need_type = Dude.NeedType.Poop
	sprite = $"Baja-maja"
	body = $StaticBody2D
	super._ready()

func building_placed() -> void:
	drop_particles.emitting = true
	drop_sound.play()
	pass
