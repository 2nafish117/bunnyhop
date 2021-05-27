extends Panel

onready var main_menu := get_parent().get_node("MainMenu")
onready var settings_menu := get_parent().get_node("SettingsMenu")
onready var level_select_menu := get_parent().get_node("LevelSelectMenu")
onready var levels := $VBoxContainer/Levels

func _ready() -> void:
	visible = false

func _on_Back_pressed() -> void:
	level_select_menu.visible = false
	main_menu.visible = true

