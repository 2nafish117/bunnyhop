extends Node

signal player_movement_settings_changed

# they are just set here for no reason, actual values come from FpCamera.gd
# to change it in project, go there and change
var mouse_horizontal_sensitivity: float = 1.0
var mouse_vertical_sensitivity: float = 1.0

# they are just set here for no reason, actual values come from FpMovement.gd
# to change it in project, go there and change
var speed_ground_max: float = 8.0
var speed_air_max: float = 8.0

var speed_jump: float = 4.2

var accel_ground_max: float = 140.0
var accel_air_max: float = 70.0

var friction_ground: float = 12.0
var friction_air: float = 0.1
var gravity: float = 10.0

func player_movement_settings_reset_default() -> void:
	# do not reset mouse sensitivity!!
	speed_ground_max = 8.0
	speed_air_max = 8.0

	speed_jump = 4.2

	accel_ground_max = 140.0
	accel_air_max = 70.0

	friction_ground = 12.0
	friction_air = 0.1
	gravity = 10.0

	emit_signal("player_movement_settings_changed")


