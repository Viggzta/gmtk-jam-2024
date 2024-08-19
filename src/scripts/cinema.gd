class_name Cinema extends AuraBuilding

@onready var drop_particles: CPUParticles2D = $DropParticles
@onready var drop_sound: AudioStreamPlayer2D = $DropSound


func _ready() -> void:
	sprite = $Cinema
	body = $Collider
	need_type = Dude.NeedType.Entertainment
	super._ready()
	
func _on_dude_enter() -> void:
	Globals.incoming_satisfaction_buff += 0.3
	

func building_placed() -> void:
	Globals.camera_shake += 1.5
	drop_particles.emitting = true
	drop_sound.play()
	pass
	
