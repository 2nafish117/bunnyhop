class_name FpMovement
extends Node

export(float) var gravity: float = 10.0
export(float) var gravity_modifier = 1.0
export(float) var speed_ground_max: float = 8.0
var speed_ground_max_modifier: float = 1.0
export(float) var speed_air_max: float = 8.0
var speed_air_max_modifier: float = 1.0
export(float) var speed_jump: float = 4.2
var speed_jump_modifier: float = 1.0

export(float) var accel_ground_max: float = 140.0
var accel_ground_max_modifier: float = 1.0
export(float) var accel_air_max: float = 70.0
var accel_air_max_modifier: float = 1.0

export(float) var friction_ground: float = 12.0
var friction_ground_modifier: float = 1.0
export(float) var friction_air: float = 0.1
var friction_air_modifier: float = 1.0

export(float, 0.0, 90.0) var floor_angle := 40.0
export(float) var snap_to_floor: float = 0.1
var snap_to_floor_modifier: float = 1.0

var time: float = 0.0

var move_direction: Vector3
var velocity: Vector3
# needed for ui
var projection: float
var velocity_move_direction_angle: float

var contact_normals: Array
var contact_points: Array

func get_speed() -> float:
	return velocity.length()

func get_hspeed() -> float:
	return (velocity - velocity.project(Vector3.UP)).length()

func get_vspeed() -> float:
	return velocity.project(Vector3.UP).length()

func accelerate(var _velocity: Vector3, speed_max: float, accel_max: float, delta: float) -> Vector3:
	projection = _velocity.dot(move_direction)
	velocity_move_direction_angle = _velocity.angle_to(move_direction)
	var add_speed := clamp(speed_max - projection, 0.0, accel_max * delta)
	_velocity += add_speed * move_direction
	return _velocity

func friction(_velocity: Vector3, friction: float, _speed_stop: float, delta: float) -> Vector3:
	var speed := _velocity.length()
	if speed != 0.0:
		var control := max(_speed_stop, speed)
		var drop := control * friction * delta
		_velocity *= max(speed - drop, 0.0) / speed
	return _velocity

func movement_floor(player: FpPlayer, delta: float) -> void:
	var fp_input: FpInput = player.fp_input
	var floor_normal: Vector3 = player.get_floor_normal()
	# friction along floor
	var vel_perp_ground := velocity.project(floor_normal)
	var vel_along_ground := velocity - vel_perp_ground
	vel_along_ground = friction(vel_along_ground, friction_ground_modifier * friction_ground, 1.5, delta)
	# set velocity perpendicular to ground as 0
	vel_perp_ground = Vector3.ZERO
	velocity = vel_along_ground + vel_perp_ground
	
	# accelaerate along horizontal
	var vvel := velocity.project(Vector3.UP)
	var hvel := velocity - vvel
	hvel = accelerate(hvel, speed_ground_max_modifier * speed_ground_max, accel_ground_max_modifier * accel_ground_max, delta)

	if fp_input.queue_jump:
		vvel.y = speed_jump_modifier * speed_jump
		velocity = hvel + vvel
		velocity = player.move_and_slide(velocity, Vector3.UP, true, 4, deg2rad(floor_angle), false)
	else:
		velocity = hvel + vvel
		velocity = player.move_and_slide_with_snap(velocity, -floor_normal * snap_to_floor * snap_to_floor_modifier, Vector3.UP, true, 4, deg2rad(floor_angle), false)

func movement_air(player: FpPlayer, delta: float) -> void:
	#var fp_input: FpInput = player.fp_input
	var vvel := velocity.project(Vector3.UP)
	var hvel := velocity - vvel
	velocity = friction(velocity, friction_air_modifier * friction_air, 0.0, delta)
	hvel = accelerate(hvel, speed_air_max_modifier * speed_air_max, accel_air_max_modifier * accel_air_max, delta)

	#if fp_input.input_jump and time - time_since_on_floor <= time_coyote_jump:
	#	vvel.y = speed_jump_modifier * speed_jump
	
	velocity = hvel + vvel
	velocity += Vector3.DOWN * gravity * gravity_modifier * delta
	velocity = player.move_and_slide(velocity, Vector3.UP, true, 4, deg2rad(floor_angle), false)

func update_movement(player: FpPlayer, delta: float) -> void:
	time += delta
	var fp_cam_hbasis: Basis = player.fp_camera.get_hbasis()
	var fp_input: FpInput = player.fp_input
	move_direction = fp_cam_hbasis.x * fp_input.input_move.x + fp_cam_hbasis.z * fp_input.input_move.z
	move_direction = move_direction.normalized()
	
	if player.is_on_floor():
		movement_floor(player, delta)
	else:
		movement_air(player, delta)
	
	contact_normals = []
	contact_points = []
	for idx in player.get_slide_count():
		var coll := player.get_slide_collision(idx)
		var n := coll.normal
		var p := coll.position
		contact_normals.append(n)
		contact_points.append(p)
		if coll.collider is RigidBody:
			var obj: RigidBody = coll.collider
			var imp: Vector3 = -n * 1.0
			obj.set_sleeping(false)
			obj.apply_impulse(p - obj.global_transform.origin, imp)
		
	
