extends ViewportContainer

export(PackedScene) var main_scene

onready var render_texture := $RenderTexture
onready var viewport := $Viewport

func _ready() -> void:
	var scene = main_scene.instance()
	viewport.add_child(scene)
	pass
