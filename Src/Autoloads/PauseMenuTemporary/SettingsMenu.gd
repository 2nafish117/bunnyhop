extends Panel

onready var main_menu := get_parent().get_node("MainMenu")
onready var settings_menu := get_parent().get_node("SettingsMenu")
onready var level_select_menu := get_parent().get_node("LevelSelectMenu")

onready var resolution := $VBoxContainer/Resolution
onready var fullscreen := $VBoxContainer/Fullscreen
onready var mouse_sens := $VBoxContainer/MouseSensitivity
onready var controller_sens := $VBoxContainer/ControllerSensitivity

func _ready() -> void:
	visible = false

func _on_Back_pressed() -> void:
	settings_menu.visible = false
	main_menu.visible = true

#OS.window_fullscreen = settings.fullscreen
#get_tree().set_screen_stretch(
#	SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, settings.resolution
#)
#OS.set_window_size(settings.resolution)
#OS.vsync_enabled = settings.vsync

# set resolution
func _on_OptionButton_item_selected(_index: int) -> void:
	var text: String = resolution.get_node("OptionButton").text
	var res := text.split_floats("x", false)
	get_viewport().set_size(Vector2(res[0], res[1]))
	#get_tree().set_screen_stretch(
	#	SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, Vector2(res[0], res[1])
	#)

# set fullscreen
func _on_CheckBox_toggled(button_pressed: bool) -> void:
	OS.window_fullscreen = button_pressed

