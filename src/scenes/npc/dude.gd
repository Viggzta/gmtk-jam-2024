class_name Dude
extends RigidBody2D

enum NeedType {Poop, Eat}

@onready var sprite_2d: Sprite2D = $ImageRoot/Sprite2D
@onready var image_root: Node2D = $ImageRoot
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var movement_speed: float = 200.0
var current_movement_speed: float = 0.0
var movement_target_position: Vector2 = Vector2(60.0, 180.0)
var lastpos: Vector2
var id: int

var need_position: Vector2
var building_root: Node2D

var needs: Array = [NeedType.Poop]

func initialize(position:Vector2, needs: Array, building_root: Node2D) -> void:
	self.position = position
	self.needs = needs
	self.building_root = building_root

func _ready() -> void:
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	# Make sure to not await during _ready.
	call_deferred("actor_setup")
	
	id = randi()
	sprite_2d.modulate = Color(randf(), randf(), randf())
	
	var need: NeedType = needs[0]
	
	var need_node: Building = get_need_location()
	movement_target_position = need_node.position
	

func actor_setup() -> void:
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2) -> void:
	movement_target_position = movement_target
	navigation_agent.target_position = movement_target

func _physics_process(_delta: float) -> void:
	rotation_degrees = 0
	
	# set_movement_target(movement_target_position)
	

	#if navigation_agent.is_navigation_finished():
	#	return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	# print(navigation_agent.is_navigation_finished(), "   current: ", current_agent_position, " next: ", next_path_position)
	var movement: Vector2 = position - lastpos
	lastpos = position
	
	if movement.length() < 0.1 and not navigation_agent.is_navigation_finished():
		set_movement_target(movement_target_position)

	linear_velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	current_movement_speed = movement.length()
	# move_and_collide(velocity)

func _process(delta: float) -> void:
	image_root.scale.y = 1+sin(id+Time.get_ticks_msec()/1000.0*10.0)*0.1
	image_root.rotation_degrees = sin(id+Time.get_ticks_msec()/1000.0*16.0)*5*current_movement_speed
	sprite_2d.z_index = int(position.y)

func get_need_location() -> Building:
	var nodes: Array
	var closestNode: Building
	for child in building_root.get_children():
		if child is Building:
			if child.need_type == needs[0]:
				if closestNode == null:
					closestNode = child
				if child.global_position.distance_to(global_position) < closestNode.global_position.distance_to(global_position):
					closestNode = child
	return closestNode
