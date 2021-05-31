extends VBoxContainer

export(Color) var default_color = Color(1, 1, 1, 0.588235)
export(Color) var pressed_color = Color(1, 0, 0, 0.784314)

onready var w_key := $top/W
onready var a_key := $bottom/A
onready var s_key := $bottom/S
onready var d_key := $bottom/D
onready var space_key := $bottom/Space

func _physics_process(_delta: float) -> void:
	if Input.get_action_strength("move_front") > 0:
		w_key.self_modulate = pressed_color
	else:
		w_key.self_modulate = default_color
	
	if Input.get_action_strength("move_left") > 0:
		a_key.self_modulate = pressed_color
	else:
		a_key.self_modulate = default_color
		
	if Input.get_action_strength("move_right") > 0:
		d_key.self_modulate = pressed_color
	else:
		d_key.self_modulate = default_color
		
	if Input.get_action_strength("move_back") > 0:
		s_key.self_modulate = pressed_color
	else:
		s_key.self_modulate = default_color
	
	if Input.get_action_strength("action_jump") > 0:
		space_key.self_modulate = pressed_color
	else:
		space_key.self_modulate = default_color
