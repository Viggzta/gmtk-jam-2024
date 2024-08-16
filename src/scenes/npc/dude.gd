extends RigidBody2D

@onready var sprite_2d: Sprite2D = $ImageRoot/Sprite2D
@onready var image_root: Node2D = $ImageRoot
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var animation_step: float = 0
var animation_step_move: float = 0
var animation_direction: float = 1
var animation_direction_move: float = 1
var movement_speed: float = 5.0
var current_movement_speed: float = 0.0
var movement_target_position: Vector2 = Vector2(60.0, 180.0)

func _ready() -> void:
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	# Make sure to not await during _ready.
	call_deferred("actor_setup")
	
	animation_step = randf()
	animation_step_move = randf()
	sprite_2d.modulate = Color(randf(), randf(), randf())

func actor_setup() -> void:
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2) -> void:
	navigation_agent.target_position = movement_target

func _physics_process(_delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	# print("current: ", current_agent_position, " next: ", next_path_position)
	var velocity: Vector2 = current_agent_position.direction_to(next_path_position) * movement_speed
	current_movement_speed = velocity.length()
	move_and_collide(velocity)

func _process(delta: float) -> void:
	_update_animation_step(delta)
	image_root.scale.y = 0.75 + (0.25 * Interpolation.smooth_step(animation_step_move))
	image_root.rotation_degrees = -30.0 + (60.0 * animation_step_move)
	sprite_2d.z_index = int(position.y)

func _update_animation_step(delta: float) -> void:
	animation_step += delta * animation_direction
	if animation_step > 1.0:
		animation_direction *= -1.0
		animation_step =  1 - (animation_step - 1)
	if animation_step < 0.0:
		animation_direction *= -1.0
		animation_step =  animation_step * -1.0

	animation_step_move += delta * animation_direction_move * current_movement_speed
	if animation_step_move > 1.0:
		animation_direction_move *= -1.0
		animation_step_move =  1 - (animation_step_move - 1)
	if animation_step_move < 0.0:
		animation_direction_move *= -1.0
		animation_step_move = animation_step_move * -1.0
