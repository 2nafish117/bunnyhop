class_name FpPlayer
extends KinematicBody

# used only for interactions with other rigidbodies
export(float) var mass: float = 150.0

onready var fp_input := $FpInput
onready var fp_movement := $FpMovement
onready var fp_camera := $FpCamera

# needed to draw movement arrows
var velocity_prev: Vector3
var velocity_now: Vector3

var move_direction_prev: Vector3
var move_direction_now: Vector3

func update_movement_settings() -> void:
	fp_camera.mouse_horizontal_sensitivity = PlayerMovementSettings.mouse_horizontal_sensitivity
	fp_camera.mouse_vertical_sensitivity = PlayerMovementSettings.mouse_vertical_sensitivity
	fp_movement.speed_ground_max = PlayerMovementSettings.speed_ground_max
	fp_movement.speed_air_max = PlayerMovementSettings.speed_air_max
	fp_movement.speed_jump = PlayerMovementSettings.speed_jump
	fp_movement.accel_ground_max = PlayerMovementSettings.accel_ground_max
	fp_movement.accel_air_max = PlayerMovementSettings.accel_air_max
	fp_movement.friction_ground = PlayerMovementSettings.friction_ground
	fp_movement.friction_air = PlayerMovementSettings.friction_air
	fp_movement.gravity = PlayerMovementSettings.gravity
	
func _ready() -> void:
	var _err = PlayerMovementSettings.connect("player_movement_settings_changed", self, "update_movement_settings")
	if _err != OK:
		print_debug("something isnt connected right")
	# copies movement settings from autoload here!!
	update_movement_settings()

func draw_movement_arrows() -> void:
	var interpolated_velocity = velocity_prev.linear_interpolate(velocity_now, Engine.get_physics_interpolation_fraction())
	var from: Vector3 = fp_camera.get_interpolated_global_transform().origin + Vector3.DOWN * 1.0
	var to: Vector3 = from + interpolated_velocity * 0.10
	DbgDraw.draw_arrow(from, to, Color(1.0, 0.0, 0.0, 0.7))
	
	from += Vector3.UP * 0.1
	var interpolated_move_direction = move_direction_prev.linear_interpolate(move_direction_now, Engine.get_physics_interpolation_fraction())
	DbgDraw.draw_arrow(from, from + interpolated_move_direction * 0.5, Color(0.0, 1.0, 0.0, 0.7))

func _process(_delta: float) -> void:
	draw_movement_arrows()

func _physics_process(delta: float) -> void:
	
	fp_input.update_input(delta)
	fp_movement.update_movement(self, delta)
	
	velocity_prev = velocity_now
	velocity_now = fp_movement.velocity
		
	$FpHud.set_speed(velocity_now.length())
	$FpHud.set_top_speed(fp_movement.top_speed)
	$FpHud.set_projection(fp_movement.projection)
	$FpHud.set_angle(rad2deg(fp_movement.velocity_move_direction_angle))
	
	move_direction_prev = move_direction_now
	move_direction_now = fp_movement.move_direction
	
