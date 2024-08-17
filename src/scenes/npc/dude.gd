class_name Dude
extends RigidBody2D

enum NeedType {Poop, Eat, Entertainment, MedicalCare}

const SPLAT = preload("res://scenes/npc/splat.tscn")

@onready var sprite_2d: Sprite2D = $ImageRoot/Sprite2D
@onready var image_root: Node2D = $ImageRoot
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var area_2d: Area2D = $Area2D

var possible_dude_sprites : Array[Texture2D] = [preload("res://art/dude1.png"), preload("res://art/dude2.png"), preload("res://art/dude3.png"), preload("res://art/dude4.png")]

var movement_speed: float = 200.0
var current_movement_speed: float = 0.0
var movement_target_position: Vector2 = Vector2(60.0, 180.0)
var lastpos: Vector2
var id: int

var target_need_building: Building
var building_root: Node2D

var needs: Array = []

func initialize(position:Vector2, needs: Array, building_root: Node2D) -> void:
	self.position = position
	self.needs = needs
	self.building_root = building_root
	

func _ready() -> void:
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	_randomize_dude_sprite()

	# Make sure to not await during _ready.
	call_deferred("actor_setup")
	
	area_2d.connect("body_entered", _hit_building)
	
	id = randi()
	sprite_2d.modulate = Color(randf(), randf(), randf())
		
	target_need_building = get_need_location()
	
	movement_target_position = target_need_building.position+ Vector2(randf()*2-1, randf()*2-1)*35.0

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
	
	var target_velocity: Vector2 = current_agent_position.direction_to(next_path_position) * movement_speed;

	if movement.length() < 0.05 and not navigation_agent.is_navigation_finished():
		var bodies: Array[Node2D] = $Area2D.get_overlapping_bodies()
		for b in bodies:
			if b is RigidBody2D:
				var dir: Vector2 = position.direction_to(b.position)
				#b.apply_impulse(dir * 10)
		# position += target_velocity*0.1 #.move_toward(position+target_velocity, _delta*60)# target_velocity*0.1#apply_impulse(target_velocity * 150.0)
		#linear_velocity = target_velocity * 3.0
		set_movement_target(movement_target_position)

	linear_velocity = linear_velocity.move_toward(target_velocity, _delta*400)#lerp(linear_velocity, target_velocity, _delta*5)
	current_movement_speed = movement.length()
	# move_and_collide(velocity)
	lastpos = position

func _process(delta: float) -> void:
	image_root.scale.y = 1+sin(id+Time.get_ticks_msec()/1000.0*10.0)*0.1
	image_root.rotation_degrees = sin(id+Time.get_ticks_msec()/1000.0*16.0)*5*current_movement_speed
	sprite_2d.z_index = int(position.y)

func _hit_building(area: Node2D)->void:#area is the Area2D of the building
	if area.get_parent() is Building:
		var building: Building = area.get_parent()
		if building == target_need_building:
			needs.remove_at(0)
			if len(needs) == 0:
				_go_splat()
			else:
				target_need_building = get_need_location()
				set_movement_target(target_need_building.position + (Vector2(randf()*2-1, randf()*2-1))*15)

func _go_splat() -> void:
	var splat: Node2D = SPLAT.instantiate()
	splat.global_position = global_position
	var sprite: Sprite2D = splat.get_node("Sprite2D")
	sprite.modulate = sprite_2d.modulate
	get_parent().add_child(splat)
	self.queue_free()

func get_need_location() -> Building:
	$RichTextLabel.text = str(needs[0])
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
	
func get_random_need_location() -> Building:
	var nodes: Array
	var closestNode: Building
	for child in building_root.get_children():
		if child is Building:
			if child.need_type == needs[0]:
				nodes.append(child)
	return nodes.pick_random()
	
func _randomize_dude_sprite() -> void:
	sprite_2d.texture = possible_dude_sprites.pick_random()
	
