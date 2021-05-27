extends CanvasLayer

onready var game_paused := false
onready var blur := $Blur
onready var menus := $PauseMenuTemporary

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pause_mode = Node.PAUSE_MODE_PROCESS
	menus.visible = false

func toggle_pause():
	game_paused = not game_paused
	get_tree().paused = game_paused
	menus.visible = game_paused
	if game_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		blur.blur(0.7, 3.0, 0.1)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		blur.blur(1.0, 0.0, 0.1)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause()

func _on_MainMenu_toggle_pause() -> void:
	toggle_pause()
