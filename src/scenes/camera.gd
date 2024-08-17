extends Camera2D

signal zoom_changed(new_zoom_factor: float)

var target_zoom: Vector2

func _ready() -> void:
	zoom = Vector2.ONE * 0.25
	target_zoom = zoom

func _process(delta: float) -> void:
	var oldZoom: Vector2 = zoom
	zoom = zoom.move_toward(target_zoom, delta*5)
	if oldZoom != zoom:
		zoom_changed.emit(zoom)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			target_zoom -= Vector2(0.1, 0.1)
			if target_zoom.x < 0.2:
				target_zoom = Vector2(0.2, 0.2)

		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			target_zoom += Vector2(0.1, 0.1)
