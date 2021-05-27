class_name FpPlayer
extends KinematicBody

# used only for interactions with other rigidbodies
export(float) var mass: float = 150.0

onready var fp_input := $FpInput
onready var fp_movement := $FpMovement
onready var fp_camera := $FpCamera

var velocity_prev: Vector3
var velocity_now: Vector3

var move_direction_prev: Vector3
var move_direction_now: Vector3

func _ready() -> void:
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func draw_movement_arrows() -> void:
	var interpolated_velocity = velocity_prev.linear_interpolate(velocity_now, Engine.get_physics_interpolation_fraction())
	var from: Vector3 = fp_camera.get_interpolated_global_transform().origin + Vector3.DOWN * 1.0
	var to: Vector3 = from + interpolated_velocity * 0.15
	DbgDraw.draw_line(from, to)
	
	from += Vector3.UP * 0.1
	var interpolated_move_direction = move_direction_prev.linear_interpolate(move_direction_now, Engine.get_physics_interpolation_fraction())
	DbgDraw.draw_line(from, from + interpolated_move_direction * 0.5, Color(0.0, 1.0, 0.0, 1.0))
	
func _process(_delta: float) -> void:
	draw_movement_arrows()

func _physics_process(delta: float) -> void:
	
	fp_input.update_input(delta)
	fp_movement.update_movement(self, delta)
	
	velocity_prev = velocity_now
	velocity_now = fp_movement.velocity
	$FpHud.set_speed(velocity_now.length())
	
	move_direction_prev = move_direction_now
	move_direction_now = fp_movement.move_direction
