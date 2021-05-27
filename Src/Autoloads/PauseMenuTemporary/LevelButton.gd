extends Button

export(PackedScene) var scene

func _ready() -> void:
	if scene != null:
		text = scene.resource_path

func _on_Button_pressed() -> void:
	if scene == null:
		return
	var _grabage := get_tree().change_scene_to(scene)
	owner.main_menu.visible = true
	owner.visible = false
	
