class_name Niteclub extends Building

@onready var drop_particles: CPUParticles2D = $DropParticles
@onready var drop_sound: AudioStreamPlayer2D = $DropSound

func _ready() -> void:
	sprite = $Niteclub
	body = $Collider
	need_type = Dude.NeedType.Entertainment
	super._ready()

func building_placed() -> void:
	Globals.camera_shake += 1.5
	drop_particles.emitting = true
	drop_sound.play()
	pass
