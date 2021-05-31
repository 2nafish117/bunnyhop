extends HSplitContainer

export(float) var min_value := 0.0
export(float) var max_value := 100.0
export(float) var step := 1.0

onready var slider := $HSlider
onready var spin_box := $SpinBox

signal value_changed(value)

func set_value(val: float) -> void:
	slider.value = val

func _ready() -> void:
	slider.min_value = min_value
	slider.max_value = max_value
	slider.step = step
	slider.share(spin_box)
	#spin_box.min_value = min_value
	#spin_box.max_value = max_value
	#spin_box.step = step

func _on_HSlider_value_changed(val: float) -> void:
	emit_signal("value_changed", val)
