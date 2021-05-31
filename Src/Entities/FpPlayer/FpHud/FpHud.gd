extends CanvasLayer

onready var speed_label := $MousePassHud/Mid/Speed
onready var projection_label := $MousePassHud/Top/Projection
onready var angle_label := $MousePassHud/Top/Angle

func set_projection(val: float) -> void:
	projection_label.text = "projection: " + String(val).pad_decimals(2)

func set_angle(val: float) -> void:
	angle_label.text = "angle: " + String(val).pad_decimals(2) + " deg"

func set_speed(val: float) -> void:
	speed_label.text = String(val).pad_decimals(1)
	var weight = val / 25.0
	speed_label.self_modulate = lerp(Color(1.0, 1.0, 1.0, 1.0), Color(1.0, 0.4, 0.2, 1.0), weight)
