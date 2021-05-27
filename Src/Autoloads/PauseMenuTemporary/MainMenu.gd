extends Panel

signal toggle_pause

onready var main_menu := get_parent().get_node("MainMenu")
onready var settings_menu := get_parent().get_node("SettingsMenu")
onready var level_select_menu := get_parent().get_node("LevelSelectMenu")

func _on_Select_Level_pressed() -> void:
	main_menu.visible = false
	level_select_menu.visible = true
	pass # Replace with function body.


func _on_Settings_pressed() -> void:
	main_menu.visible = false
	settings_menu.visible = true
	pass # Replace with function body.


func _on_Quit_pressed() -> void:
	get_tree().quit(0)


func _on_Resume_pressed() -> void:
	emit_signal("toggle_pause")
