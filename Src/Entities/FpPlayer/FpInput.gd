class_name FpInput
extends Node

var input_move: Vector3
var input_jump: bool
var queue_jump: bool
var input_interact: bool

var fire_primary_just_pressed: bool
var fire_primary_pressed: bool
var fire_primary_just_released: bool
	
var fire_secondary_just_pressed: bool
var fire_secondary_pressed: bool
var fire_secondary_just_released: bool

var time: float = 0.0
var time_jump: float = -1.0
var time_jump_buffer: float = 0.16

func update_input(delta: float) -> void:
	time += delta
	input_move = Vector3(
		+Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0.0,
		-Input.get_action_strength("move_front") + Input.get_action_strength("move_back")
	)
	input_move = input_move.normalized()
	
	input_interact = Input.is_action_just_pressed("action_interact")
	input_jump = Input.is_action_just_pressed("action_jump")
	
	if input_jump:
		time_jump = time
	queue_jump = (time - time_jump <= time_jump_buffer)
	
	fire_primary_just_pressed = Input.is_action_just_pressed("fire_primary")
	fire_primary_pressed = Input.is_action_pressed("fire_primary")
	fire_primary_just_released = Input.is_action_just_released("fire_primary")
	
	fire_secondary_just_pressed = Input.is_action_just_pressed("fire_secondary")
	fire_secondary_pressed = Input.is_action_pressed("fire_secondary")
	fire_secondary_just_released = Input.is_action_just_released("fire_secondary")

