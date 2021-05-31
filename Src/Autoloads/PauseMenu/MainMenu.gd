extends Panel

signal toggle_pause

onready var main_menu := get_parent().get_node("MainMenu")

onready var hsens_controls := $VBoxContainer/HSplitContainer/Controls/HSensControls
onready var vsens_controls := $VBoxContainer/HSplitContainer/Controls/VSensControls
onready var speed_ground_max_controls := $VBoxContainer/HSplitContainer/Controls/SpeedGroundMax
onready var speed_air_max_controls := $VBoxContainer/HSplitContainer/Controls/SpeedAirMax
onready var accel_ground_max_controls := $VBoxContainer/HSplitContainer/Controls/AccelGroundMax
onready var accel_air_max_controls := $VBoxContainer/HSplitContainer/Controls/AccelAirMax
onready var friction_ground_controls := $VBoxContainer/HSplitContainer/Controls/FrictionGround
onready var friction_air_controls := $VBoxContainer/HSplitContainer/Controls/FrictionAir
onready var gravity_controls := $VBoxContainer/HSplitContainer/Controls/Gravity
onready var speed_jump_controls := $VBoxContainer/HSplitContainer/Controls/SpeedJump

func _on_Quit_pressed() -> void:
	get_tree().quit(0)

func _on_Resume_pressed() -> void:
	emit_signal("toggle_pause")

func _ready() -> void:
	update_ui_controls()
	var _err = hsens_controls.connect("value_changed", self, "_on_HSensControls_value_changed")
	_err = vsens_controls.connect("value_changed", self, "_on_VSensControls_value_changed")
	_err = speed_ground_max_controls.connect("value_changed", self, "_on_SpeedGroundMax_value_changed")
	_err = speed_air_max_controls.connect("value_changed", self, "_on_SpeedAirMax_value_changed")
	_err = accel_ground_max_controls.connect("value_changed", self, "_on_AccelGroundMax_value_changed")
	_err = accel_air_max_controls.connect("value_changed", self, "_on_AccelAirMax_value_changed")
	_err = friction_ground_controls.connect("value_changed", self, "_on_FrictionGround_value_changed")
	_err = friction_air_controls.connect("value_changed", self, "_on_FrictionAir_value_changed")
	_err = gravity_controls.connect("value_changed", self, "_on_Gravity_value_changed")
	_err = speed_jump_controls.connect("value_changed", self, "_on_SpeedJump_value_changed")
	if _err != OK:
		print_debug("something isnt connected right")

func update_ui_controls() -> void:
	hsens_controls.set_value(PlayerMovementSettings.mouse_horizontal_sensitivity)
	vsens_controls.set_value(PlayerMovementSettings.mouse_vertical_sensitivity)
	speed_ground_max_controls.set_value(PlayerMovementSettings.speed_ground_max)
	speed_air_max_controls.set_value(PlayerMovementSettings.speed_air_max)
	accel_ground_max_controls.set_value(PlayerMovementSettings.accel_ground_max) 
	accel_air_max_controls.set_value(PlayerMovementSettings.accel_air_max)
	friction_ground_controls.set_value(PlayerMovementSettings.friction_ground)
	friction_air_controls.set_value(PlayerMovementSettings.friction_air)
	gravity_controls.set_value(PlayerMovementSettings.gravity)
	speed_jump_controls.set_value(PlayerMovementSettings.speed_jump)

func _on_ResetButton_pressed() -> void:
	PlayerMovementSettings.player_movement_settings_reset_default()
	update_ui_controls()


func _on_HSensControls_value_changed(value) -> void:
	PlayerMovementSettings.mouse_horizontal_sensitivity = value
	PlayerMovementSettings.emit_signal("player_movement_settings_changed")


func _on_VSensControls_value_changed(value) -> void:
	PlayerMovementSettings.mouse_vertical_sensitivity = value
	PlayerMovementSettings.emit_signal("player_movement_settings_changed")


func _on_SpeedGroundMax_value_changed(value) -> void:
	PlayerMovementSettings.speed_ground_max = value
	PlayerMovementSettings.emit_signal("player_movement_settings_changed")


func _on_SpeedAirMax_value_changed(value) -> void:
	PlayerMovementSettings.speed_air_max = value
	PlayerMovementSettings.emit_signal("player_movement_settings_changed")


func _on_AccelGroundMax_value_changed(value) -> void:
	PlayerMovementSettings.accel_ground_max = value
	PlayerMovementSettings.emit_signal("player_movement_settings_changed")


func _on_AccelAirMax_value_changed(value) -> void:
	PlayerMovementSettings.accel_air_max = value
	PlayerMovementSettings.emit_signal("player_movement_settings_changed")


func _on_FrictionGround_value_changed(value) -> void:
	PlayerMovementSettings.friction_ground = value
	PlayerMovementSettings.emit_signal("player_movement_settings_changed")


func _on_FrictionAir_value_changed(value) -> void:
	PlayerMovementSettings.friction_air = value
	PlayerMovementSettings.emit_signal("player_movement_settings_changed")


func _on_Gravity_value_changed(value) -> void:
	PlayerMovementSettings.gravity = value
	PlayerMovementSettings.emit_signal("player_movement_settings_changed")


func _on_SpeedJump_value_changed(value) -> void:
	PlayerMovementSettings.speed_jump = value
	PlayerMovementSettings.emit_signal("player_movement_settings_changed")

