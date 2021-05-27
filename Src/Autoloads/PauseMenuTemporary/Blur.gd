extends TextureRect

func _ready() -> void:
	get_material().set_shader_param("amount", 0.0)

func blur(_darken_value: float, blur_value: float, duration: float):
	$Tween.interpolate_property(get_material(), "shader_param/amount", null, blur_value, duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	# $Tween2.interpolate_property(self, "self_modulate", null, Color(darken_value, darken_value, darken_value), duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	# $Tween2.start()
