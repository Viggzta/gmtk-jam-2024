extends Camera2D

var target_zoom: Vector2
var target_position: Vector2
var last_mouse: Vector2

@export var max_zoom: float = 1.5
@export var min_zoom: float = 0.25

func _ready() -> void:
	zoom = Vector2.ONE * 0.5
	target_zoom = zoom
	last_mouse = get_local_mouse_position()

func _process(delta: float) -> void:
	Globals.camera_shake -= delta * 15
	Globals.camera_shake = clamp(Globals.camera_shake, 0, 5)
	offset = Vector2(
		randf_range(-Globals.camera_shake, Globals.camera_shake),
		randf_range(-Globals.camera_shake, Globals.camera_shake)) * 10
	
	var oldZoom: Vector2 = zoom
	zoom = zoom.move_toward(target_zoom, delta*5)

	var normalized_zoom: float = (zoom.x - min_zoom) / (max_zoom - min_zoom)
	var camera_speed: float = 5.0 * ((1.0 - normalized_zoom) + 1.0)
	if Input.is_action_pressed("left"):
		target_position.x -= camera_speed
	if Input.is_action_pressed("right"):
		target_position.x += camera_speed
	if Input.is_action_pressed("down"):
		target_position.y += camera_speed
	if Input.is_action_pressed("up"):
		target_position.y -= camera_speed
	
	var mouse: Vector2 = get_local_mouse_position()
	var diff: Vector2 = mouse - last_mouse
	last_mouse = mouse
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		target_position -= diff
		
	position = target_position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			target_zoom -= Vector2(0.1, 0.1)
			if target_zoom.x < min_zoom:
				target_zoom = Vector2(min_zoom, min_zoom)

		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			target_zoom += Vector2(0.1, 0.1)
			if target_zoom.x > max_zoom:
				target_zoom = Vector2(max_zoom, max_zoom)
