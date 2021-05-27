extends CanvasLayer

onready var speed_label := $MousePassHud/Top/Speed

func set_speed(val: float) -> void:
	speed_label.text = String(val).pad_decimals(1)
