class_name House extends Building

@onready var drop_sound: AudioStreamPlayer2D = $DropSound
@onready var drop_particles: CPUParticles2D = $DropParticles

func _ready() -> void:
	need_type = Dude.NeedType.HouseWalk
	sprite = $House
	body = $Collider
	super._ready()

func building_placed() -> void:
	Globals.camera_shake += 1.5
	drop_particles.emitting = true
	drop_sound.play()
	pass
