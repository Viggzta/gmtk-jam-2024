class_name Hospital extends Building

@onready var drop_particles: CPUParticles2D = $DropParticles
@onready var drop_sound: AudioStreamPlayer2D = $DropSound

func _ready() -> void:
	sprite = $Hospital
	body = $Collider
	need_type = Dude.NeedType.MedicalCare
	super._ready()

func building_placed() -> void:
	Globals.camera_shake += 2.5
	drop_particles.emitting = true
	drop_sound.play()
	pass
