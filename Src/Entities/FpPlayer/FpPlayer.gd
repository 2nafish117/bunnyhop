class_name FpPlayer
extends KinematicBody

# used only for interactions with other rigidbodies
export(float) var mass: float = 150.0

onready var fp_input := $FpInput
onready var fp_movement := $FpMovement
onready var fp_camera := $FpCamera

var velocity_prev: Vector3
var velocity_now: Vector3

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	var interpolated_velocity = velocity_prev.linear_interpolate(velocity_now, Engine.get_physics_interpolation_fraction())
	var from: Vector3 = fp_camera.get_interpolated_global_transform().origin + Vector3.DOWN * 1.1
	var to: Vector3 = from + interpolated_velocity * 0.15
	DbgDraw.draw_line(from, to)
	
	DbgDraw.draw_line(from, from + fp_movement.move_direction * 0.5, Color(0.0, 1.0, 0.0, 1.0))

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	fp_input.update_input(delta)
	fp_movement.update_movement(self, delta)
	
	velocity_prev = velocity_now
	velocity_now = fp_movement.velocity
