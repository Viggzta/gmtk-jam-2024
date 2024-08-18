class_name Donken extends Building

@onready var drop_particles: CPUParticles2D = $DropParticles
@onready var drop_sound: AudioStreamPlayer2D = $DropSound

func _ready() -> void:
	sprite = $Donken
	body = $Collider
	need_type = Dude.NeedType.Eat
	super._ready()

func building_placed() -> void:
	Globals.camera_shake += 1.5
	drop_particles.emitting = true
	drop_sound.play()
	pass
